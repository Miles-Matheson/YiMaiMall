//
//  NewOrdersCommentViewController.h
//  BaseFrame
//
//  Created by 陈舟为 on 2017/7/13.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import "LDBaseViewController.h"

@interface LDWriteCommentViewController : LDBaseViewController

@property(nonatomic,copy)NSString * ID;

@property(nonatomic,copy)void(^DetailRefreshBlock)();

@end
