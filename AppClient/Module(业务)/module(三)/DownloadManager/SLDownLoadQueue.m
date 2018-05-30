//
//  SLDownLoadQueue.m
//  SLMultiDownLoadManager
//
//  Created by sunlei on 16/8/3.
//  Copyright © 2016年 sunlei. All rights reserved.
//

#import "SLDownLoadQueue.h"
#import "DownLoadTools.h"
#import "SLSessionManager.h"
#import "SLFileManager.h"
#import "AppDelegate.h"

NSString *const DownLoadArchiveKey = @"DownLoadQueueArr";
NSString *const CompletedDownLoadArchiveKey = @"CompletedDownLoadQueueArr";
NSString *const DownLoadResourceFinished = @"DownLoadResourceFinished";

@implementation SLDownLoadQueue{

    //最大同时下载数量3个以内最好，默认三个，这个数还是不要改了，骚年
    NSInteger _maxDownLoadTask;
    NSURLSessionDownloadTask *_downloadTask;
}


-(instancetype)init{
    if (self = [super init]) {
        //默认同时下载数量为1，不易过多而导致开辟太多线程
        _maxDownLoadTask = 3;
    }
    return self;
}

-(SLDownLoadModel *)nextDownLoadModel{
    
    for (SLDownLoadModel *model in self.downLoadQueueArr) {
        if (DownLoadStateWaiting == model.downLoadState) {
            return model;
        }
    }
    return nil;
}

//刷新下载
-(void)updateDownLoad{

    //统计当前正在下载任务的个数
    int i = 0;
    for (SLDownLoadModel *model in self.downLoadQueueArr) {
        if (DownLoadStateDownloading == model.downLoadState) {
            i++;
        }
    }
    //新增下载任务
    for (int m = 0; m < _maxDownLoadTask - i; m++) {
        [self startDownload];
    }
}

#pragma mark - 添加下载任务到下载队列中

