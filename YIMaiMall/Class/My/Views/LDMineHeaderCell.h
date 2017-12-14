//
//  LDMineHeaderCell.h
//  YIMaiMall
//
//  Created by Miles on 2017/11/28.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDMineHeaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLB;
@property (weak, nonatomic) IBOutlet UIButton *clickBtn;
@property (weak, nonatomic) IBOutlet UILabel *goodsSaveLB;
@property (weak, nonatomic) IBOutlet UILabel *shopSaveLB;
@property (weak, nonatomic) IBOutlet UILabel *historyLB;
@property (weak, nonatomic) IBOutlet UILabel *roleLB;
@property (weak, nonatomic) IBOutlet UIView *bgImageView;

@property (nonatomic, copy) void(^headerClick)(UIButton *btn);
@property (nonatomic, copy) void(^bottomClick)(NSInteger selectIndex);

@end
