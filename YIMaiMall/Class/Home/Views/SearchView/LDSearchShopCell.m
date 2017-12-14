//
//  LDSearchShopCell.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/21.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDSearchShopCell.h"

@implementation LDSearchShopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(LDShopListModel *)model{
    _model = model;
    
    [_topImageView sd_setImageWithURL:[NSURL URLWithString:_model.storeLogo] placeholderImage:[UIImage imageNamed:KplaceholderImage]];
    
    _nameLB.text = _model.storeName;
//    _desLB.text =
    
    for (UIView *view in self.contentView.subviews) {
        
        if ([view isKindOfClass:[UIImageView class]]){
            UIImageView *imgView = (UIImageView *)view;
            
            if (imgView.tag< _model.storRrecommendGoods.count && _model.storRrecommendGoods.count) {
                LDShopRrecommendGoodsModel *rrecommendGoodsModel = _model.storRrecommendGoods[imgView.tag];
                [imgView sd_setImageWithURL:[NSURL URLWithString:rrecommendGoodsModel.img] placeholderImage:[UIImage imageNamed:KplaceholderImage]];
            }
        }
    }
    
}

@end
