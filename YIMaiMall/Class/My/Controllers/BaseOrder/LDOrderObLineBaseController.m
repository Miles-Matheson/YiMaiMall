//
//  OrserBaseController.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/23.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDOrderObLineBaseController.h"
#import "LDOnlineOrderController.h"
#import "LDOrderModel.h"
@interface LDOrderObLineBaseController ()

@property (nonatomic,strong)NSArray *titleArray;

@end

@implementation LDOrderObLineBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"全部订单";
    
    UIButton *informationCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [informationCardBtn addTarget:self action:@selector(enterehzFilesVC:) forControlEvents:UIControlEventTouchUpInside];
    [informationCardBtn setImage:[UIImage imageNamed:@"search_1"] forState:UIControlStateNormal];
    
    [informationCardBtn sizeToFit];
    UIBarButtonItem *informationCardItem = [[UIBarButtonItem alloc] initWithCustomView:informationCardBtn];
    
    
    UIBarButtonItem *fixedSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpaceBarButtonItem.width = 22;
    
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn addTarget:self action:@selector(enterTeamCard:) forControlEvents:UIControlEventTouchUpInside];
    [settingBtn setImage:[UIImage imageNamed:@"more_1"] forState:UIControlStateNormal];
    [settingBtn sizeToFit];
    UIBarButtonItem *settingBtnItem = [[UIBarButtonItem alloc] initWithCustomView:settingBtn];
    

//    self.navigationItem.rightBarButtonItems  = @[informationCardItem,fixedSpaceBarButtonItem,settingBtnItem];
    
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
    self.tabBar.itemTitleSelectedColor = kAppThemeColor;
    self.tabBar.itemTitleFont = [UIFont systemFontOfSize:16];
    self.tabBar.indicatorScrollFollowContent = YES;
    self.tabBar.itemColorChangeFollowContentScroll = YES;
    self.tabBar.indicatorColor = kAppThemeColor;
    [self.tabBar setIndicatorWidthFixTextAndMarginTop:42 marginBottom:0 widthAdditional:0 tapSwitchAnimated:YES];
    
    self.tabBar.indicatorAnimationStyle = YPTabBarIndicatorAnimationStyle1;
    
    [self setContentScrollEnabledAndTapSwitchAnimated:YES];
    
    [self.yp_tabItem setDoubleTapHandler:^{
        NSLog(@"双击效果");
    }];
}

-(void)enterehzFilesVC:(UIButton *)btn{
    
    
}

-(void)enterTeamCard:(UIButton *)btn{
    
    
}

-(void)createLeftBtn{
    
    UIBarButtonItem* leftButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(clickCancel)];
    self.navigationItem.leftBarButtonItem=leftButtonItem;
}

-(void)clickCancel{
    
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)initViewControllers {
    
    NSMutableArray * vcArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<self.titleArray.count; i++) {
        
        LDOnlineOrderController *onLineVC = [[LDOnlineOrderController alloc]init];
        onLineVC.yp_tabItemTitle = _titleArray[i];
        onLineVC.ststus = i;
        [vcArray addObject:onLineVC];
    }
    self.viewControllers = [NSMutableArray arrayWithArray:vcArray];
}

@end
