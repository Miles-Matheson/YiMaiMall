//
//  GoodsAddressController.h
//  BaseFrame
//
//  Created by Miles on 2017/6/23.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import "LDBaseViewController.h"
#import "LDAddressListModel.h"

@interface LDAddressListController : LDBaseViewController

@property(nonatomic,assign)BOOL comeFromMy;

@property(nonatomic,copy)void(^chageNewAdressCallBack)(LDAddressListModel *model);

@end
