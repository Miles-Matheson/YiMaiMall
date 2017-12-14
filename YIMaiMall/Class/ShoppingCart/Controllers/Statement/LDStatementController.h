//
//  LDStatementController.h
//  YIMaiMall
//
//  Created by Miles on 2017/11/21.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDBaseViewController.h"
#import "LDShopCartModel.h"
@interface LDStatementController : LDBaseViewController
@property (nonatomic, copy) NSArray<LDShopGoodsCartsModel *> *modelList;//指定数组内是LDGoodsListModel 类型
@end
