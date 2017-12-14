//
//  PayOrderViewController.h
//  BaseFrame
//
//  Created by 陈舟为 on 2017/6/28.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import "LDBaseViewController.h"

@interface PayOrderViewController : LDBaseViewController

@property(nonatomic,copy)NSString *orderName;
@property(nonatomic,copy)NSString *orderID;
@property(nonatomic,assign)CGFloat orderAmount;

@property(nonatomic,copy)NSString *gda;

@property(nonatomic,assign)BOOL maiDan;

@end

