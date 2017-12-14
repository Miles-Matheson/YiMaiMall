//
//  LDOrderDetailModel.m
//  YIMaiMall
//
//  Created by Miles on 2017/12/11.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDOrderDetailModel.h"

@implementation LDOrderGoodsListModel

@end

@implementation LDOrderDetailModel

+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"orderGoods":@"LDOrderGoodsListModel",
             };
}

@end
