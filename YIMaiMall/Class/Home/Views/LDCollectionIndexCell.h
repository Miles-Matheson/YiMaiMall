//
//  LDHomeIndexCell.h
//  StairOrder
//
//  Created by Miles on 2017/8/15.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDHomeModel.h"
@interface LDCollectionIndexCell : UICollectionViewCell

@property (nonatomic,copy)NSArray *models;

@property (nonatomic,copy)void(^itemClickCallBack)(LDClickIndexModel * model);

@end
