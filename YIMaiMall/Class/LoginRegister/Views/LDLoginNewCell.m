//
//  LGLoginNewCell.m
//  YIMaiMall
//
//  Created by Miles on 2017/12/7.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDLoginNewCell.h"

@implementation LDLoginNewCell

- (void)awakeFromNib {
    [super awakeFromNib];
 
}

/*
 0 登录
 1 忘记密码
 2 去注册
 3 qq登录
 4 微信登录
 5 微
 6 获取国家地区
 */
- (IBAction)loginOrThirdLogin:(UIButton *)sender {
    
    if (sender.tag == 0) {
    
        if (![LLUtils validateMobile:_phoneTF.text]) {
            [Dialog toastCenter:@"请输入正确的手机号"];
            return;
        }else if (_pswTF.text.length==0){
            [Dialog toastCenter:@"请输入密码"];
            return;
        }
    }
    
    if (_loginItemClick) {
        _loginItemClick(sender.tag,self);
    }
}





@end
