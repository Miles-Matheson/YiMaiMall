//
//  LDHomeAreaCell.h
//  StairOrder
//
//  Created by Miles on 2017/8/21.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDHomeModel.h"
@interface LDHomeAreaCell : UICollectionViewCell
/*
 0 :左边
 
 1 :右上1
 
 2 :右上2
 
 3 :右下3
 
 4 :右下4
 
 */
@property (nonatomic,copy)void(^areaItemClick)(LDHomeAreaModel*model);

@property (nonatomic,copy)NSArray <LDHomeAreaModel*>*models;
@end
