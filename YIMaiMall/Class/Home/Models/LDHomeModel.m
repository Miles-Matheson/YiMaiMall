//
//  LDHomeModel.m
//  StairOrder
//
//  Created by Miles on 2017/8/21.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDHomeModel.h"

@implementation LDBannerModel
@end

@implementation LDClickIndexModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}

@end

@implementation LDNoticModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end

@implementation LDHomeAreaModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end

@implementation LDSellerListModel
@end


@implementation LDNewsModel
@end

@implementation LDHomeModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"ClassList":[LDClickIndexModel class],
             @"noticArray":[LDNoticModel class],
             @"areaList":[LDHomeAreaModel class],
             @"publicList":[LDGoodsListModel class],
             };
}

@end
