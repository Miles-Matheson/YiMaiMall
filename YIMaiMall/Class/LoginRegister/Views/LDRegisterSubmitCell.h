//
//  LDRegisterSubmitCell.h
//  YIMaiMall
//
//  Created by Miles on 2017/12/7.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDRegisterSubmitCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *pswTF;

@property (weak, nonatomic) IBOutlet UITextField *repPswTF;
@property (weak, nonatomic) IBOutlet UIButton *showPswBtn;
@property (weak, nonatomic) IBOutlet UIButton *showRePswBtn;

//index 0 注册协议   1 注册
@property (nonatomic, copy) void (^submitClick)(NSInteger index, NSString *psw);

@end
