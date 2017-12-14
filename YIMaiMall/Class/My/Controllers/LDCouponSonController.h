//
//  LDCouponSonController.h
//  YIMaiMall
//
//  Created by Miles on 2017/11/30.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDBaseViewController.h"
#import "LDCouponListModel.h"
@interface LDCouponSonController : LDBaseViewController
-(instancetype)initWithReuseIdentifier:(NSString *)identifier;
@property (nonatomic, copy) NSArray<LDCouponListModel*> *couponModelList;
@end
