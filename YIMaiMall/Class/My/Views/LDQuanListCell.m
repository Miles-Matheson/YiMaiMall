//
//  LDQuanListCell.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/30.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDQuanListCell.h"

@interface LDQuanListCell()
@property (nonatomic,strong)UIButton *selectButton;
@property (nonatomic,strong)UILabel *priceLB;
@end


@implementation LDQuanListCell

-(UIButton *)selectButton{
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.baseView addSubview:_selectButton];
        [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.offset(0);
            make.width.offset(50);
        }];
    }
    return _selectButton;
}


-(void)setIdentifier:(NSString *)identifier{
    _identifier  = identifier;
    [self setQuanTypeWithReuseIdentifier:_identifier];
}

-(UILabel *)priceLB{
    if (!_priceLB ) {
        _priceLB = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"" textColor:WhiteColor textAlignment:Center font:kFont20];
        [self.quanImageView addSubview:_priceLB];
        [_priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.offset(0);
        }];
    }
    return _priceLB;
}

- (void)awakeFromNib {
    [super awakeFromNib];

}

-(void)setQuanTypeWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    ws(bself);
    if ([reuseIdentifier isEqualToString:LDQuanListCell_Choose] ||[reuseIdentifier isEqualToString:LDQuanListCell_CanBeUse] ) {
        
        [self.selectButton handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIButton* sender) {
            if ([reuseIdentifier isEqualToString:LDQuanListCell_Choose]) {
                 sender.selected =  !sender.selected;
            }
            if (bself.rightBtnClickCallBack) {
                bself.rightBtnClickCallBack(bself.model);
            }
        }];
        [self.baseView addSubview:self.selectButton];
    }
}

-(void)setModel:(LDCouponListModel *)model{
    _model = model;
    
    if (_model.status == 3 ){
        
        _quanImageView.image = [UIImage imageNamed:@"coupon_used"];
        //        _qunaNameLB.text = @"";
        //        _desLB.text = @"";
        //        _timeLB.text = @"";
        
        return;
        
    }else  if (_model.status == 0) {///商城优惠券
        _quanImageView.image = [UIImage imageNamed:@"coupon_1"];
//        _qunaNameLB.text = @"";
//        _desLB.text = @"";
//        _timeLB.text = @"";
    }else if (_model.status == 1){///店铺优惠券
        
        self.quanImageView.image = [UIImage imageNamed:@"coupon_2"];
        //        _qunaNameLB.text = @"";
        //        _desLB.text = @"";
        //        _timeLB.text = @"";
        
    }else if (_model.status == 2){///会员优惠券
        
        _quanImageView.image = [UIImage imageNamed:@"coupon_3"];
        //        _qunaNameLB.text = @"";
        //        _desLB.text = @"";
        //        _timeLB.text = @"";
    }

    
    if ([_identifier isEqualToString:LDQuanListCell_CanBeUse]) {
        
        if (_model.status == 0) {
            [self.selectButton setImage:[UIImage imageNamed:@"coupon_btn1"] forState:UIControlStateNormal];
        }else if (_model.status == 1){
            [self.selectButton setImage:[UIImage imageNamed:@"coupon_btn2"] forState:UIControlStateNormal];
        }else if (_model.status == 2){
            [self.selectButton setImage:[UIImage imageNamed:@"coupon_btn3"] forState:UIControlStateNormal];
        }
    }else if ([_identifier isEqualToString:LDQuanListCell_Choose]){

     [self.selectButton setImage:[UIImage imageNamed:@"choose3"] forState:UIControlStateNormal];
     [self.selectButton setImage:[UIImage imageNamed:@"choose4"] forState:UIControlStateSelected];
        
    }
    
    NSString *string = @"¥10";
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:string];
    
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22] range:NSMakeRange(0, 1)];
    [att addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:40] range:NSMakeRange(1, string.length-1)];
    
    self.priceLB.attributedText = att;
    
}
@end
