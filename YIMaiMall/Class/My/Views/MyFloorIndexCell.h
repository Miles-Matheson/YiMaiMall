//
//  MyFloorIndex2Cell.h
//  YIMaiMall
//
//  Created by Miles on 2017/11/23.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CostomButton.h"
#import "LDFloorIndexModel.h"

@interface MyFloorIndexCell : UICollectionViewCell

@property (nonatomic,strong)LDFloorIndexModel *model;
@property (nonatomic, copy)void(^indexClickCallBack)(LDFloorIndexModel *model);
@end
