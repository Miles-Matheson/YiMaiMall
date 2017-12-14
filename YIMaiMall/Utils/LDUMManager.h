//
//  LDUMManager.h
//  FullAndFresh
//
//  Created by Miles on 2017/9/26.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDUMManager : NSObject

+(void)initUmManagerWithLaunchOptions:(NSDictionary *)launchOptions Delegate:(id)delegate;

+(void)initIQKeyboardManager;

+(void)showADAndNAVViewWithWindow:(UIWindow *)window;
@end
