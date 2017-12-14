//
//  LDStatementModel.m
//  YIMaiMall
//
//  Created by Miles on 2017/12/8.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDStatementModel.h"

@implementation LDStatementListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID":@"id",
             };
}

@end

@implementation LDStatementModel



+(NSDictionary*)mj_objectClassInArray{
    return @{
             @"usable":@"LDCouponListModel",
             @"unusable":@"LDCouponListModel",
             @"addList":@"LDAddressListModel",
             @"goodsList":@"LDStatementListModel",
             };
}

@end
