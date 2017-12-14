//
//  LDRegisterNewCell.m
//  YIMaiMall
//
//  Created by Miles on 2017/12/7.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDRegisterNewCell.h"

@implementation LDRegisterNewCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
    [_getCodeBtn setTitleColor:kAppThemeColor forState:UIControlStateNormal];
    [_getCodeBtn setTitleColor:WhiteColor forState:UIControlStateSelected];
}

/// tag 0 获取国家  1 获取验证码  2下一步
- (IBAction)registerCellClick:(UIButton *)sender {
    
    if (sender.tag == 0) {
        if (self.nextClick) {
            self.nextClick(0, _yaoQingCodeTF.text, _phoneTF.text,_zfCodeTF.text);
        }
    }else if (sender.tag == 1){
        
        if (![LLUtils validateMobile:self.phoneTF.text]){
            [Dialog toast:@"请输入正确的手机号码"];
            return;
        }
        if (self.nextClick) {
            self.nextClick(1, _yaoQingCodeTF.text, _phoneTF.text,_zfCodeTF.text);
        }
    }else if (sender.tag == 2){
        
        if (![LLUtils validateMobile:self.phoneTF.text]){
            [Dialog toast:@"请输入正确的手机号码"];
            return;
        }else if (_yaoQingCodeTF.text.length==0){
            [Dialog toast:@"请输入邀请码"];
            return;
        }else if (self.zfCodeTF.text.length == 0){
            [Dialog toast:@"请输入验证码"];
            return;
        }
        
        if (self.nextClick) {
            self.nextClick(2, _yaoQingCodeTF.text, _phoneTF.text,_zfCodeTF.text);
        }
    }
}
- (void)timeDown:(NSInteger)timeNum
{
    _getCodeBtn.selected = YES;
    
    NSString *string = [NSString stringWithFormat:@"%lds",timeNum];
    
    [_getCodeBtn setTitle:string forState:UIControlStateNormal];
    [_getCodeBtn setTitle:string forState:UIControlStateSelected];
    if (timeNum <= 0) {
        _getCodeBtn.selected = NO;
        [_getCodeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        [_getCodeBtn setTitle:@"重新获取" forState:UIControlStateSelected];
    }
    if (_getCodeBtn.selected) {
        _getCodeBtn.backgroundColor = kAppThemeColor;
    }else{
        _getCodeBtn.backgroundColor = WhiteColor;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
