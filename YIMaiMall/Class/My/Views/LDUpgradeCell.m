//
//  LDUpgradeCell.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/29.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDUpgradeCell.h"

@implementation LDUpgradeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)upgradeClick:(UIButton *)sender {
    
    if (self.upgradeClick) {
        self.upgradeClick();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
