//
//  UserModel.h
//  AppClient
//
//  Created by xinz on 2018/1/12.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic, strong) NSString *attribute;
@property (nonatomic, strong) NSString *collectVideos;
@property (nonatomic, strong) NSString *continuousLoginDayCount;
@property (nonatomic, strong) NSString *downloadCount;
@property (nonatomic, strong) NSString *gender ;
@property (nonatomic, strong) NSString *gmtCreate;
@property (nonatomic, strong) NSString *gmtModify;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *loginDayCount;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *picUrl;
@property (nonatomic, strong) NSString *useAble;
@property (nonatomic, strong) NSString *watchCount;
@property (nonatomic, strong) id utoken;
@end
