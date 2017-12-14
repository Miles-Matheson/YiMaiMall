//
//  LDNoticCollectionCell.h
//  FullAndFresh
//
//  Created by Miles on 2017/9/7.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDHomeModel.h"
@interface LDNoticCollectionCell : UICollectionViewCell

@property (nonatomic, copy)void (^itemClick)(LDNoticModel *model);

@property (nonatomic,copy)NSArray <LDNoticModel*>*newsModels;

@end
