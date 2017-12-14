//
//  LDSellerListCell.h
//  BaseFrame
//
//  Created by Miles on 2017/6/24.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDHomeModel.h"

@interface LDSellerListCell : UICollectionViewCell

@property (nonatomic,strong)LDSellerListModel *model;
@property (nonatomic, copy) void(^callItemClick)(LDSellerListModel *model);

@end