-(void)addDownLoadTaskWithModel:(SLDownLoadModel *)model{
    //SLog(@"%p",model);
    
    if (![self.downLoadQueueArr containsObject:model] && ![self.completedDownLoadQueueArr containsObject:model] && model) {
        
        for (SLDownLoadModel *modelTmp in self.downLoadQueueArr) {
            if ([modelTmp.resourceID isEqualToString:model.resourceID]) {
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您已经下载过该视频或者正在下载该视频" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
                
                return;
            }
        }
        
        SLDownLoadModel *modelTmp = model;
        //SLog(@"%p",modelTmp);
        
        modelTmp.downLoadTask = nil;
        modelTmp.downLoadState = DownLoadStateWaiting;
        
        modelTmp.totalByetes = 0.f;
        modelTmp.downLoadedByetes = 0.f;
        modelTmp.downLoadSpeed = 0.f;
        modelTmp.downLoadProgress = 0.f;
//        modelTmp.resumeDataPath = nil;
        
        //SLog(@"%@",modelTmp.fileUUID);
        [self.downLoadQueueArr addObject:modelTmp];
        [self updateDownLoad];
        
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您已经下载过该视频或者正在下载该视频或为nil" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}

//下载完成
-(void)completedDownLoadWithModel:(SLDownLoadModel *)model{
    
    //将已经下载完成的任务添加到下载完成数据源
    if ([self.downLoadQueueArr containsObject:model]) {
        
        //需要把此属性置空才能归档
        [model.downLoadTask cancel];
        model.downLoadTask = nil;
        [self.completedDownLoadQueueArr addObject:model];
        [self.downLoadQueueArr removeObject:model];
        
        //描述文件路径
        NSString *fullPath = [[SLFileManager getDownloadCacheDir] stringByAppendingPathComponent:model.resourceID];
        //描述文件对应的缓存资源路径
        NSDictionary *resumeDataDic = [NSDictionary dictionaryWithContentsOfFile:fullPath];
        //断点续传的描述文件中对应的的资源缓存文件，默认是存放在系统的tmp目录下
        NSString *resumeDataTmpName = resumeDataDic[@"NSURLSessionResumeInfoTempFileName"];
        NSString *resumeDataTmpPath = [[SLFileManager getTmpPath] stringByAppendingPathComponent:resumeDataTmpName];
        
        //删除对应的资源缓存文件，虽然系统会自动删除，不过我还是想删除
        if ([SLFileManager isExistPath:resumeDataTmpPath] && resumeDataTmpName.length != 0) {
            [SLFileManager deletePathWithName:resumeDataTmpPath];
        }
        
        //移除用于断点续传的文件
        if ([SLFileManager isExistPath:fullPath] && (model.resourceID.length != 0)) {
            [SLFileManager deletePathWithName:fullPath];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:DownLoadResourceFinished object:nil];
    }

    //为保险起见每下载一次就要进行归档
    [DownLoadTools archiveDownLoadModelArrWithModelArr:self.completedDownLoadQueueArr withKey:CompletedDownLoadArchiveKey andPath:CompletedDownLoad_Archive_Path];
    
    //刷新
    [self updateDownLoad];
}

#pragma mark - 执行下载
-(void)startDownload{
    
    SLDownLoadModel *model = [self nextDownLoadModel];
    if (nil == model) return;
    
    if ([self isValidResumeDataByModel:model]) {
        //断点续传
        [self downLoadResumeDataWithModel:model];
    }else{
        //重新下载
        [self downLoadNewTaskWithModel:model];
    }
}

//判断是否是有效的缓存，为NO则标示不能用于断点续传
-(BOOL)isValidResumeDataByModel:(SLDownLoadModel *)model{
    
    if (model.resumeDataPath && model.resumeDataPath.length>0) {
        
        NSDictionary *resumeDataDic = [NSDictionary dictionaryWithContentsOfFile:model.resumeDataPath];
        //断点续传的描述文件中对应的的资源缓存文件，默认是存放在系统的tmp目录下
        NSString *resumeDataTmpName = resumeDataDic[@"NSURLSessionResumeInfoTempFileName"];
        NSString *resumeDataTmpPath = [[SLFileManager getTmpPath] stringByAppendingPathComponent:resumeDataTmpName];
        
        //NSLog(@"--%@--\n--%@",resumeDataTmpName,resumeDataDic);
        
        if ([SLFileManager isExistPath:resumeDataTmpPath] && resumeDataTmpName.length > 0) {
            
            return YES;
        }else{
            //清楚无效的断点续传描述文件
            [SLFileManager deletePathWithName:model.resumeDataPath];
            
            return NO;
        }
    }
    return NO;
}

//断点续传
-(void)downLoadResumeDataWithModel:(SLDownLoadModel *)model{
    
    __weak typeof(self) weakSelf = self;
    __block NSDate *oldDate = [NSDate date]; //记录上次的数据回传的时间
    __block float  downLoadBytesTmp = 0;     //记录上次数据回传的大小

    NSString *fullPath = [[SLFileManager getDownloadCacheDir] stringByAppendingPathComponent:model.resourceID];
    NSError *err = nil;
    NSData *resumeData = [NSData dataWithContentsOfFile:fullPath options:NSDataReadingMappedIfSafe error:&err];
    if (err) {
        SLog(@"%@",err.localizedDescription);
        return;
    }
    
    //当网络发生改变的时候，该回调会被调用
    [self.sessionManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status != AFNetworkReachabilityStatusReachableViaWiFi) {
            //先暂停所有的下载
            [SLDownLoadQueue pauseAll];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您现在是非WiFi网络，要继续下载吗" delegate:weakSelf cancelButtonTitle:@"继续" otherButtonTitles:@"取消", nil];
            alert.tag = 666655;
            [alert show];
        }
    }];
    
    model.downLoadTask = [self.sessionManager  downloadTaskWithResumeData:resumeData progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"下载中。。。。。。%lld",downloadProgress.completedUnitCount);
        model.downLoadedByetes = downloadProgress.completedUnitCount; //已经下载的
        model.totalByetes = downloadProgress.totalUnitCount; //总大小
        model.downLoadProgress = model.downLoadedByetes/model.totalByetes; //下载百分比进度
        
        NSDate *currentDate = [NSDate date];
        double num = [currentDate timeIntervalSinceDate:oldDate]; //时间差，就是本次block被调用的时间减去上一次该block被调用的时间
        if ( num >= 1) { //时间差大于一秒后再更新数据，不然会导致UI上显示的数据变化过快，看着极为不爽
            model.downLoadSpeed = (model.downLoadedByetes - downLoadBytesTmp)/num;
            
            downLoadBytesTmp = model.downLoadedByetes;
            oldDate = currentDate;
        }
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //注意：：：
        //若在此处发送下载完成的通知，当下载任务完成之后，等一会程序会崩溃，这个问题困扰了我好几小时，my god
        
        //此处只会调用一次，当下载完成后调用
        model.downLoadState = DownLoadStateDownloadfinished;
        //model.downLoadedByetes = model.totalByetes;
        //model.downLoadProgress = 1;
        
        NSString *destinationStr = [[SLFileManager getDownloadRootDir] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",model.resourceID]];
        return [NSURL fileURLWithPath:destinationStr];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //此处在下载完成和取消下载的时候都会被调用
        //一定要做判断
        
        if (model.downLoadState == DownLoadStateDownloadfinished) {
            [weakSelf completedDownLoadWithModel:model];
        }
    }];

    [model.downLoadTask resume]; //开始下载
    model.downLoadState = DownLoadStateDownloading;
}

