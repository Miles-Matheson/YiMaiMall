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

    _oldPriceLB = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"原价 ¥188.00" textColor:RGB(102, 102, 102) textAlignment:Left font:kFont14];
    [self.contentView addSubview:_oldPriceLB];
    
    [_oldPriceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_currentPriceLB.mas_right).offset(10);
        make.bottom.equalTo(_currentPriceLB.mas_bottom);
    }];
    
    _backGDABtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backGDABtn setImage:[UIImage imageNamed:@"rebate"] forState:0];
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
    
    
    _volumeLB = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"销量 :***" textColor:RGB(102, 102, 102) textAlignment:Left font:kFont14];
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

-(void)setModel:(LDGoodsDetailModel *)model{
    _model = model;
    
    NSString *price = [NSString stringWithFormat:@"¥:%.2f",_model.goodsCurrentPrice];
    NSString *tip1 = @"¥:";
    
    NSMutableAttributedString *priceAtt = [[NSMutableAttributedString alloc]initWithString:price];
    [priceAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0,tip1.length)];
    [priceAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(tip1.length, priceAtt.length-tip1.length)];
    _currentPriceLB.attributedText = priceAtt;
    
    NSString *oldPrice = [NSString stringWithFormat:@"原价 ¥:%.2f",_model.goodsPrice];
    NSString *tip = @"原价 ¥:";
    
    NSMutableAttributedString *oldAtt = [[NSMutableAttributedString alloc] initWithString:oldPrice
                                                                                attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleNone)}];
    [oldAtt setAttributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle),
                             NSBaselineOffsetAttributeName : @0}
                     range:NSMakeRange(tip.length, oldPrice.length-tip.length)];
    _oldPriceLB.attributedText = oldAtt;
    
    _volumeLB.text = [NSString stringWithFormat:@"销量 :%ld",_model.goodsSalenum];

    if (_model.gda) {
       NSString *gda =  [NSString stringWithFormat:@" %ldGDA",_model.gda];
        [_backGDABtn setTitle: gda forState:0];
        [_backGDABtn setImage:[UIImage imageNamed:@"rebate"] forState:0];
        _backGDABtn.hidden = NO;
    }else{
        _backGDABtn.hidden = YES;
    }
}
@end

