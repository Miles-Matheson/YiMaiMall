//
//  LDGoodsListView.h
//  FullAndFresh
//
//  Created by Miles on 2017/10/17.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDGoodsListModel.h"
@interface LDGoodsListView : UIView
@property (nonatomic, strong) LDGoodsListModel *model;
@property (nonatomic, copy) void (^itemClickCallBack)(LDGoodsListModel *model);
@end
