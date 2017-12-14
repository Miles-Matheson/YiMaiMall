//
//  LDAddressIndexCell.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/21.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDAddressIndexCell.h"

@implementation LDAddressIndexCell

-(UILabel *)tostLB{
    
    if (!_tostLB) {
        _tostLB = [[UILabel alloc]init];
        _tostLB.text = @"请选择收货地址";
        [self.contentView addSubview:_tostLB];
        [_tostLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.offset(0);
        }];
    }
    return _tostLB;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIImageView *imgView = [UIImageView new];
    [self.contentView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
    }];
    imgView.image = [UIImage imageNamed:@"line-1"];
}


-(void)setModel:(LDAddressListModel *)model{
    _model = model;
    
    if (_model) {
        _addressNameLB.text = _model.truename;
        _addressNumberLB.text = _model.mobile;
        _addressContentLB.text = _model.areaInfo;
        _tostLB.hidden = YES;
    }else{
        self.tostLB.hidden = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
