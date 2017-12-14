//
//  LDBaseCategoryModel.m
//  FullAndFresh
//
//  Created by Miles on 2017/10/13.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDBaseCategoryModel.h"

@implementation LDCategoryThirdChildModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID":@"id",
             };
}
@end

@implementation LDCategorySecondChildModel

+(NSDictionary*)mj_objectClassInArray
{
    return @{@"childs":[LDCategoryThirdChildModel class]};
}
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID":@"id",
             };
}
@end

@implementation LDBaseCategoryModel

- (id)copyWithZone:(NSZone *)zone{
    
    LDBaseCategoryModel * model = [[[self class] allocWithZone:zone] init];
    model.childs = self.childs;//self是被copy的对象
    model.iconUrl = self.iconUrl;
    model.ID = self.ID;
    model.classname = self.classname;
    return model;
}

- (id)mutableCopyWithZone:(NSZone *)zone{
    
    LDBaseCategoryModel * model = [[[self class] allocWithZone:zone] init];
    model.childs = self.childs;//self是被copy的对象
    model.iconUrl = self.iconUrl;
    model.ID = self.ID;
    model.classname = self.classname;
    return model;
}

+(NSDictionary*)mj_objectClassInArray
{
    return @{@"childs":[LDCategorySecondChildModel class]};
}

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID":@"id",
             };
}
@end

