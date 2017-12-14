//
//  LDDetailSkuClickCell.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/17.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDDetailSkuClickCell.h"

@interface LDDetailSkuClickCell ()

@property (nonatomic,strong)  UILabel *chooseSkuLB;
@property (nonatomic,strong)  UILabel *titleLB;

@end

@implementation LDDetailSkuClickCell
-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self initUI];
        self.contentView.backgroundColor = WhiteColor;
    }
    return self;
}

-(void)initUI{
    
    UIView *topLine = [UIView new];
    topLine.backgroundColor = RGB(225, 225, 225);
    [self.contentView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.offset(0.8);
    }];
    
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = RGB(225, 225, 225);
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.offset(0.5);
    }];
    
    _titleLB = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"请选择:颜色分类" textColor:RGB(102,102, 102) textAlignment:Left font:kFont14];
    [self.contentView addSubview:_titleLB];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.centerY.offset(0);
    }];
    
    _chooseSkuLB = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"" textColor:RGB(51,51, 51) textAlignment:Left font:kFont15];
    [self.contentView addSubview:_chooseSkuLB];
    [_chooseSkuLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLB.mas_right).offset(10);
        make.centerY.offset(0);
    }];

    UIImageView *imgView = [UIImageView new];
    imgView.image = [UIImage imageNamed:@""];
    [self.contentView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.offset(-12);
    }];
}
@end
