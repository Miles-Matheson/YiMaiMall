//
//  LDStatementModel.h
//  YIMaiMall
//
//  Created by Miles on 2017/12/8.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LDCouponListModel.h"
#import "LDAddressListModel.h"

@interface LDStatementListModel : NSObject

@property (nonatomic, copy) NSString *advert;//商品描述
@property (nonatomic, copy) NSString *goodId;//商品编号
@property (nonatomic, copy) NSString *img;//图片
@property (nonatomic, copy) NSString *ID;//购物车商品编号(
@property (nonatomic, copy) NSString *name;//商品名称

@property (nonatomic, assign) CGFloat price;//价格
@property (nonatomic, assign) NSInteger count;//商品数量

@end

@interface LDStatementModel : NSObject

@property (nonatomic, copy) NSArray <LDCouponListModel*>*usable;//可用代金券列表
@property (nonatomic, copy) NSArray <LDCouponListModel*>*unusable;//不可用代金券列表
@property (nonatomic, strong) NSMutableArray <LDAddressListModel*>*addList;//地址列表
@property (nonatomic, copy) NSArray <LDStatementListModel*>*goodsList;//购物车商品

@property (nonatomic, assign) CGFloat freight;//运费（BigDecimal)
@property (nonatomic, assign) CGFloat total;//总价格（bigdecimal)

@property (nonatomic, copy) NSString *storeId;//店铺编号（long）
@property (nonatomic, copy) NSString *storeName;//：店铺名称（string）



@end
