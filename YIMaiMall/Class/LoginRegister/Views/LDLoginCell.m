//
//  LDLoginCell.m
//  FullAndFresh
//
//  Created by Miles on 2017/9/22.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDLoginCell.h"

@implementation LDLoginCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = 0;
        [self initUI];
        
    }
    return self;
}
- (void)initUI
{
    ws(bself);
    UIImageView *logoImageView = [UIImageView new];
    logoImageView.image = [UIImage imageNamed:@"logo"];
    [self.contentView addSubview:logoImageView];
    
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(SIZEFIT(90));
    }];
    
    
    UIView *topHLine = [ViewCreate createLineFrame:CGRectMake(0, 0, 20, 0) backgroundColor:RGB(236, 236, 236)];
    [self.contentView addSubview:topHLine];
    
    [topHLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZEFIT(25));
        make.right.offset(-SIZEFIT(25));
        make.height.offset(0.8);
        make.top.equalTo(logoImageView.mas_bottom).offset(SIZEFIT(80));
    }];

    _phoneBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    [_phoneBtn setTitle:@"+86" forState:UIControlStateNormal];
    [_phoneBtn setTitleColor:RGB(225, 225, 225) forState:UIControlStateNormal];
    [self.contentView addSubview:_phoneBtn];
   
    CGFloat width1 =  _phoneBtn.size.width;
    CGFloat height1 = _phoneBtn.size.height;
    
    [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topHLine.mas_left);
        make.bottom.equalTo(topHLine.mas_top).offset(-10);
        make.width.offset(width1);
        make.height.offset(height1);
    }];
    
    UIImageView *pswImageView = [UIImageView new];
    pswImageView.image = [UIImage imageNamed:@"icon_key"];
    [self.contentView addSubview:pswImageView];
    
    CGFloat width =  pswImageView.image.size.width;
    CGFloat height = pswImageView.image.size.height;
    
    [pswImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(topHLine.mas_left);
        if (kScreenWidth==320) {
             make.bottom.equalTo(topHLine.mas_bottom).offset(30);
        }else{
             make.bottom.equalTo(topHLine.mas_bottom).offset(50);
        }
        make.width.offset(width);
        make.height.offset(height);
    }];
    
    
    _phoneTextFild = [UITextField new];
    _phoneTextFild.placeholder  = @"请输入手机号";
    if ([kUserDefault objectForKey:PHONENUM]) {
        _phoneTextFild.text = [kUserDefault objectForKey:PHONENUM];
    }

    if (@available(iOS 10.0, *)) {
        _phoneTextFild.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
    } else {
        _phoneTextFild.keyboardType = UIKeyboardTypeASCIICapable;
    }
    _phoneTextFild.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneTextFild.font = kFont15;
    [self.contentView addSubview:_phoneTextFild];
    [_phoneTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_phoneBtn.mas_right).offset(15);
        make.bottom.equalTo(_phoneBtn.mas_bottom);
        make.right.equalTo(topHLine.mas_right);
    }];
    
    _pswTextFild = [UITextField new];
    _pswTextFild.placeholder  = @"请输符密码";
    _pswTextFild.font = kFont15;
    _pswTextFild.secureTextEntry = YES;
    _pswTextFild.clearsOnBeginEditing = YES;
    [self.contentView addSubview:_pswTextFild];
    [_pswTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pswImageView.mas_right).offset(15);
        make.bottom.equalTo(pswImageView.mas_bottom);
        make.right.equalTo(topHLine.mas_right);
    }];
    
    
    UIButton *yanBtn = [[UIButton alloc] init];
    [yanBtn setImage:[UIImage imageNamed:@"icon_hide"] forState:UIControlStateSelected];
    [yanBtn setImage:[UIImage imageNamed:@"icon_disp"] forState:UIControlStateNormal];
    yanBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:yanBtn];
    
    [yanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(SIZEFIT(-25));
        make.bottom.equalTo(pswImageView.mas_bottom);
    }];
    
    [yanBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *bottomHLine = [ViewCreate createLineFrame:CGRectMake(0, 0, 20, 0) backgroundColor:RGB(236, 236, 236)];
    [self.contentView addSubview:bottomHLine];
    [bottomHLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZEFIT(25));
        make.right.offset(-SIZEFIT(25));
        make.height.offset(0.8);
        make.top.equalTo(_pswTextFild.mas_bottom).offset(10);
    }];
    
    UIButton *loginBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"立即登录" titleColor:WhiteColor font:kFont17 backgroundColor:kAppThemeColor touchUpInsideEvent:^(UIButton *sender) {
        [_pswTextFild resignFirstResponder];
        [_phoneTextFild resignFirstResponder];
        if (bself.loginItemClick) {
            bself.loginItemClick(sender.tag,bself);
        }
    }];
    loginBtn.layer.masksToBounds  = YES;
    loginBtn.layer.cornerRadius = SIZEFIT(45)/2.;
    loginBtn.tag = 0;
    
    [self.contentView addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomHLine.mas_bottom).offset(SIZEFIT(30));
        make.height.offset(SIZEFIT(45));
        make.left.offset(25);
        make.right.offset(-25);
    }];
    
    
    for (int i = 0; i < 3; i ++) {
        
        NSString *name = i == 0?@"qq":i == 1?@"wechat":@"weibo";
        
        UIButton *thirdLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [thirdLoginBtn setImage:[UIImage imageNamed:name] forState:0];
        [thirdLoginBtn setImage:[UIImage imageNamed:name] forState:UIControlStateSelected];
        [self.contentView addSubview:thirdLoginBtn];
        thirdLoginBtn.tag = 3+i;
        
        [thirdLoginBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIButton * sender) {
            if (bself.loginItemClick) {
                bself.loginItemClick(sender.tag,bself);
            }
        }];
        [thirdLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(loginBtn.mas_bottom).offset(SIZEFIT(65));
            make.centerX.offset(i == 0?-SCREEN_WIDTH/4:i == 1?0:SCREEN_WIDTH/4);
        }];
    }
    
    UIImageView *thirdImageView = [[UIImageView alloc]init];
    thirdImageView.image = [UIImage imageNamed:@"or"];
    [self.contentView addSubview:thirdImageView];
    [thirdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(loginBtn.mas_bottom).offset(SIZEFIT(35));
    }];
    
    UIButton *finePswBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"忘记密码" titleColor:RGB(139, 139, 139) font:kFont14 backgroundColor:ClearColor touchUpInsideEvent:^(UIButton *sender) {
        if (bself.loginItemClick) {
            bself.loginItemClick(sender.tag,bself);
        }
    }];
    finePswBtn.tag = 1;
    [self.contentView addSubview:finePswBtn];
    [finePswBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(SIZEFIT(-30));
        make.right.equalTo(self.contentView.mas_centerX).offset(-20);
    }];
    
    UIButton *registerBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"快速注册" titleColor:RGB(249, 187, 4) font:kFont14 backgroundColor:ClearColor touchUpInsideEvent:^(UIButton *sender) {
        if (bself.loginItemClick) {
            bself.loginItemClick(sender.tag,bself);
        }
    }];
    registerBtn.tag = 2;
    [self.contentView addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       make.bottom.equalTo(self.contentView.mas_bottom).offset(SIZEFIT(-30));
        make.left.equalTo(self.contentView.mas_centerX).offset(20);
    }];
    
    UIView *bottomHline = [UIView new];
    [self.contentView addSubview:bottomHline];
    bottomHline.backgroundColor = RGB(225, 225, 225 );
    [bottomHline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.width.offset(1.0);
        make.height.offset(15);
        make.centerY.equalTo(registerBtn.mas_centerY);
    }];
}

-(void)clickAction:(UIButton *)btn{

        btn.selected = !btn.selected;
        self.pswTextFild.secureTextEntry = !self.pswTextFild.secureTextEntry;
}

@end
