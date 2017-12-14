//
//  LDDetailController.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/16.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDDetailController.h"

@interface LDDetailController ()

@end

@implementation LDDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor blueColor];

    ws(bself);
    [[APIManager sharedManager] getGoodsH5InfoWithGoodsID:_goodsID CallBack:^(id data) {
        RC001;
        bself.loadHTMLString = data[@"obj"];
    } fail:^(NSString *errorString) {
    
    }];
}
@end
