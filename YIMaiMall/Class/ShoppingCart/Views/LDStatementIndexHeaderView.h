//
//  LDStatementIndexHeaderView.h
//  FullAndFresh
//
//  Created by Miles on 2017/9/29.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDStatementIndexHeaderView : UITableViewHeaderFooterView

@property (nonatomic,strong)UILabel *titleLB;

@property (nonatomic,copy)void(^itemSelectCallBack)(LDStatementIndexHeaderView*headerView, NSString *title);
@end
