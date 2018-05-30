//
//  SearchModel.h
//  AppClient
//
//  Created by xinz on 2018/1/13.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchModel : NSObject
@property (nonatomic, strong) NSString *attribute;
@property (nonatomic, strong) NSString *downloadUrl;
@property (nonatomic, strong) NSString *contentType;
@property (nonatomic, strong) NSString *descriptions;
@property (nonatomic, strong) NSString *gmtCreate;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *picUrl;
@property (nonatomic, strong) NSString *stage;
@property (nonatomic, strong) NSString *sumNum;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL isSelected;
@end
