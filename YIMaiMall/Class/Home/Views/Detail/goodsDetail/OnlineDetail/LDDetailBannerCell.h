//
//  LDDetailBannerCell.h
//  YIMaiMall
//
//  Created by Miles on 2017/11/17.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDGoodsDetailModel.h"
@interface LDDetailBannerCell : UICollectionViewCell

@property (nonatomic,strong)LDGoodsDetailModel*model;

@property (nonatomic, copy) void(^foucsClick)(LDGoodsDetailModel*model);


@end
