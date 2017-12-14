//
//  LDFeatureSkuController.h
//  YIMaiMall
//
//  Created by Miles on 2017/12/6.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDBaseViewController.h"

@interface LDFeatureSkuController : LDBaseViewController
-(instancetype)initWithSkuData:(NSDictionary *)dataDic isBuyNow:(BOOL)isBuyNow;

@property (nonatomic, copy)void (^selectSkuCallBack)(NSString*skuInfo);
@end