//开启新下载任务
-(void)downLoadNewTaskWithModel:(SLDownLoadModel *)model{
    
    __weak typeof(self) weakSelf = self;
    __block NSDate *oldDate = [NSDate date]; //记录上次的数据回传的时间
    __block float  downLoadBytesTmp = 0;     //记录上次数据回传的大小

    //当网络发生改变的时候，该回调会被调用
    [self.sessionManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status != AFNetworkReachabilityStatusReachableViaWiFi) {
            //先暂停所有的下载
            [SLDownLoadQueue pauseAll];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您现在是非WiFi网络，要继续下载吗" delegate:weakSelf cancelButtonTitle:@"继续" otherButtonTitles:@"取消", nil];
            alert.tag = 666655;
            [alert show];
        }
    }];

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:model.downLoadUrlStr]];
    
    model.downLoadTask = [self.sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"下载中___。。。。。。%lld-----共++++%lld",downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
        //NSLog(@"===========%@",[NSThread currentThread]);
        model.downLoadedByetes = downloadProgress.completedUnitCount; //已经下载的
        model.totalByetes = downloadProgress.totalUnitCount; //总大小
        model.downLoadProgress = model.downLoadedByetes/model.totalByetes; //下载百分比进度
        
        NSDate *currentDate = [NSDate date];
        double num = [currentDate timeIntervalSinceDate:oldDate]; //时间差，就是本次block被调用的时间减去上一次该block被调用的时间
        if ( num >= 1) {
            model.downLoadSpeed = (model.downLoadedByetes - downLoadBytesTmp)/num;
            downLoadBytesTmp = model.downLoadedByetes;
            oldDate = currentDate;
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //注意：：：
        //若在此处发送下载完成的通知，当下载任务完成之后，等一会程序会崩溃，这个问题困扰了我好几小时，my god
        
        //此处只会调用一次，当下载完成后调用
        model.downLoadState = DownLoadStateDownloadfinished;
        //model.downLoadedByetes = model.totalByetes;
        //model.downLoadProgress = 1;
        
        NSString *destinationStr = [[SLFileManager getDownloadRootDir] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",model.resourceID]];
        
        return [NSURL fileURLWithPath:destinationStr];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //此处在下载完成和取消下载的时候都会被调用
        if (model.downLoadState == DownLoadStateDownloadfinished) {
            NSLog(@"下载完成++++++");
            [weakSelf completedDownLoadWithModel:model];
        }
    }];
    
    [model.downLoadTask resume]; //开始下载
    model.downLoadState = DownLoadStateDownloading;
}

