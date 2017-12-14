//
//  LDQuanListCell.h
//  YIMaiMall
//
//  Created by Miles on 2017/11/30.
//  Copyright © 2017年 Miles. All rights reserved.
//


#define LDQuanListCell_Choose @"LDQuanListCell_Choose"
#define LDQuanListCell_CanBeUse @"LDQuanListCell_CanBeUse"
#define LDQuanListCell_Normal @"LDQuanListCell_Normal"

#import <UIKit/UIKit.h>
#import "LDCouponListModel.h"

@interface LDQuanListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UILabel *qunaNameLB;
@property (weak, nonatomic) IBOutlet UILabel *desLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UIImageView *quanImageView;

@property (nonatomic, assign) LDCouponListModel *model;
@property (nonatomic, copy) NSString *identifier;

@property (nonatomic, copy) void (^rightBtnClickCallBack)(LDCouponListModel *model);

@end
