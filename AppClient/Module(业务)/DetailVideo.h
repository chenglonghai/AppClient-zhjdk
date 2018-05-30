//
//  DetailVideo.h
//  AppClient
//
//  Created by xinz on 2018/1/13.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailVideo : NSObject

@property (nonatomic, strong) NSString *attribute;
@property (nonatomic, strong) NSString *collectCount ;
@property (nonatomic, strong) NSString *collectStatus ;
@property (nonatomic, strong) NSString *contentType ;
@property (nonatomic, strong) NSString *deleteStatus;
@property (nonatomic, strong) NSString *descriptions ;
@property (nonatomic, strong) NSString *downloadCount;
@property (nonatomic, strong) NSString *gmtCreate;
@property (nonatomic, strong) NSString *gmtModify;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *likeCount;
@property (nonatomic, strong) NSString *picUrl;
@property (nonatomic, strong) NSString *playCount;
@property (nonatomic, strong) NSString *stage;
@property (nonatomic, strong) NSString *status ;
@property (nonatomic, strong) NSString *sumNum ;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *videoUrl;
@property(nonatomic,assign)CGFloat cellHeight;

@end
