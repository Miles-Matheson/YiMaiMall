//
//  LDOnlineSearchController.m
//  YIMaiMall
//
//  Created by Miles on 2017/12/8.
//  Copyright © 2017年 Miles. All rights reserved.
//

#define KGenericColor [UIColor colorWithRed:49/255.0 green:194/255.0 blue:124/255.0 alpha:1.0]
#import "LDOnlineSearchController.h"

#import "LDOnLineStoreSearchController.h"
#import "LDOnLineGoodsSearchController.h"
#import "WMSearchBar.h"

@interface LDOnlineSearchController ()<UISearchBarDelegate>
@property (nonatomic,strong)WMSearchBar *searchBar;
@property (nonatomic,strong)NSArray *titleArray;

@property (nonatomic,assign)CGFloat width;
@property (nonatomic,assign)CGFloat height;

@end

@implementation LDOnlineSearchController

- (void)addSearchBar {
    
    
    UIView *baseView1  = [UIView new ];
    baseView1.backgroundColor = WhiteColor;
    [self.view addSubview:baseView1];
    [baseView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.width.offset(70);
        if (SCREEN_HEIGHT == 812) {
            make.height.offset(88);
        }else{
            make.height.offset(64);
        }
    }];
    
    _searchBar = [self addSearchBarWithFrame:CGRectMake(0, 0, kScreenWidth - 2 * 44 - 2 * 15, 44)];
    UIView *wrapView = [[UIView alloc] initWithFrame:_searchBar.frame];
    [wrapView addSubview:_searchBar];
    self.navigationItem.titleView = wrapView;
    
}

- (WMSearchBar *)addSearchBarWithFrame:(CGRect)frame {
    
    self.definesPresentationContext = YES;
    
    WMSearchBar *searchBar = [[WMSearchBar alloc]initWithFrame:frame];
    
    searchBar.delegate = self;
    searchBar.placeholder = @"搜索店铺                    ";
    [searchBar setShowsCancelButton:NO];
    [searchBar setTintColor:KGenericColor];
    
    //    if (self.isChangeSearchBarFrame) {
    //
    //        CGFloat height = searchBar.bounds.size.height;
    //        CGFloat top = (height - 20.0) / 2.0;
    //        CGFloat bottom = top;
    //
    //        searchBar.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    //    }
    return searchBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _width = (self.view.width -50)/4;;
    _height = _width/3.2;
    
    self.view.backgroundColor = WhiteColor;
    [self addSearchBar];
    CGFloat bottom = [self.parentViewController isKindOfClass:[UINavigationController class]] ? 0 : 50;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;

    _titleArray = @[@"线上店铺",@"线上商品"];
    [self initViewControllers];
    
    if (isIPhpneX) {
        [self setTabBarFrame:CGRectMake(0,64, screenSize.width, 44)
            contentViewFrame:CGRectMake(0,64+44, screenSize.width, screenSize.height - 64 - bottom - 44)];
    } else {
        [self setTabBarFrame:CGRectMake(0,64, screenSize.width, 44)
            contentViewFrame:CGRectMake(0, 64+44, screenSize.width,self.view.size.height-66 -44 -bottom)];
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

- (void)initViewControllers {
    
    NSMutableArray * vcArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<self.titleArray.count; i++) {
        
        if (i == 0) {
            LDOnLineStoreSearchController*onLineVC = [[LDOnLineStoreSearchController alloc]init];
            onLineVC.yp_tabItemTitle = _titleArray[i];
            onLineVC.searchBar = _searchBar;
            [vcArray addObject:onLineVC];
        }else{
            LDOnLineGoodsSearchController*onLineVC = [[LDOnLineGoodsSearchController alloc]init];
            onLineVC.yp_tabItemTitle = _titleArray[i];
            onLineVC.searchBar = _searchBar;
            [vcArray addObject:onLineVC];
        }
    }
    self.viewControllers = [NSMutableArray arrayWithArray:vcArray];
}


//#pragma mark - 实现键盘上Search按钮的方法
//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
//    NSLog(@"您点击了键盘上的Search按钮");
//
////    if ( self.SearchDataType == SearchDataTypeSeller) {
////        [self onLineStoreSearchWithName:searchBar.text];
////    }else{
////        [self retuestMainDataWithName:searchBar.text];
////    }
//}
//#pragma mark - 实现监听开始输入的方法
//- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
//
//    NSLog(@"开始输入搜索内容");
//    return YES;
//}
//#pragma mark - 实现监听输入完毕的方法
//- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
//    NSLog(@"输入完毕");
//    //    [self retuestMainDataWithName:searchBar.text];
//    return YES;
//}


@end
