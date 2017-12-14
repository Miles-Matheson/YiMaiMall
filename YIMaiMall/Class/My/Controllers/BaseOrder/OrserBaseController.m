//
//  OrserBaseController.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/23.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "OrserBaseController.h"
#import "LDOnlineOrderController.h"
@interface OrserBaseController ()

@property (nonatomic,strong)NSArray *titleArray;

@end

@implementation OrserBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"全部订单";
    
    CGFloat bottom = [self.parentViewController isKindOfClass:[UINavigationController class]] ? 0 : 50;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;

    _titleArray = @[@"全部",@"待付款",@"待收货",@"待评价",@"已完成"];
    [self initViewControllers];
    
    if (isIPhpneX) {
        [self setTabBarFrame:CGRectMake(0, 44+44, screenSize.width, 44)
            contentViewFrame:CGRectMake(0, 88+44, screenSize.width, screenSize.height - 88 - bottom - 44 -34)];
    } else {
        [self setTabBarFrame:CGRectMake(0,65, screenSize.width, 44)
            contentViewFrame:CGRectMake(0, 65+44, screenSize.width,self.view.size.height-65 -44 -bottom)];
    }
    
    self.tabBar.backgroundColor = [UIColor whiteColor];
    
    self.tabBar.itemTitleColor = [UIColor blackColor];
    self.tabBar.itemTitleSelectedColor = kAppSubThemeColor;
    self.tabBar.itemTitleFont = [UIFont systemFontOfSize:16];
    self.tabBar.indicatorScrollFollowContent = YES;
    self.tabBar.itemColorChangeFollowContentScroll = YES;
    self.tabBar.indicatorColor = kAppSubThemeColor;
    [self.tabBar setIndicatorWidthFixTextAndMarginTop:42 marginBottom:0 widthAdditional:0 tapSwitchAnimated:YES];
    
    self.tabBar.indicatorAnimationStyle = YPTabBarIndicatorAnimationStyle1;
    
    [self setContentScrollEnabledAndTapSwitchAnimated:YES];
    
    [self.yp_tabItem setDoubleTapHandler:^{
        NSLog(@"双击效果");
    }];
}

- (void)initViewControllers {
    
    NSMutableArray * vcArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<self.titleArray.count; i++) {
        
        LDOnlineOrderController *onLineVC = [[LDOnlineOrderController alloc]init];
        onLineVC.yp_tabItemTitle = _titleArray[i];
        [vcArray addObject:onLineVC];
    }
    self.viewControllers = [NSMutableArray arrayWithArray:vcArray];
}

@end
