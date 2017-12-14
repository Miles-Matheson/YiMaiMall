//
//  LDSearchHeadView.m
//  FullAndFresh
//
//  Created by Miles on 2017/9/29.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDSearchHeadView.h"

@implementation LDSearchHeadView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        [self initUI];
//        self.backgroundColor = WhiteColor;
    }
    return self;
}

-(void)initUI
{
    _titleLB = [[UILabel alloc]init];
    _titleLB.font = [UIFont boldSystemFontOfSize:16];
    _titleLB.textColor = RGB(51, 51, 51);
    [self addSubview:_titleLB];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.offset(0);
    }];
}

@end
