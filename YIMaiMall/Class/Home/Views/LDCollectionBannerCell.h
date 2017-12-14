//
//  LDHomeBannerCell.h
//  YIMaiMall
//
//  Created by Miles on 2017/11/15.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDHomeModel.h"

@interface LDCollectionBannerCell : UICollectionViewCell
@property (nonatomic,copy)NSArray<LDBannerModel*> *models;

@property (nonatomic,copy)void(^bannerClick)(LDBannerModel *model);
@end
