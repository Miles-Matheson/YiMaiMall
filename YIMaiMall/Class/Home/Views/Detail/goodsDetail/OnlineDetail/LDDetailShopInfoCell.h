//
//  LDDetailShopInfoCell.h
//  YIMaiMall
//
//  Created by Miles on 2017/11/17.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDGoodsDetailModel.h"

@interface LDDetailShopInfoCell : UICollectionViewCell

@property (nonatomic,strong)LDGoodsDetailModel *model;

/*
 * selectIndex 点击的按钮tag 1 联系卖家   2:进店逛逛
 */
@property (nonatomic, copy)void(^shopInfoClick)(NSInteger selectIndex);

@end
