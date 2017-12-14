//
//  PayManager.h
//  BaseFrame
//
//  Created by 陈舟为 on 2017/5/14.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Order.h"

@interface PayManager : NSObject

+(instancetype)shareManager;

-(void)aliPay:(Order*)order success:(void (^)(NSDictionary *resultDic))success;

-(NSMutableDictionary *)VEComponentsStringToDic:(NSString*)AllString withSeparateString:(NSString *)FirstSeparateString AndSeparateString:(NSString *)SecondSeparateString;

- (void)sendPay_demo:(Order*)orderEntity;

@end
