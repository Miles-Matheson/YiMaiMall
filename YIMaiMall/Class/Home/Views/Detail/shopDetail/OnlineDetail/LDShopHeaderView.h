//
//  LDShopHeaderView.h
//  YIMaiMall
//
//  Created by Miles on 2017/11/25.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDStoreModel.h"

@interface LDShopHeaderView : UIView

 @property (nonatomic,strong)UIButton *foxButton;
@property (nonatomic,strong)LDStoreModel *model;
@property (nonatomic, copy) void (^foucsClick)(void);
@end
