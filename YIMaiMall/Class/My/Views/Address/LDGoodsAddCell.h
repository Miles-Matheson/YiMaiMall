//
//  LDGoodsAddCell.h
//  BaseFrame
//
//  Created by Miles on 2017/6/23.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDAddressListModel.h"

typedef void(^AddressBlock)(LDAddressListModel *model);

@interface LDGoodsAddCell : UITableViewCell
@property (nonatomic,strong)LDAddressListModel *model;

@property(nonatomic,copy)AddressBlock adderssBlock,bianjiBlock,shanchuBlock;


+ (LDGoodsAddCell *)shareInstance;
@end
