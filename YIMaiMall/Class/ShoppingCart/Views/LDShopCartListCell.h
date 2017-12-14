//
//  LDShopCartListCell.h
//  YIMaiMall
//
//  Created by Miles on 2017/11/18.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDOrderModel.h"
#import "LDShopCartModel.h"
#import "LDStatementModel.h"

@interface LDShopCartListCell : UITableViewCell

@property (nonatomic,strong)LDOrderGoodsIndexModel *orderModel;   //订单列表
@property (nonatomic,strong)LDStatementListModel *statementModel;//确认订单列表
@property (nonatomic,strong)LDShopGoodsCartsModel *model;        //购物车列表

@property (nonatomic,strong)UIImageView *topImageView;

@property (nonatomic, copy) void(^selectItemClick)(LDShopCartListCell *cell);
@property (nonatomic, copy) void(^deleteItemClick)(LDShopCartListCell *cell);
@property (nonatomic, copy) void(^changeCountClick)(LDShopGoodsCartsModel *model,NSInteger changeCount,NSInteger currentCount);

@property (nonatomic,assign)BOOL isHiddenSelectBtn;

@property (nonatomic,assign)BOOL isEditing;

@end
