//
//  LDShopCartHeaderView.h
//  YIMaiMall
//
//  Created by Miles on 2017/11/18.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDShopCartModel.h"
@interface LDShopCartHeaderView : UITableViewHeaderFooterView

@property (nonatomic,strong)LDShopCartModel *model;

@property (nonatomic, copy) void(^selectItemClick)(LDShopCartHeaderView *headerView);
@property (nonatomic, copy) void(^editItemClick)(BOOL isEdit,NSInteger sectionIndex);

@property (nonatomic, assign)NSInteger sectionIndex;;

@end
