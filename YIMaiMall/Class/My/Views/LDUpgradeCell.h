//
//  LDUpgradeCell.h
//  YIMaiMall
//
//  Created by Miles on 2017/11/29.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDUpgradeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLB;
@property (weak, nonatomic) IBOutlet UILabel *roleLB;
@property (weak, nonatomic) IBOutlet UILabel *priceLB;
@property (weak, nonatomic) IBOutlet UILabel *desLB;

@property (nonatomic, copy) void (^upgradeClick)(void);

@end
