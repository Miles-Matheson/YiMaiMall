//
//  LDDetailPriceCell.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/17.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDDetailPriceCell.h"


@interface LDDetailPriceCell ()

@property (nonatomic,strong)  UILabel *currentPriceLB;
@property (nonatomic,strong)  UILabel *oldPriceLB;
@property (nonatomic,strong)  UIButton *backGDABtn;

@property (nonatomic,strong)  UILabel *freightLB;
@property (nonatomic,strong)  UILabel *volumeLB;
@property (nonatomic,strong)  UILabel *goodsAddLB;
@end

@implementation LDDetailPriceCell
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
    
    _currentPriceLB = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"" textColor:kAppSubThemeColor textAlignment:Left font:kFont18];
    [self.contentView addSubview:_currentPriceLB];
    [_currentPriceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.top.offset(10);
    }];
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:@"¥:66.00"];
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(0, 4)];
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(5, att.length-5)];
    _currentPriceLB.attributedText = att;
    
    _oldPriceLB = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"原价 ¥188.00" textColor:RGB(102, 102, 102) textAlignment:Left font:kFont14];
    [self.contentView addSubview:_oldPriceLB];
    
    [_oldPriceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_currentPriceLB.mas_right).offset(10);
        make.bottom.equalTo(_currentPriceLB.mas_bottom);
    }];
    
    _backGDABtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backGDABtn setImage:[UIImage imageNamed:@""] forState:0];
    [_backGDABtn setTitle:@" 33GDA" forState:0];
    [_backGDABtn setTitleColor:kAppThemeColor forState:0];
    [self.contentView addSubview:_backGDABtn];
    [_backGDABtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_oldPriceLB.mas_right).offset(30);
        make.bottom.equalTo(_currentPriceLB.mas_bottom);
    }];
    
    _freightLB = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"运费: ¥10.00" textColor:RGB(102, 102, 102) textAlignment:Left font:kFont14];
    [self.contentView addSubview:_freightLB];
    
    [_freightLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.right.offset(-12);
        make.bottom.offset(-8);
    }];
    
    
    _volumeLB = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"销量 :233" textColor:RGB(102, 102, 102) textAlignment:Left font:kFont14];
    [self.contentView addSubview:_volumeLB];
    
    [_volumeLB mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerX.offset(0);
         make.bottom.equalTo(_freightLB.mas_bottom);
    }];
    
    
    _goodsAddLB = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"合肥" textColor:RGB(102, 102, 102) textAlignment:Right font:kFont14];
    [self.contentView addSubview:_goodsAddLB];
    
    [_goodsAddLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-12);
         make.bottom.equalTo(_freightLB.mas_bottom);
    }];
}
@end

