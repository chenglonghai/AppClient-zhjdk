//
//  HomeVideoModel.h
//  AppClient
//
//  Created by xinz on 2018/1/12.
//  Copyright © 2018年 Chenlonghai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeVideoModel : NSObject
@property (nonatomic, strong) NSString *contentTypeExplain;
@property (nonatomic, strong) NSString *contentTypeExplainName;
@property (nonatomic, strong) NSString *contentTypeRead;
@property (nonatomic, strong) NSString *contentTypeReadName;
@property (nonatomic, strong) NSString *contentTypeWrite;
@property (nonatomic, strong) NSString *contentTypeWriteName;
@property (nonatomic, strong) NSString *sumNum;
@property (nonatomic, strong) NSString *sumNumName;

@property (nonatomic, strong) NSArray *explainList;
@property (nonatomic, strong) NSMutableArray *explainListArr;
@property (nonatomic, strong) NSArray *readList;
@property (nonatomic, strong) NSMutableArray *readListArr;
@property (nonatomic, strong) NSArray *writeList;
@property (nonatomic, strong) NSMutableArray *writeListArr;
@end
