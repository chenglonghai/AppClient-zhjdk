//
//  UserManager.h
//  AppClient
//
//  Created by xinz on 2017/10/28.
//  Copyright © 2017年 Chenlonghai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserManager : NSObject

@property (nonatomic, strong) UserModel *userModel;

@property (nonatomic, strong) NSArray *downloadingArray;
@property (nonatomic, strong) NSArray *downloadedArray;

@property (nonatomic, strong) NSDictionary *playDict;

@property (nonatomic, assign) BOOL isLogin;

+ (instancetype)shareManager;

-(void)saveUserInfo:(NSDictionary *)userModelDic;


- (BOOL)saveVieoList:(NSDictionary *)videoDict;

- (NSArray *)getVieoListArray;

- (void)removeVieo:(NSDictionary *)videoDict;


- (NSArray *)getCompleteVideoVieoListArray;
- (BOOL)saveVieoCompleteVideo:(NSDictionary *)videoDict;
- (void)removeCompleteVieo:(NSDictionary *)videoDict;

//保存播放
- (void)savePlayVideo:(NSDictionary *)dict;
- (NSDictionary *)getPlayVideo;

-(void)cleanUserInfo;
-(NSDictionary *)getLocalUserInfo;
@end
