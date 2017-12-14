//
//  LDOnlineOrderDetailCallPhoneCell.m
//  YIMaiMall
//
//  Created by Miles on 2017/12/11.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDOnlineOrderDetailCallPhoneCell.h"

@implementation LDOnlineOrderDetailCallPhoneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)itemClick:(UIButton *)sender {
    
    if (_callPhoneClickCallBack) {
        _callPhoneClickCallBack(sender.tag);
    }
}
@end
