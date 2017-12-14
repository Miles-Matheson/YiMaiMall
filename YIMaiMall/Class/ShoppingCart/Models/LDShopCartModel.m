//
//  LDShopCartModel.m
//  YIMaiMall
//
//  Created by Miles on 2017/12/7.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDShopCartModel.h"

@implementation LDShopGoodsModel

@end

@implementation LDShopGoodsCartsModel

@end


@implementation LDShopCartModel

+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"goodsCarts":@"LDShopGoodsCartsModel",
             };
};
@end
