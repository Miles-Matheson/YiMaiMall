//
//  LDGoodsDetailController.h
//  YIMaiMall
//
//  Created by Miles on 2017/11/16.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "YPTabBarController.h"

@interface LDBaseGoodsDetailController : YPTabBarController

@property (nonatomic, copy) NSString *goodsID;

-(instancetype)initWithGoodsID:(NSString *)goodsID;
@end
