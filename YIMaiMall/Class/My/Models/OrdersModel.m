//
//  OrdersModel.m
//  BaseFrame
//
//  Created by 陈舟为 on 2017/6/29.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import "OrdersModel.h"


@implementation OrdersModel


+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"No":@"NO",
             };
}

+ (NSDictionary *)objectClassInArray {
    
    return @{@"OrderDetail":[OrdersDetailModel class]};
    
}




@end

@implementation OrdersDetailModel




@end


@implementation MaxNumModel



@end
