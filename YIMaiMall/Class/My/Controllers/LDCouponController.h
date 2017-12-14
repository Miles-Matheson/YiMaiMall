//
//  LDCouponController.h
//  YIMaiMall
//
//  Created by Miles on 2017/11/30.
//  Copyright © 2017年 Miles. All rights reserved.
//

typedef enum : NSUInteger {
    CouponTypeNormal = 0,
    CouponTypeChoose,
    CouponTypeCanBeUse,
} CouponType;

#import "YPTabBarController.h"
#import "LDCouponListModel.h"

@interface LDCouponController : YPTabBarController

@property (nonatomic, assign) CouponType couponType;

@property (nonatomic, copy) NSArray<NSArray<LDCouponListModel*>*>* couponTotalList;

-(instancetype)initWithCouponType:(CouponType)couponType;
@end
