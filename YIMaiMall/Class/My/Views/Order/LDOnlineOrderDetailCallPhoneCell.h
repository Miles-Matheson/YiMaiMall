//
//  LDOnlineOrderDetailCallPhoneCell.h
//  YIMaiMall
//
//  Created by Miles on 2017/12/11.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDOnlineOrderDetailCallPhoneCell : UITableViewCell
@property (nonatomic, copy) void(^callPhoneClickCallBack)(NSInteger tag);

@end
