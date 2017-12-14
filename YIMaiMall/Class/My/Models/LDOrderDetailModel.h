//
//  LDOrderDetailModel.h
//  YIMaiMall
//
//  Created by Miles on 2017/12/11.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <Foundation/Foundation.h>

//@interface LDOrderDetailModel : NSObject
//
//@end
//
@interface LDOrderGoodsListModel : NSObject

@property (nonatomic, copy) NSString *goodsDescribe;
@property (nonatomic, copy) NSString *goodsName;
@property (nonatomic, copy) NSString *imgPath;
@property (nonatomic, copy) NSString *goodsId;
@property (nonatomic, copy) NSString *storeId;
@property (nonatomic, copy) NSString *storeName;

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger gda;
@property (nonatomic, assign) CGFloat totalPrice;

@end


@interface LDOrderDetailModel : NSObject

@property (nonatomic, copy) NSString *addTime;          //（订单开始 时间）
@property (nonatomic, copy) NSString *paytTme;          //付款时间）
@property (nonatomic, copy) NSString *returnShipTime;   //（退回时间）
@property (nonatomic, copy) NSString *shipTime;         //（发货时间）
@property (nonatomic, copy) NSString *finishTime;       //(订单完成时间)
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *goodsAmount;
@property (nonatomic, copy) NSString *transport;        //运输方式）
@property (nonatomic, copy) NSString *orderId;          //订单id）
@property (nonatomic, copy) NSString *orderNumber;      //订单号）
@property (nonatomic, copy) NSString *storeId;
@property (nonatomic, copy) NSString *storeName;
@property (nonatomic, copy) NSString *storeTelephone;
@property (nonatomic, copy) NSString *trueName;
@property (nonatomic, copy) NSArray <LDOrderGoodsListModel*>*orderGoods;
@property (nonatomic, assign) BOOL hasCoupon;             //（是否有 可用优惠券）
@property (nonatomic, assign) CGFloat totalPrice;        //（总价）
@property (nonatomic, assign) NSInteger orderStatus;    //（订单状态 0已取消 10待支付 20待发货 30待收货 40待评价 50已完成 60结束）

@end
