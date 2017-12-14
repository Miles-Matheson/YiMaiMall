//
//  LDBaseTabBarController.m
//  StairOrder
//
//  Created by Miles on 2017/8/14.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDBaseTabBarController.h"
#import "LDBaseNavigationController.h"

@interface LDBaseTabBarController ()<UITabBarControllerDelegate>

@end

@implementation LDBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;

    [self setSubController];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeShopCartNum) name:ADDGOODSCOUNT object:nil];
}

- (void)setSubController{

   //ShopCartBaseController
    //MKJShoppingCartViewController
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    //HomeBaseController
    //NearBaseController
    NSArray *VCNameArr = @[@"HomeBaseController",@"CategoryBaseController",@"NearBaseController",@"ShopCartBaseController",@"MyBaseController"];
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSString *VCName in VCNameArr) {
        UIViewController *VC = (UIViewController *)[[NSClassFromString(VCName) alloc] init];
        LDBaseNavigationController *VCNav = [[LDBaseNavigationController alloc] initWithRootViewController:VC];
        [array addObject:VCNav];
    }
    [self setViewControllers:array];

    NSArray *tabBarTitleArr  = @[@"首页",@"分类",@"周边",@"购物车",@"我的"];
    NSArray *tabBarImgArr = @[@"home",@"category",@"around",@"buy",@"user"];
    NSArray *tabBarItems = self.tabBar.items;
    
    for (int i = 0; i < tabBarItems.count; i++) {
        
        UITabBarItem *item = tabBarItems[i];
        item.title = tabBarTitleArr[i];
        item.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_select",tabBarImgArr[i]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        item.image = [[UIImage imageNamed:[NSString stringWithFormat:@"%@",tabBarImgArr[i]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:kAppThemeColor} forState:UIControlStateSelected];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(68, 68, 68)} forState:UIControlStateNormal];
    }
}
#pragma mark--UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    LDBaseNavigationController *nav = (LDBaseNavigationController *)viewController;
    
    switch (tabBarController.selectedIndex) {
        case 0:
        {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            nav.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};
        }
            break;
        case 1:
        {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            nav.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};
        }
            break;
        case 2:
        {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            nav.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor blackColor]};
        }
            break;
        case 3:
        {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            
            nav.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor blackColor]};
        }
            break;
        case 4:
        {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            nav.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};

        }
            break;
            
        default:
            break;
    }
}


-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    

//    LDBaseNavigationController *nav = (LDBaseNavigationController*)viewController;
//
//   NSString *token = [LLUtils strNilOrEmpty:kToken elseBack:@""];
//
//    if ([nav.childViewControllers.firstObject isKindOfClass:[NSClassFromString(@"ShopCartBaseController") class]] && token.length == 0) {
//
//        LDBaseNavigationController *nav = [[LDBaseNavigationController alloc]initWithRootViewController:[[NSClassFromString(@"LDLoginRegisterController") alloc] init]];
//        [self  presentViewController:nav animated:YES completion:nil];
//        return NO;
//    }
    return YES;
}

@end
