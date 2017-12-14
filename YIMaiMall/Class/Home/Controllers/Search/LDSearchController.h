//
//  LDSearchController.h
//  FullAndFresh
//
//  Created by Miles on 2017/9/28.
//  Copyright © 2017年 Miles. All rights reserved.
//


typedef enum : NSUInteger {
    SearchDataTypeSeller = 0,
    SearchDataTypeGoods,
} SearchDataType;

#import "LDBaseViewController.h"



@interface LDSearchController : LDBaseViewController
@property (nonatomic, assign) SearchDataType SearchDataType;
@end
