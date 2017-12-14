//
//  LDSearchDefultCell.m
//  FullAndFresh
//
//  Created by Miles on 2017/9/29.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDSearchDefultCell.h"

@implementation LDSearchDefultCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = WhiteColor;
        [self initUI];
    }
    return self;
}
- (void)initUI
{
    UIView *line = [UIView new];
//    line.backgroundColor = RGB(225, 225, 225);
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.height.offset(0.8);
        make.right.offset(0);
    }];
    _itemLB = [[UILabel alloc]init];
    [self.contentView addSubview:_itemLB];
    _itemLB.backgroundColor = WhiteColor;
    _itemLB.font = kFont14;
    _itemLB.textColor = RGB(55, 55, 55);
    _itemLB.textAlignment = Left;
    
    [_itemLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(15);
        make.right.bottom.offset(-5);
    }];
}
@end
