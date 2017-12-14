//
//  LDOrderModel.h
//  YIMaiMall
//
//  Created by Miles on 2017/11/23.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDOrderGoodsIndexModel : NSObject
@property (nonatomic, copy) NSString *  ID;             //购物车商品编号(long)
@property (nonatomic, copy) NSString *  goodId;         //商品编号(long)
@property (nonatomic, copy) NSString *  name;           //商品名称(string)
@property (nonatomic, copy) NSString *  advert;          //商品详情(string)
@property (nonatomic, assign) NSInteger   count;          //数量(int)
@property (nonatomic, assign) CGFloat   price;          //价格(BigDecimal)
@property (nonatomic, copy) NSString *  img;            //图片(string)
@end


@interface LDOrderModel : NSObject

@property (nonatomic, assign) NSInteger orderStatus;    //订单状态（int）
@property (nonatomic, copy) NSString *  orderId;        //订单编号（string）
@property (nonatomic, copy) NSString *  ID;             //订单编号（long）
@property (nonatomic, assign) CGFloat   goodsAmount;    //订单商品金额（BigDecimal）
@property (nonatomic, assign) CGFloat   totalPrice;     //订单总金额（BigDecimal）
@property (nonatomic, copy) NSString *  storeId;        //店铺编号（long）
@property (nonatomic, assign) CGFloat   shipPrice;      //运费（BigDecimal）
@property (nonatomic, copy) NSString *  storeName;      //店铺名称（string）

@property (nonatomic, copy) NSArray <LDOrderGoodsIndexModel*>*   list;           //商品列表

@end
