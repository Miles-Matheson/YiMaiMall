//
//  LDShopHomeHeaderCell.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/28.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDShopHomeHeaderCell.h"

@implementation LDShopHomeHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.contentView.backgroundColor = WhiteColor;
        UILabel *lab = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"为您推荐" textColor:RGB(51,51,51) textAlignment:Left font:kFont14];
        [self.contentView addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(25);
            make.centerY.offset(0);
        }];
    }
    return self;
}

@end
