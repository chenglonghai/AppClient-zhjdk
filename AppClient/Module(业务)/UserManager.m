//
//  UserManager.m
//  AppClient
//
//  Created by xinz on 2017/10/28.
//  Copyright © 2017年 Chenlonghai. All rights reserved.
//

#import "UserManager.h"
#import "AppDelegate.h"

#import "CLHTabBarController.h"
@implementation UserManager

+ (instancetype)shareManager{
    static UserManager *userManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        userManager = [[UserManager alloc]init];
        [userManager addObserver:userManager forKeyPath:@"loginToken" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
        
        userManager.downloadingArray = [NSArray array];
        userManager.downloadedArray= [NSArray array];
    });

    return userManager;
}



//保存播放
- (void)savePlayVideo:(NSDictionary *)dict
{
  [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"play"];
}
- (NSDictionary *)getPlayVideo
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"play"] ;
}


-(void)saveUserInfo:(NSDictionary *)userModelDic{
   
    [[NSUserDefaults standardUserDefaults] setObject:userModelDic forKey:@"userInfo"];
         AppDelegate *appdelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    
    CLHTabBarController *tabVC= ( CLHTabBarController *)appdelegate.window.rootViewController;
    if (self.userModel != nil) {
        [self.userModel setValuesForKeysWithDictionary:userModelDic];
        
        self.isLogin = YES;
  

        tabVC.bottomButton.hidden = YES;
    }else{
           self.userModel = [[UserModel alloc] init];
          self.isLogin = YES;
         tabVC.bottomButton.hidden = YES;
          [self.userModel setValuesForKeysWithDictionary:userModelDic];
    }

    [[NSUserDefaults standardUserDefaults] synchronize];
}






- (BOOL)saveVieoList:(NSDictionary *)videoDict{
    NSMutableArray *videoList = [NSMutableArray arrayWithArray:[self getVieoListArray]];
    
    
    BOOL isSave = FALSE;
    
    if (videoList.count == 0) {
        [videoList addObject:videoDict];
                 isSave = YES;
    }else{
      
        NSString *downloadUrl = [NSString stringWithFormat:@"%@", [videoDict objectForKey:@"videoUrl"]];
        bool isExit = false;
    for (int i = 0; i < videoList.count; i++) {
        NSDictionary *dict = videoList[i];
           NSString *du = [NSString stringWithFormat:@"%@", [dict objectForKey:@"videoUrl"]];
        if ([downloadUrl isEqualToString:du]) {
            isExit = YES;
        }
        
        if(isExit == false){
            isSave = YES;
                [videoList addObject:videoDict];
        
        }
        
    }
        
        
    }
    
     [[NSUserDefaults standardUserDefaults] setObject:videoList forKey:@"videoArray"];
    
    
    return    isSave ;

}

- (NSArray *)getVieoListArray{

    NSArray *videoArray = nil;
    if([[NSUserDefaults standardUserDefaults]objectForKey:@"videoArray"] != nil)
    {
        videoArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"videoArray"];
    }
    if(videoArray == nil){
        videoArray = [NSArray array];
    }
    return videoArray;
}

- (void)removeVieo:(NSDictionary *)videoDict
{
    NSMutableArray *videoList = [NSMutableArray arrayWithArray:[self getVieoListArray]];
        NSString *downloadUrl = [NSString stringWithFormat:@"%@", [videoDict objectForKey:@"videoUrl"]];
    for (int i = 0; i < videoList.count; i++) {
        NSDictionary *dict = videoList[i];
        NSString *du = [NSString stringWithFormat:@"%@", [dict objectForKey:@"videoUrl"]];
        if ([downloadUrl isEqualToString:du]) {
            [videoList removeObjectAtIndex:i];
        }
      
        
    }
   
    [[NSUserDefaults standardUserDefaults] setObject:videoList forKey:@"videoArray"];
    
}

//完成的视频
- (NSArray *)getCompleteVideoVieoListArray{
    
    NSArray *videoArray = nil;
    if([[NSUserDefaults standardUserDefaults]objectForKey:@"videoCompleteArray"] != nil)
    {
        videoArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"videoCompleteArray"];
    }
    if(videoArray == nil){
        videoArray = [NSArray array];
    }
    return videoArray;
}

//完成保存
- (BOOL)saveVieoCompleteVideo:(NSDictionary *)videoDict{
    NSMutableArray *videoList = [NSMutableArray arrayWithArray:[self getCompleteVideoVieoListArray]];
    
    
    BOOL isSave = FALSE;
    
    if (videoList.count == 0) {
        [videoList addObject:videoDict];
        isSave = YES;
    }else{
        
        NSString *downloadUrl = [NSString stringWithFormat:@"%@", [videoDict objectForKey:@"videoUrl"]];
        bool isExit = false;
        for (int i = 0; i < videoList.count; i++) {
            NSDictionary *dict = videoList[i];
            NSString *du = [NSString stringWithFormat:@"%@", [dict objectForKey:@"videoUrl"]];
            if ([downloadUrl isEqualToString:du]) {
                isExit = YES;
            }
            
            if(isExit == false){
                isSave = YES;
                [videoList addObject:videoDict];
                
            }
            
        }
        
        
    }
    [[NSUserDefaults standardUserDefaults] setObject:videoList forKey:@"videoCompleteArray"];
    
    
    return    isSave ;
}
//移除完成的视频
- (void)removeCompleteVieo:(NSDictionary *)videoDict{
    
    NSMutableArray *videoList = [NSMutableArray arrayWithArray:[self getCompleteVideoVieoListArray]];
    NSString *downloadUrl = [NSString stringWithFormat:@"%@", [videoDict objectForKey:@"videoUrl"]];
    for (int i = 0; i < videoList.count; i++) {
        NSDictionary *dict = videoList[i];
        NSString *du = [NSString stringWithFormat:@"%@", [dict objectForKey:@"videoUrl"]];
        if ([downloadUrl isEqualToString:du]) {
            [videoList removeObjectAtIndex:i];
        }
        
        
    }
    [[NSUserDefaults standardUserDefaults] setObject:videoList forKey:@"videoCompleteArray"];
}




-(void)cleanUserInfo{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"userInfo"];
    AppDelegate *appdelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    [appdelegate configTabBarVC];
    CLHTabBarController *tabVC= ( CLHTabBarController *)appdelegate.window.rootViewController;
    tabVC.bottomButton.hidden =NO;
    self.userModel = nil;
    self.isLogin = NO;
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}





-(NSDictionary *)getLocalUserInfo{
    
    NSDictionary *userModelDic = nil;
    if([[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"] != nil)
    {
        
//        NSLog(@"xxxxxxxxxxxxxxxxxxxxx");
        userModelDic = [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
        self.isLogin = YES;
//        if (self.userModel != nil) {
//            [self.userModel setValuesForKeysWithDictionary:userModelDic];
//            self.isLogin = YES;
//        }else{
//            self.userModel = [[UserModel alloc] init];
//            self.isLogin = YES;
//            [self.userModel setValuesForKeysWithDictionary:userModelDic];
//        }
    }else{
     self.isLogin = NO;
    }
     return userModelDic;
    
}

@end
