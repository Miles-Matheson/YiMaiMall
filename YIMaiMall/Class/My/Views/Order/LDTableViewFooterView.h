//
//  LDTableViewFooterView.h
//  YIMaiMall
//
//  Created by Miles on 2017/11/23.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDOrderModel.h"



@interface LDTableViewFooterView : UITableViewHeaderFooterView

@property (nonatomic,strong)LDOrderModel *model;
@property (nonatomic, copy) void(^statusCliackCallBack)(NSInteger selectIndex,LDOrderModel*model);
@end
