//
//  LDShopLicenseController.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/30.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDShopLicenseController.h"

@interface LDShopLicenseController ()

@end

@implementation LDShopLicenseController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"工商执照";
    
    UIImageView  *imageView = [[UIImageView alloc]init];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.offset(0);
    }];
    
    imageView.image = [UIImage imageNamed:@"ewm2"];

}


@end
