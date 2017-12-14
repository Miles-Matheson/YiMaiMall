//
//  LDShopSaveController.m
//  YIMaiMall
//
//  Created by Miles on 2017/12/1.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDSaveShopController.h"

#import "LDShopOnlineController.h"
#import "LDShopOfflineController.h"

@interface LDSaveShopController ()
@property (nonatomic,strong)NSArray *titleArray;
@end

@implementation LDSaveShopController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat bottom = [self.parentViewController isKindOfClass:[UINavigationController class]] ? 0 : 50;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    _titleArray = @[@"线上电商",@"线下店铺",];
    
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

        for (int i = 0; i<self.titleArray.count; i++) {
           
            if (i == 0) {
                LDShopOnlineController *onLineVC = [[LDShopOnlineController alloc]init];
                 onLineVC.yp_tabItemTitle = self.titleArray[i];
                  [vcArray addObject:onLineVC];
            }else{
                LDShopOfflineController *onLineVC = [[LDShopOfflineController alloc]init];
                onLineVC.yp_tabItemTitle = self.titleArray[i];
                [vcArray addObject:onLineVC];
            }
        }
    self.viewControllers = [NSMutableArray arrayWithArray:vcArray];
}

@end
