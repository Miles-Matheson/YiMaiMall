//
//  YKPushManager.m
//  MurphysLaw
//
//  Created by Miles on 2017/4/28.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

#import "LDPushManager.h"
#import <JPUSHService.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max 
    #import <UserNotifications/UserNotifications.h>
#endif

@interface LDPushManager () <JPUSHRegisterDelegate>

@end

@implementation LDPushManager

+ (instancetype)sharedInstance
{
    static LDPushManager *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (void)initJPUSH:(NSDictionary *)launchOptions{
    //notice: 3.0.0
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //        categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // Required
    // init Push
    // notice: 2.1.5   SDK             IDFA       IDFA   nil
    //       pushConfig.plist    appKey
    [JPUSHService setupWithOption:launchOptions appKey:@"9aae75599b7bb3eff4fdbd65"channel:@"Apple Store"apsForProduction:YES
           ];
}

-(void)setAlias:(NSString *)alias{
    
    
    [JPUSHService setAlias:alias callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
}

- (void)alias:(NSString *)userId
{
    [JPUSHService registrationID];
}

- (void)removeAlias{
    [JPUSHService setAlias:@"" callbackSelector:nil object:nil];
}

- (void)tagsAliasCallback:(int)iResCode
                     tags:(NSSet *)tags
                    alias:(NSString *)alias {
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
    NSLog(iResCode == 0 ? @"设置别名成功!" : @"设置别名失败!");
}

#pragma mark - JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger)
                                                               )completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]
        ]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); //Badge Sound Alert
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)
                                                                          ())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();
}

@end
