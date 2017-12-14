//
//  UIView+LLToast.m
//  MerchantCenter
//
//  Created by kevin on 2017/2/27.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

#import "UIView+LLToast.h"
#import "UIView+Toast.h"

@implementation UIView (LLToast)

/**
 在页面底部显示Toast
 */
- (void)showDefaultToast:(NSString *)toast{
    [self makeToast:toast duration:1.0f position:[CSToastManager defaultPosition] style:nil];
}

- (void)showCenterToast:(NSString *)toast{
    [self makeToast:toast duration:1.0f position:CSToastPositionCenter style:nil];
}

//接受用户点击
-(void)showStatusWithMessage:(NSString *)str{
    
    [SVProgressHUD setDefaultMaskType:1];
    [SVProgressHUD showWithStatus:str];
}

//不接受用户点击
-(void)showWithMessage:(NSString *)str{
    
    [SVProgressHUD setDefaultMaskType:2];
    [SVProgressHUD showWithStatus:str];
}

-(void)dismiss{
    [SVProgressHUD dismiss];
}


@end
