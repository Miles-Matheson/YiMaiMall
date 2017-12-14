//
//  LDRegisterSubmitCell.m
//  YIMaiMall
//
//  Created by Miles on 2017/12/7.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDRegisterSubmitCell.h"

@implementation LDRegisterSubmitCell
{
    BOOL didAgreeProtocol;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    ws(bself);
    _pswTF.secureTextEntry  = _repPswTF.secureTextEntry  = YES;
    _pswTF.clearsOnBeginEditing =  _repPswTF.clearsOnBeginEditing = YES;
    
    [_showPswBtn setImage:[UIImage imageNamed:@"icon_hide"] forState:UIControlStateNormal];
    [_showPswBtn setImage:[UIImage imageNamed:@"icon_disp"] forState:UIControlStateSelected];
    
    [_showRePswBtn setImage:[UIImage imageNamed:@"icon_hide"] forState:UIControlStateNormal];
    [_showRePswBtn setImage:[UIImage imageNamed:@"icon_disp"] forState:UIControlStateSelected];
    
    didAgreeProtocol = YES;
    
    UIButton *finePswBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@" 我同意" titleColor:RGB(139, 139, 139) font:kFont14 backgroundColor:ClearColor touchUpInsideEvent:^(UIButton *sender) {
        sender.selected = !sender.selected;
        didAgreeProtocol = sender.selected;
    }];
    
    [finePswBtn setImage:[UIImage imageNamed:@"nosel"] forState:UIControlStateNormal];
    [finePswBtn setImage:[UIImage imageNamed:@"icon_agree"] forState:UIControlStateSelected];
    finePswBtn.selected = YES;
    [self.contentView addSubview:finePswBtn];
    [finePswBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_repPswTF.mas_bottom).offset(SIZEFIT(25));
        make.left.offset(SIZEFIT(25));
    }];
    
    UIButton *protocolBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"《用户注册协议》" titleColor:kAppThemeColor font:kFont14 backgroundColor:ClearColor touchUpInsideEvent:^(UIButton *sender) {
        if (bself.submitClick) {
             bself.submitClick(0, @"");
        }
    }];
    protocolBtn.tag = 2;
    [self.contentView addSubview:protocolBtn];
    [protocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(finePswBtn.mas_centerY);
        make.left.equalTo(finePswBtn.mas_right);
    }];
}

/// tag 0 密码明文 1 确认密码铭文
- (IBAction)showPswClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.tag == 0) {
        _pswTF.secureTextEntry =  !_pswTF.secureTextEntry;
    }else{
        _repPswTF.secureTextEntry =  !_repPswTF.secureTextEntry;
    }
}

- (IBAction)doneButtonClick:(UIButton *)sender {
    
    if (!didAgreeProtocol) {
        [KeyWindow showCenterToast:@"请先同意用户注册协议后再注册!"];
        return;
    }else if (![_pswTF.text isEqualToString:_repPswTF.text]){
        [Dialog toast:@"两次密码不一致,请确认密码"];
        return;
    }else{
        if (self.submitClick) {
            self.submitClick(1, _pswTF.text);
        }
    }
}

@end