#pragma mark - 暂停下载
//暂停某个下载任务
-(void)pauseWithDownLoadModel:(SLDownLoadModel *)model{
    //如果在下载状态或者等待下载状态则暂停
    if (DownLoadStateDownloading == model.downLoadState) {
        __weak typeof(self) weakSelf = self;
        //取消是异步的
         NSLog(@"*-----(((((((((((())))))))))-%@",model.downLoadTask);
        NSURLSessionDownloadTask *downLoadTask = model.downLoadTask;
        [downLoadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
            NSString *cachePath = [[SLFileManager getDownloadCacheDir] stringByAppendingPathComponent:model.resourceID];
            [resumeData writeToFile:cachePath atomically:YES];
//            model.resumeDataPath = cachePath;
            //置空，防止归档时出错
            model.downLoadTask = nil;
            //更改为暂停状态
            model.downLoadState = DownLoadStatePause;
            //更新下载
            [weakSelf updateDownLoad];
            
            NSLog(@"~~~~~~~~~~~~~---%@+++~~~~~~~~~~~~~~~",[NSThread currentThread]);
        }];
    }else{ //DownLoadStateWaiting
        
        model.downLoadState = DownLoadStatePause;
        [self updateDownLoad];
    }
}


#pragma mark - 懒加载
-(NSMutableArray<SLDownLoadModel *> *)downLoadQueueArr{
    
    if (!_downLoadQueueArr) {
        _downLoadQueueArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _downLoadQueueArr;
}

-(NSMutableArray<SLDownLoadModel *> *)completedDownLoadQueueArr{
    if (!_completedDownLoadQueueArr) {
        _completedDownLoadQueueArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _completedDownLoadQueueArr;
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 0) {
        [SLDownLoadQueue startDownloadAll];
    }else if (buttonIndex == 1) {
        [DownLoadTools archiveDownLoadModelArrWithModelArr:self.downLoadQueueArr withKey:DownLoadArchiveKey andPath:DownLoad_Archive_Path];
    }
}

#pragma mark - 工具接口API

//添加一个下载
+(void)addDownLoadTaskWithModel:(SLDownLoadModel *)model{
    [[SLDownLoadQueue downLoadQueue] addDownLoadTaskWithModel:model];
}

//删除一个下载
+(void)deleteDownLoadWithModel:(SLDownLoadModel *)model{
    
    SLDownLoadQueue *queue = [SLDownLoadQueue downLoadQueue];
    if (model.downLoadState == DownLoadStateDownloadfinished) {
        
        NSString *videoName = [NSString stringWithFormat:@"%@.mp4",model.resourceID];
        NSString *videoPath = [[SLFileManager getDownloadRootDir] stringByAppendingPathComponent:videoName];
        if (model.resourceID.length != 0) {
            [SLFileManager deletePathWithName:videoPath];
        }
        
        [queue.completedDownLoadQueueArr removeObject:model];
        //归档已经下载完的
        [DownLoadTools archiveDownLoadModelArrWithModelArr:queue.completedDownLoadQueueArr withKey:CompletedDownLoadArchiveKey andPath:CompletedDownLoad_Archive_Path];
    }else{
        
        if (model.downLoadState == DownLoadStateDownloading) {
            if (model.downLoadTask) {
                [model.downLoadTask cancel];
            }
        }
        
        NSString *resumeDataName = [[SLFileManager getDownloadCacheDir] stringByAppendingPathComponent:model.resourceID];
        
        if ([SLFileManager isExistPath:resumeDataName] && (model.resourceID.length != 0)) {
            [SLFileManager deletePathWithName:resumeDataName];
        }
        [queue.downLoadQueueArr removeObject:model];
        
        [queue updateDownLoad];
    }
}

//开始或暂停下载
+(void)startOrStopDownloadWithModel:(SLDownLoadModel *)model{
    
    SLDownLoadQueue *queue = [SLDownLoadQueue downLoadQueue];
    switch (model.downLoadState) {
        case DownLoadStateDownloading:
        {
            [queue pauseWithDownLoadModel:model]; //以断点续传的方式暂停
        }
            break;
        case DownLoadStateWaiting:
        {
            model.downLoadState = DownLoadStatePause;
            [queue updateDownLoad];
        }
            break;
        case DownLoadStatePause:
        {
            model.downLoadState = DownLoadStateWaiting;
            [queue updateDownLoad];
        }
            break;
            
        default:
            
            break;
    }
}

//开始所有下载
+(void)startDownloadAll{
    
    SLDownLoadQueue *queue = [SLDownLoadQueue downLoadQueue];
    for (SLDownLoadModel *model in queue.downLoadQueueArr) {
        
        if (model.downLoadState != DownLoadStateDownloading) {
            model.downLoadState = DownLoadStateWaiting;
        }
    }
    [queue updateDownLoad];
}

//全部暂停
+(void)pauseAll{
    
    SLDownLoadQueue *queue = [SLDownLoadQueue downLoadQueue];
    for (SLDownLoadModel *model in queue.downLoadQueueArr) {
        
        if ((model.downLoadState == DownLoadStateDownloading) || (model.downLoadState == DownLoadStateWaiting)) {
//            NSLog(@"___~~~~~~~~-%ld",model.downLoadState);
            [queue pauseWithDownLoadModel:model];
        }
    }
}

//刷新下载
+(void)updateDownLoad{
    [[SLDownLoadQueue downLoadQueue] updateDownLoad];
}

//要在Appledelegate：didFinish中调用，以读取已经下载的model和短点的model
+(void)getDownLoadCache{
    
    //读取下载任务，以及已经下载完成的
    SLDownLoadQueue *queue = [SLDownLoadQueue downLoadQueue];
    [queue.completedDownLoadQueueArr removeAllObjects];
    [queue.downLoadQueueArr removeAllObjects];
    
    if ([SLFileManager isExistPath:CompletedDownLoad_Archive_Path]) {
        //解归档 以前已下载完的
        NSMutableArray *completeDownLoadArrTmp = [DownLoadTools unArchiveDownLoadModelArrWithKey:CompletedDownLoadArchiveKey andPath:CompletedDownLoad_Archive_Path];
        if (completeDownLoadArrTmp) {
            
            for (SLDownLoadModel *model in completeDownLoadArrTmp) {
                NSString *path = [[SLFileManager getDownloadRootDir] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",model.resourceID]];
                if ([SLFileManager isExistPath:path]) {
                    [queue.completedDownLoadQueueArr addObject:model];
                }
            }
        }
    }
    
    if ([SLFileManager isExistPath:DownLoad_Archive_Path]) {
        //解归档 以前没下载完的
        NSMutableArray *downLoadArrTmp = [DownLoadTools unArchiveDownLoadModelArrWithKey:DownLoadArchiveKey andPath:DownLoad_Archive_Path];
        if (downLoadArrTmp) {
            
            for (SLDownLoadModel *model in downLoadArrTmp) {
                [queue.downLoadQueueArr addObject:model];
            }
        }
        //读完之后删除
        [SLFileManager  deletePathWithName:DownLoad_Archive_Path];
    }
}

+(void)appWillTerminate{
    
    SLog(@"app将要被杀死。。。。111--%@",[NSThread currentThread]);
    SLDownLoadQueue *downQueue = [SLDownLoadQueue downLoadQueue];
    dispatch_queue_t queue =  dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    //将任务异步地添加到group中去执行
    dispatch_group_async(group,queue,^{
        [SLDownLoadQueue pauseAll];
        SLog(@"都取消完毕了。。。。11");
    });
    //会同步的等待组内所有任务完成，切记不要用异步的dispatch_group_notify
    dispatch_group_wait(group,DISPATCH_TIME_FOREVER);
    SLog(@"都取消完毕了。。。。222");
    
    for (SLDownLoadModel *model in downQueue.downLoadQueueArr) {
        model.downLoadTask = nil;
    }
    //归档正在下载或等待下载的
    [DownLoadTools archiveDownLoadModelArrWithModelArr:downQueue.downLoadQueueArr withKey:DownLoadArchiveKey andPath:DownLoad_Archive_Path];
    
    //归档已经下载完的
    [DownLoadTools archiveDownLoadModelArrWithModelArr:downQueue.completedDownLoadQueueArr withKey:CompletedDownLoadArchiveKey andPath:CompletedDownLoad_Archive_Path];
    SLog(@"app将要被杀死。。。。222--%@",[NSThread currentThread]);

}

//单例API
+(SLDownLoadQueue *)downLoadQueue{
    
    static SLDownLoadQueue *queue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = [[SLDownLoadQueue alloc]init];
    });
    
    return queue;
}

