//
//  HandeData.h
//  YiJinYi
//
//  Created by 陈龙海 on 15/12/9.
//  Copyright © 2015年 陈龙海. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HandeDataDelegate <NSObject>

@optional;





- (void)sendSuccessWithMark:(NSString *)mark
                   errormsg:(NSString *)errormsg;



@end


@interface HandeData : NSObject

@property (nonatomic, weak) id <HandeDataDelegate>delegate;





+ (void)pictureHttpPostRequest:(NSString *)url WithFormdata:(NSMutableDictionary *)formData WithSuccess:(void (^)(ResultModel *response))success failure:(void (^)(NSError *error))failure image:(UIImage *)image avatarPicture:(NSString *)avatarPicture;



@end
