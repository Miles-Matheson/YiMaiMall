//
//  LDOnLineGoodsClassModel.m
//  YIMaiMall
//
//  Created by Miles on 2017/12/6.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDOnLineGoodsClassModel.h"


@implementation LDOnLineGoodsClassSonModel


@end


@implementation LDOnLineGoodsClassModel
+(NSDictionary *)mj_objectClassInArray{
    
    return @{
             @"lowerLevel":[LDOnLineGoodsClassSonModel class],
             };
}

@end