-(SLSessionManager *)sessionManager{
    
    SLSessionManager *sessionManager = [SLSessionManager sessionManager];
    return sessionManager;
}

/****************************************************************************************/

#pragma mark --- 文件下载
/**
 *  使用NSURLSessionDownloadTask下载文件过程中注意:
 下载文件之后会自动保存到一个临时目录中, 需要自己将文件重新放到其他指定的目录中
 */
- (void)downLoadFile
{
    // 创建url
    NSString *urlStr =[NSString stringWithFormat:@"%@", @"url"];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *Url = [NSURL URLWithString:urlStr];
    
    // 创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:Url];
    
    // 创建会话
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"com.sunlei"];
    //最大并发下载数
    configuration.HTTPMaximumConnectionsPerHost = 3;
    //当在后台完成传输的时候是否启动恢复或者启动APP
    configuration.sessionSendsLaunchEvents = YES;
    //是否允许性能优化，例如电量低的情况下系统有可能停止后台数据传输
    configuration.discretionary = YES;
    //请求超时时间
    configuration.timeoutIntervalForRequest = 15;
    //是否允许移动蜂窝网络
    configuration.allowsCellularAccess = YES;

    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    NSURLSessionDownloadTask *downLoadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            // 下载成功
            // 注意 location是下载后的临时保存路径, 需要将它移动到需要保存的位置
            NSError *saveError;
            // 创建一个自定义存储路径
            NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            NSString *savePath = [cachePath stringByAppendingPathComponent:@"fileName"];
            NSURL *saveURL = [NSURL fileURLWithPath:savePath];
            
            // 文件复制到cache路径中
            [[NSFileManager defaultManager] copyItemAtURL:location toURL:saveURL error:&saveError];
            if (!saveError) {
                NSLog(@"保存成功");
            } else {
                NSLog(@"error is %@", saveError.localizedDescription);
            }
        } else {
            NSLog(@"error is : %@", error.localizedDescription);
        }
    }];
    // 恢复线程, 启动任务
    [downLoadTask resume];
    
}

