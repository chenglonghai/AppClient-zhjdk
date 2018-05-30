//
//  Tools.h
//  SLMultiDownLoadManager
//
//  Created by sunlei on 16/8/11.
//  Copyright © 2016年 sunlei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownLoadTools : NSObject

//归档下载完的model数组
+ (BOOL)archiveDownLoadModelArrWithModelArr:(NSMutableArray *)arr withKey:(NSString *)keyStr andPath:(NSString *)path;

//返回解归档下载完的model数组
+ (NSMutableArray *)unArchiveDownLoadModelArrWithKey:(NSString *)key andPath:(NSString *)path;

//获取剩余磁盘空间大小
+ (long long)getDiskFreeSpaceEx;

//获取磁盘的总大小
+ (long long)getDiskTotalSpaceEx;

@end
