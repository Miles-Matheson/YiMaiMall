//
//  LDOrderModel.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/23.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDOrderModel.h"

@implementation LDOrderGoodsIndexModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"ID":@"id",
             };
}

@end

@implementation LDOrderModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"ID":@"id",
             };
}

+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"list":@"LDOrderGoodsIndexModel",
             };
}

@end