#pragma mark -- 取消下载
-(void)cancleDownLoad
{
    [_downloadTask cancel];
}
#pragma mark --- 挂起下载
- (void)suspendDownload
{
    [_downloadTask suspend];
}
#pragma mark ---- 恢复继续下载
- (void)resumeDownLoad
{
    [_downloadTask resume];
    
    
}

#pragma mark ---- downLoadTask 代理方法
// 下载过程中 会多次调用, 记录下载进度
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    // 记录下载进度
    NSLog(@"--%lld---%lld",totalBytesWritten,totalBytesExpectedToWrite);
}

// 下载完成
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    NSError *error;
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *savePath = [cachePath stringByAppendingPathComponent:@"savename"];
    
    NSURL *saveUrl = [NSURL fileURLWithPath:savePath];
    // 通过文件管理 复制文件
    [[NSFileManager defaultManager] copyItemAtURL:location toURL:saveUrl error:&error];
    if (error) {
        NSLog(@"Error is %@", error.localizedDescription);
    }
}

// 当调用恢复下载的时候 触发的代理方法 [_downLoadTask resume]
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    
    
}


// 任务完成, 不管是否下载成功
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    
}


// session 后台下载完成 之后的操作 (本地通知 或者 更新UI)
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session
{
    AppDelegate *appdelgate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (appdelgate.backgroundSessionCompletionHandler) {
        void (^completionHandle)() = appdelgate.backgroundSessionCompletionHandler;
        appdelgate.backgroundSessionCompletionHandler = nil;
        completionHandle();
    }
}


@end
