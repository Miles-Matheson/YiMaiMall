//
//  LDCouponListModel.h
//  YIMaiMall
//
//  Created by Miles on 2017/11/30.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDCouponListModel : NSObject

@property (nonatomic, copy) NSString * ID;//编号(long)
@property (nonatomic, copy) NSString * sn;//优惠券码(string)
@property (nonatomic, copy) NSString * stBeginTime;//开始时间(string)
@property (nonatomic, copy) NSString * stEndTime;//结束时间(string)
@property (nonatomic, copy) NSString * name;//代金券名称(string)
@property (nonatomic, copy) NSString * img;//图片（string）

@property (nonatomic, assign) CGFloat  orderAmount;//订单金额（bigdecimal)
@property (nonatomic, assign) CGFloat  amount;//优惠金额(bigdecimal)
@property (nonatomic, assign) NSInteger  useStatus;//（byte,0：未使用 1：已使用）
@property (nonatomic, assign) BOOL  status;//（byte,0：未过期 1：已过期）


@end
