//
//  LDSendInfoCell.h
//  BaseFrame
//
//  Created by Miles on 2017/6/23.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDSendInfoCell : UITableViewCell
@property (nonatomic,strong)UIButton *sendBtn ;
@property (nonatomic,copy)void(^sendBtnClick)(void);
@end
