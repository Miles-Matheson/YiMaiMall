//
//  LDOnlineOrderDetailHeaderView.h
//  YIMaiMall
//
//  Created by Miles on 2017/12/11.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDOrderDetailModel.h"

@interface LDOnlineOrderDetailHeaderView : UITableViewHeaderFooterView
@property (nonatomic,strong)LDOrderDetailModel *model;
@property (nonatomic, copy) void(^storeClickCallBack)(void);
@end
