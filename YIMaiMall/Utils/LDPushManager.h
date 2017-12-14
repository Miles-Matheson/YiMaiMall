//
//  YKPushManager.h
//  MurphysLaw
//
//  Created by Miles on 2017/4/28.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDPushManager : NSObject

+ (instancetype)sharedInstance;

/**
 初始化JPUSH
 */
- (void)initJPUSH:(NSDictionary *)launchOptions;

/**
 设置JPUSH推送别名
 */
- (void)setAlias:(NSString *)alias;

/**
 移除JPUSH别名
 */
- (void)removeAlias;

- (void)alias:(NSString *)userId;

@end
