//
//  LDGoodsDetailController.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/16.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDBaseDetailController.h"
#import "LDCommentController.h"
#import "LDDetailController.h"
#import "LDGoodsController.h"
#import "CustomPopView.h"
#import "FKGPopOption.h"

@interface LDBaseDetailController ()
@property (nonatomic,strong)NSArray *titleArray;
@end

@implementation LDBaseDetailController

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    NSLog(@"statusBar.backgroundColor--->%@",statusBar.backgroundColor);
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat bottom = [self.parentViewController isKindOfClass:[UINavigationController class]] ? 0 : 50;
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    ws(bself);
    
    UIView *baseView1  = [UIView new ];
    baseView1.backgroundColor = WhiteColor;
    [self.view addSubview:baseView1];
    [baseView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.width.offset(70);
        if (screenSize.height == 812) {
            make.height.offset(88);
        }else{
            make.height.offset(64);
        }
    }];
    
    UIButton *backBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"返回" titleColor:BlackColor font:kFont16 backgroundColor:WhiteColor touchUpInsideEvent:^(UIButton *sender) {
        [bself.navigationController  popViewControllerAnimated:YES];
    }];
    [baseView1 addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        
        if (screenSize.height == 812) {
            make.top.offset(49.5);
        }else{
            make.top.offset(25);
        }
        make.width.offset(70-12);
    }];
    
    UIView *baseView2  = [UIView new ];
    baseView2.backgroundColor = WhiteColor;
    [self.view addSubview:baseView2];
    [baseView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.offset(0);
        make.width.offset(70);
        if (screenSize.height == 812) {
            make.height.offset(88);
        }else{
            make.height.offset(64);
        }
    }];
    
    UIButton *moreBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"..." titleColor:BlackColor font:kFont15 backgroundColor:WhiteColor touchUpInsideEvent:^(UIButton *sender) {
    }];
    [baseView2 addSubview:moreBtn];
    [moreBtn addTarget:self action:@selector(showMoreView:) forControlEvents:UIControlEventTouchUpInside];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (screenSize.height == 812) {
            make.top.offset(47);
        }else{
            make.top.offset(22.5);
        }
        make.right.offset(-12);
    }];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setTitle:@"分享" forState:0];
    [shareBtn setTitleColor:BlackColor forState:0];
    shareBtn.titleLabel.font = kFont15;
    [baseView2 addSubview:shareBtn];
  
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moreBtn.mas_top).offset(2.5);
        make.right.equalTo(moreBtn.mas_left).offset(-10);
    }];
    
    _titleArray = @[@"商品",@"详情",@"评价"];
    
    self.navigationController.navigationBarHidden = YES;
    
    [self initViewControllers];
    
    if (screenSize.height == 812) {
        [self setTabBarFrame:CGRectMake(80, 44, screenSize.width-160, 44)
            contentViewFrame:CGRectMake(0, 88, screenSize.width, screenSize.height - 88 - bottom - 34)];
    } else {
        [self setTabBarFrame:CGRectMake(80,20, screenSize.width-160, 44)
            contentViewFrame:CGRectMake(0, 64, screenSize.width, screenSize.height - 64 - bottom )];
    }
    
    self.tabBar.backgroundColor = [UIColor whiteColor];
    
    self.tabBar.itemTitleColor = [UIColor blackColor];
    self.tabBar.itemTitleSelectedColor = kAppThemeColor;
    self.tabBar.itemTitleFont = [UIFont systemFontOfSize:16];
    
    self.tabBar.indicatorScrollFollowContent = YES;
    
    self.tabBar.itemColorChangeFollowContentScroll = YES;
    
    self.tabBar.indicatorColor = BlackColor;
    
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
        
        if (i == 0) {
            LDGoodsController *goodsVC = [[LDGoodsController alloc]init];
            goodsVC.yp_tabItemTitle = self.titleArray[i];
            [vcArray addObject:goodsVC];
        }else if (i == 1){
            LDDetailController *detailVC = [[LDDetailController alloc]init];
            detailVC.yp_tabItemTitle = self.titleArray[i];
            [vcArray addObject:detailVC];
        }else{
            
            LDCommentController *commentVC = [[LDCommentController alloc]init];
            commentVC.yp_tabItemTitle = self.titleArray[i];
            [vcArray addObject:commentVC];
        }
    }
    self.viewControllers = [NSMutableArray arrayWithArray:vcArray];
}

-(void)showMoreView:(UIButton *)btn{
    
    CustomPopView *popoverView = [[CustomPopView alloc]init];;
    
    popoverView.style = PopoverViewStyleDefault;
    popoverView.hideAfterTouchOutside = YES; // 点击外部时不允许隐藏
    
    NSMutableArray *actions = [NSMutableArray array];
    
    for (int i = 0; i < 5; i ++) {
        CustomPopAction *action = [CustomPopAction actionWithTitle:[NSString stringWithFormat:@"====%d",i] handler:^(CustomPopAction *action) {
            
        }];
        [actions addObject:action];
    }
    [popoverView showToView:btn withActions:actions];
}

@end
