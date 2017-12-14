//
//  LDGoodsListCell.h
//  FullAndFresh
//
//  Created by Miles on 2017/9/7.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDGoodsListModel.h"

@interface LDGoodsLisCell : UICollectionViewCell

@property (nonatomic,strong)LDGoodsListModel *model;

@property (nonatomic,strong)UIImageView *topImageView;
@property (nonatomic,assign)BOOL isShowLogo;
@property (nonatomic,assign)BOOL isGrid;

@property(nonatomic,copy)void(^addItemClick)(NSInteger addCount ,NSInteger currentCount,LDGoodsLisCell *cell);

@end
