//
//  LDRegisterNewCell.h
//  YIMaiMall
//
//  Created by Miles on 2017/12/7.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDRegisterNewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *yaoQingCodeTF;

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;

@property (weak, nonatomic) IBOutlet UITextField *zfCodeTF;

@property (weak, nonatomic) IBOutlet UIButton *chooseCountryBtn;
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

/// tag 0 获取国家  1 获取验证码  2下一步
@property (nonatomic, copy) void (^nextClick)(NSInteger index, NSString *yaoQingCode,NSString *phoneNumber,NSString *zfCode);

- (void)timeDown:(NSInteger)timeNum;
@end
