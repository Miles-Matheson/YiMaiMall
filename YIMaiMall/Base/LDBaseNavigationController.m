//
//  LDBaseNavigationController.m
//  StairOrder
//
//  Created by Miles on 2017/8/14.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDBaseNavigationController.h"

@interface LDBaseNavigationController ()

@end

@implementation LDBaseNavigationController


- (void)todo
{
    [self addObserver:self forKeyPath:@"navigationBar.barTintColor" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}


#pragma mark - kvo的回调方法(系统提供的回调方法)
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
        UIColor *color1  = [ change valueForKey:NSKeyValueChangeNewKey ];

    if (CGColorEqualToColor( color1.CGColor, kAppThemeColor.CGColor)) {
    
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        self.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:17]};

        self.navigationBar.tintColor = WhiteColor;
    
    }else{
        
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        self.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor blackColor],
                                                                                NSFontAttributeName:[UIFont boldSystemFontOfSize:17]};
        
        self.navigationBar.tintColor =  RGB(50, 50, 50);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.tintColor = RGB(81, 81, 81);

    UIImageView *imgView =  [self findHairlineImageViewUnder:self.navigationBar];
    imgView.hidden = YES;
}


//通过一个方法来找到这个黑线(findHairlineImageViewUnder):
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

// 重写自定义的UINavigationController中的push方法
// 处理tabbar的显示隐藏

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count != 0) {
        
//       UIImageView *imgView =  viewController.navigationController.navigationBar.subviews.firstObject;
//        
//        imgView.alpha = 1.0;
//        viewController.navigationController.navigationBar.barTintColor = WhiteColor;
        viewController.hidesBottomBarWhenPushed = YES; //viewController是将要被push的控制器
    }
    [super pushViewController:viewController animated:animated];
}

- (void)dealloc
{
    @try {
        [self removeObserver:self forKeyPath:@"navigationBar.barTintColor"];
    }
    @catch (NSException *exception) {
    }
}

@end
