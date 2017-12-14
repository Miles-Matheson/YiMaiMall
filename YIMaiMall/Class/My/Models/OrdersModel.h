//
//  OrdersModel.h
//  BaseFrame
//
//  Created by 陈舟为 on 2017/6/29.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OrdersDetailModel;

@interface OrdersModel : NSObject

@property(nonatomic,strong)NSArray *Button;

@property(nonatomic,assign)NSInteger CommodityNum;

@property(nonatomic,copy)NSString *DiscountAmount;

@property(nonatomic,copy)NSString *DispatcherFee;

@property(nonatomic,assign)NSInteger ID;

@property(nonatomic,copy)NSString *No;

@property(nonatomic,copy)NSString *OrderAmount;

@property(nonatomic,strong)NSMutableArray<OrdersDetailModel *> *OrderDetail;

@property(nonatomic,copy)NSString *PaymentAmount;

//状态
@property(nonatomic,assign)NSInteger Status;

//状态名
@property(nonatomic,copy)NSString *StatusName;

//商家名
@property(nonatomic,copy)NSString *SupplierName;


//详情中多的
@property(nonatomic,copy)NSString *Address;

@property(nonatomic,copy)NSString *MemberAddressName;

@property(nonatomic,copy)NSString *Mobile;

@property(nonatomic,copy)NSString *Des;

//评论中多的
@property(nonatomic,copy)NSString *OrderID;

@end

@interface OrdersDetailModel : NSObject

@property(nonatomic,copy)NSString *CommodityDes;

@property(nonatomic,assign)NSInteger CommodityID;

@property(nonatomic,copy)NSString *CommodityName;

@property(nonatomic,copy)NSString *CommodityPic;

@property(nonatomic,assign)NSInteger ID;

@property(nonatomic,copy)NSString *MemberPrice;

@property(nonatomic,copy)NSString *Num;

@property(nonatomic,copy)NSString *ReturnsNumber;

@property(nonatomic,assign)NSInteger SKUID;

//评论中多的
@property(nonatomic,copy)NSString *SKUName;

//退货中用的
@property(nonatomic,assign)BOOL selected;


//商品评价中的加的
@property(nonatomic,assign)NSInteger score;//评分

@property(nonatomic,copy)NSString *content;//评论内容

@property(nonatomic,strong)NSMutableArray *imgsArr,*Assets;//照片

@end


@interface MaxNumModel : NSObject

@property(nonatomic,assign)NSInteger MaxNum;

@end
