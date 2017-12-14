//
//  LDShopClassListCell.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/30.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDShopClassListCell.h"

@implementation LDShopClassListCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        _titleLB = [[UILabel alloc]init];
        [self.contentView addSubview:_titleLB];
        _titleLB.backgroundColor = RGB(240, 240, 240);
        _titleLB.font = kFont13;
        _titleLB.textAlignment = NSTextAlignmentCenter;
        [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.offset(0);
        }];
    }
    return self;
}

@end
