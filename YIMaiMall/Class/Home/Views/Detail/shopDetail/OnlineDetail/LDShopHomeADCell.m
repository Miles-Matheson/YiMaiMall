//
//  LDShopHomeADCell.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/28.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDShopHomeADCell.h"

@implementation LDShopHomeADCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        _shopADImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_shopADImageView];
//        _shopADImageView.contentMode =
        [_shopADImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.offset(0);
        }];
    }
    return self;
}

@end
