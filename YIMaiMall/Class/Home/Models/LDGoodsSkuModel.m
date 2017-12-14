//
//  LDGoodsSkuModel.m
//  YIMaiMall
//
//  Created by Miles on 2017/12/4.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDGoodsSkuModel.h"


@implementation LDGoodsSkuStandardInfoModel
+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id",};
}
@end


@implementation LDGoodsSkuSiftKeyModel

+(NSDictionary *)mj_objectClassInArray{
    
    return @{
             @"standardInfoList":@"LDGoodsSkuStandardInfoModel",
             };
}
@end


@implementation LDGoodsSkuModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID":@"id",
             };
}

+(NSDictionary *)mj_objectClassInArray{
    
    return @{
             @"siftKey":@"LDGoodsSkuSiftKeyModel",
             };
}

@end
