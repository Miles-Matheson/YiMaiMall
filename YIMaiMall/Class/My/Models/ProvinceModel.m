//
//  ProvinceModel.m
//  BaseFrame
//
//  Created by Zxs on 17/1/6.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import "ProvinceModel.h"
@implementation AreaModel

+(NSDictionary*)mj_replacedKeyFromPropertyName  {
    return @{@"ID":@"id",
             };
}
@end


@implementation CityModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"childs":@"AreaModel"};
}

+(NSDictionary*)mj_replacedKeyFromPropertyName  {
    return @{@"ID":@"id",
             };
}
@end



@implementation ProvinceModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"childs":@"CityModel"};
}
+(NSDictionary*)mj_replacedKeyFromPropertyName  {
    return @{@"ID":@"id",
             };
}
@end





