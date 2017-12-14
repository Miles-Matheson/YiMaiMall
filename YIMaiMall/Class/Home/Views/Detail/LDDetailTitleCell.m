//
//  LDDetailTitleCell.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/17.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDDetailTitleCell.h"

@interface LDDetailTitleCell ()

@property (nonatomic,strong)  UILabel *contentLB;
@property (nonatomic,strong)  UILabel *subContentLB;
@end

@implementation LDDetailTitleCell
{
  

}
-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self initUI];
        self.contentView.backgroundColor = WhiteColor;
    }
    return self;
}

-(void)initUI{
    
    _contentLB = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"古洁 家洁氧颗粒洗涤剂 厨房多用途清洁剂重油污去污除垢洗涤剂" textColor:RGB(51, 51, 51) textAlignment:Left font:kFont15];
    _contentLB.numberOfLines = 0;
    [self.contentView addSubview:_contentLB];
    
    [_contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.right.offset(-12);
        make.top.offset(SIZEFIT(18));
    }];
    
    _subContentLB = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"有氧洗涤新概念 安全无毒更放心" textColor:kAppSubThemeColor textAlignment:Left font:kFont12];
    [self.contentView addSubview:_subContentLB];
    [_subContentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.right.offset(-12);
        make.bottom.offset(0);
    }];
}
@end
