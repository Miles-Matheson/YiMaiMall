//
//  LDShopListModel.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/21.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDShopListModel.h"

@implementation LDShopRrecommendGoodsModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID":@"id",
             };
}

@end

@implementation LDShopListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"ID":@"id",
             };
}

+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"storRrecommendGoods":@"LDShopRrecommendGoodsModel",
             };
}

@end
