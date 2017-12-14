//
//  LDCouponController.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/30.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDCouponController.h"
#import "LDCouponSonController.h"
#import "LDQuanListCell.h"
@interface LDCouponController ()
@property (nonatomic,strong)NSArray *titleArray;
@end

@implementation LDCouponController

-(instancetype)initWithCouponType:(CouponType)couponType{
    
    if (self = [super init]) {
        _couponType = couponType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_couponType == CouponTypeNormal) {
         self.title = @"优惠券";
        _titleArray = @[@"未使用",@"已使用",@"已过期"];
    }else if (_couponType == CouponTypeChoose){
         self.title = @"选择使用优惠券";
        _titleArray = @[@"可用优惠券",@"不可用优惠券"];
    }else if (_couponType == CouponTypeCanBeUse){
         self.title = @"领取优惠券";
    }

    CGFloat bottom = [self.parentViewController isKindOfClass:[UINavigationController class]] ? 0 : 50;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;

    [self initViewControllers];
    
    if (_titleArray.count) {
        if (screenSize.height == 812) {
            [self setTabBarFrame:CGRectMake(0, 88, screenSize.width, 44)
                contentViewFrame:CGRectMake(0, 88+44, screenSize.width, screenSize.height - 88 - bottom - 34-44)];
        } else {
            [self setTabBarFrame:CGRectMake(0,64, screenSize.width, 44)
                contentViewFrame:CGRectMake(0, 64+44, screenSize.width, screenSize.height - 64-44 - bottom )];
        }
    }else{
        if (screenSize.height == 812) {
            [self setTabBarFrame:CGRectMake(0,88, screenSize.width, 0)
                contentViewFrame:CGRectMake(0, 88, screenSize.width, screenSize.height - 88 - bottom - 34)];
        } else {
            [self setTabBarFrame:CGRectMake(0,64, screenSize.width, 0)
                contentViewFrame:CGRectMake(0, 64, screenSize.width, screenSize.height - 64 - bottom )];
        }
    }

    self.tabBar.backgroundColor = [UIColor whiteColor];
    
    self.tabBar.itemTitleColor = [UIColor blackColor];
    self.tabBar.itemTitleSelectedColor = kAppThemeColor;
    self.tabBar.itemTitleFont = [UIFont systemFontOfSize:16];
    
    self.tabBar.indicatorScrollFollowContent = YES;
    
    self.tabBar.itemColorChangeFollowContentScroll = YES;
    
    self.tabBar.indicatorColor = kAppThemeColor;
    
    [self.tabBar setIndicatorWidthFixTextAndMarginTop:42 marginBottom:0 widthAdditional:0 tapSwitchAnimated:YES];
    
    self.tabBar.indicatorAnimationStyle = YPTabBarIndicatorAnimationStyle1;
    
    [self setContentScrollEnabledAndTapSwitchAnimated:YES];
    
    //    [self.yp_tabItem setDoubleTapHandler:^{
    //        NSLog(@"双击效果");
    //    }];
}

- (void)initViewControllers {
    
    NSMutableArray * vcArray = [[NSMutableArray alloc]init];
    
    if (self.titleArray.count) {
        
        for (int i = 0; i<self.titleArray.count; i++) {
            NSString *string = nil;
            if (_couponType == CouponTypeNormal) {
                if (i == 0) {
                    string  = LDQuanListCell_CanBeUse;
                }else if (i == 1){
                    string  = LDQuanListCell_Normal;
                }else{
                     string  = LDQuanListCell_Normal;
                }
            }else if (_couponType == CouponTypeChoose){
                if (i == 0) {
                    string  = LDQuanListCell_Choose;
                }else if (i == 1){
                    string  = LDQuanListCell_Normal;
                }
            }
            LDCouponSonController *goodsVC = [[LDCouponSonController alloc]initWithReuseIdentifier:string];
            goodsVC.yp_tabItemTitle = self.titleArray[i];
            @try {
                if (_couponTotalList.count) {
                    goodsVC.couponModelList =  _couponTotalList[i];
                }
            } @catch (NSException *exception) {}
            [vcArray addObject:goodsVC];
        }
    }else{
        LDCouponSonController *goodsVC = [[LDCouponSonController alloc]initWithReuseIdentifier:LDQuanListCell_CanBeUse];
        [vcArray addObject:goodsVC];
    }
    self.viewControllers = [NSMutableArray arrayWithArray:vcArray];
}

@end
