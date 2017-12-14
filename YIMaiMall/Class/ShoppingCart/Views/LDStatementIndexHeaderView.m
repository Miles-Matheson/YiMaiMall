//
//  LDStatementIndexHeaderView.m
//  FullAndFresh
//
//  Created by Miles on 2017/9/29.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDStatementIndexHeaderView.h"

@implementation LDStatementIndexHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.contentView.backgroundColor = WhiteColor;

    _titleLB = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"****" textColor:RGB(51, 51, 51) textAlignment:Left font:kFont15];
    [self.contentView addSubview:_titleLB];

    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.centerY.offset(0);
    }];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappp)];
    [self addGestureRecognizer:tap];
}

-(void)tappp
{
    if (_itemSelectCallBack) {
        _itemSelectCallBack(self,_titleLB.text);
    }
}
@end
