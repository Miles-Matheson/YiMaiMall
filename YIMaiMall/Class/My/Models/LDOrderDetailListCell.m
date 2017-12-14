//
//  LDOrderDetailListCell.m
//  YIMaiMall
//
//  Created by Miles on 2017/12/11.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDOrderDetailListCell.h"

@implementation LDOrderDetailListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setListModel:(LDOrderGoodsListModel *)listModel{
    
    _listModel = listModel;
    
    [_logoImageView sd_setImageWithURL:[NSURL URLWithString:_listModel.imgPath] placeholderImage:[UIImage imageNamed:KplaceholderImage]];
    _godsNameLB.text = _listModel.goodsName;
    _goodsDesLB.text = _listModel.goodsDescribe;
    _priceLB.text = [NSString stringWithFormat:@"¥:%.2f",_listModel.totalPrice];
    _countLB.text = [NSString stringWithFormat:@"x%ld",_listModel.count];
}

@end
