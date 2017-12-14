//
//  LDGoodsDetailModel.m
//  YIMaiMall
//
//  Created by Miles on 2017/12/4.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDGoodsDetailModel.h"

@implementation LDGoodsDetailBannerModel : NSObject

//+(NSDictionary *)mj_replacedKeyFromPropertyName{
//    return @{
//             @"ID":@"id",
//             };
//}

@end

@implementation LDGoodsEvaluateDtoModel : NSObject

@end


@implementation LDGoodsStoreInfoModel : NSObject

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID":@"id",
             };
}

@end

@implementation LDGoodsDetailModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID":@"id",
             @"bannerList":@"banner",
             @"des":@"description",
             };
}

+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"bannerList":[LDGoodsDetailBannerModel class],
             };
}

//natomic, copy) NSArray <LDGoodsDetailBannerModel*>*bannerList;//（（分类id）
//@property (nonatomic, strong)LDGoodsEvaluateDtoModel *goodsEvaluateDto;
//@property (nonatomic, strong)LDGoodsStoreInfoModel *shopStoreDto;

@end
