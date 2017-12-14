//
//  LDShopBaseChildController.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/24.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDShopBaseChildController.h"
#import "LDShopHomeController.h"
#import "LDShopAllController.h"


@interface LDShopBaseChildController ()

@property (nonatomic, copy) NSArray *titleArray;

@end

@implementation LDShopBaseChildController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleArray = @[@"店铺首页",@"全部商品",@"热销商品",@"商品上新"];
    
    [self initViewControllers];

    [self setTabBarFrame:CGRectMake(0,0, SCREEN_WIDTH, 44)
            contentViewFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT)];
 
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
}

- (void)initViewControllers {
    
    NSMutableArray * vcArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<self.titleArray.count; i++) {
        
        if (i == 0) {
            LDShopHomeController *goodsVC = [[LDShopHomeController alloc]init];
            goodsVC.view.backgroundColor = RedColor;
            goodsVC.yp_tabItemTitle = self.titleArray[i];
            [vcArray addObject:goodsVC];
        }else if (i == 1){
            LDShopAllController *detailVC = [[LDShopAllController alloc]init];
            detailVC.yp_tabItemTitle = self.titleArray[i];
            [vcArray addObject:detailVC];
        }else{
            UIViewController *commentVC = [[UIViewController alloc]init];
            commentVC.yp_tabItemTitle = self.titleArray[i];
            commentVC.view.backgroundColor = GreenColor;
            [vcArray addObject:commentVC];
        }
    }
    self.viewControllers = [NSMutableArray arrayWithArray:vcArray];
}


@end
