//
//  LDFindPswCell.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/28.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDFindPswCell.h"

@interface LDFindPswCell ()
@property (nonatomic,strong)UIButton *codeBtn;
@end


@implementation LDFindPswCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.selectionStyle = 0;
        
        self.backgroundColor = ClearColor;
        [self initUI];
        
    }
    return self;
}
- (void)initUI
{
    ws(bself);

    for (int i = 0 ; i < 4; i ++) {
        
        UIView *topHLine = [ViewCreate createLineFrame:CGRectMake(0, 0, 20, 0) backgroundColor:RGB(236, 236, 236)];
        [self.contentView addSubview:topHLine];
        
        [topHLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(SIZEFIT(25));
            make.right.offset(-SIZEFIT(25));
            make.height.offset(0.8);
            make.top.equalTo(self.contentView.mas_top).offset(SIZEFIT(55)+(i*SIZEFIT(45)));
        }];
        
        
        NSString *name = i==0?@"icon_phone":i == 1?@"icon_yz":i == 2?@"icon_key":@"icon_again";
        NSString *placeholder =  i==0?@"请输入您的手机号码":i == 1?@"请输入验证码":i == 2?@"请设置您的新密码":@"请确认您的新密码";
        
        UIImageView *leftImageView = [UIImageView new];
        [self.contentView addSubview:leftImageView];
        leftImageView.image = [UIImage imageNamed:name];
        [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(topHLine.mas_left);
            make.bottom.equalTo(topHLine.mas_top).offset(-10);
        }];
        
        [self.contentView layoutIfNeeded];
        
        UITextField *textField = [UITextField new];
        textField.placeholder  = placeholder;
        textField.font = kFont15;
        [self.contentView addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftImageView.mas_right).offset(15);
            make.centerY.equalTo(leftImageView.mas_centerY);
            make.right.equalTo(topHLine.mas_right);
            make.height.offset(40);
        }];
        
        if (i == 0){
            _phoneTextFild = textField;
        }else if (i == 1){
            _ZFcodeTextFild = textField;
        }else if (i == 2){
            _pswTextFild = textField;
            _pswTextFild.secureTextEntry = YES;
            _pswTextFild.clearsOnBeginEditing = YES;
        }else{
            _rePswTextFild = textField;
            _rePswTextFild.secureTextEntry = YES;
            _pswTextFild.clearsOnBeginEditing = YES;
        }
    }
    
    
    _codeBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"获取验证码" titleColor:WhiteColor font:kFont13 backgroundColor:kAppThemeColor touchUpInsideEvent:^(UIButton *sender) {
        
        [bself registerClick:sender];
    }];
    _codeBtn.tag = 0;
    _codeBtn.layer.masksToBounds = YES;
    _codeBtn.layer.cornerRadius = 5;
    [self.contentView addSubview:_codeBtn];
    [_codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bself.ZFcodeTextFild.mas_centerY);
        make.right.offset(-SIZEFIT(30));
        make.height.offset(30);
        make.width.offset(SIZEFIT(80));
    }];
    
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setTitleColor:WhiteColor forState:UIControlStateNormal];
    [registerButton setTitle:@"完成" forState:UIControlStateNormal];
    registerButton.titleLabel.font = kFont17;
    registerButton.backgroundColor = kAppThemeColor;
    [registerButton handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
        [bself registerClick:sender];
    }];
    registerButton.layer.masksToBounds  = YES;
    registerButton.layer.cornerRadius = 45./2;
    registerButton.tag = 1;
    [self.contentView addSubview:registerButton];
    
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_rePswTextFild.mas_bottom).offset(SIZEFIT(25));
        make.height.offset(45);
        make.left.offset(SIZEFIT(25));
        make.right.offset(-SIZEFIT(25));
    }];
}

- (void)registerClick:(UIButton *)btn
{
    /*
     0 获取验证码
     1 注册
     2 用户协议
     */
    
    if (btn.tag == 0) {
        
        if (btn.selected) {
            return;
        }else if (![LLUtils validateMobile:self.phoneTextFild.text]){
            [Dialog toast:@"请输入正确的手机号码"];
            return;
        }else{
            if (self.findItemClick) {
                self.findItemClick(btn.tag,self);
            }
        }
    }else if (btn.tag == 1){
        
        if (![LLUtils validateMobile:self.phoneTextFild.text]){
            [Dialog toast:@"请输入正确的手机号码"];
            return;
        }else if (self.pswTextFild.text.length == 0){
            [Dialog toast:@"请输入验证码"];
            return;
        }else if (![LLUtils validatePassword:self.rePswTextFild.text]){
            [Dialog toast:@"请输入6-16位字符密码"];
            return;
        }else{
            if (self.findItemClick) {
                self.findItemClick(btn.tag,self);
            }
        }
        
    }else if (btn.tag == 2){
        
        if (self.findItemClick) {
            self.findItemClick(btn.tag,self);
        }
    }
}

- (void)timeDown:(NSInteger)timeNum
{
    _codeBtn.selected = YES;
    
    NSString *string = [NSString stringWithFormat:@"%lds",timeNum];
    
    [_codeBtn setTitle:string forState:UIControlStateNormal];
    [_codeBtn setTitle:string forState:UIControlStateSelected];
    if (timeNum <= 0) {
        _codeBtn.selected = NO;
        [_codeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        [_codeBtn setTitle:@"重新获取" forState:UIControlStateSelected];
    }
}

@end

