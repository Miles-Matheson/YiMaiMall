//
//  LDYZCodeView.m
//  FullAndFresh
//
//  Created by Miles on 2017/9/26.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDYZCodeView.h"

@interface  LDYZCodeView()

@property (nonatomic,strong)UIView *baseView;
@property (nonatomic,strong)UIImageView *codeImageView;

@end

@implementation LDYZCodeView

-(instancetype)init
{
    self = [super init];
    if (self) {
        ws(bself);
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
       
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
        _baseView = [UIView new];
        [self addSubview:_baseView];
        
        _baseView.backgroundColor = WhiteColor;
        _baseView.layer.masksToBounds = YES;
        _baseView.layer.cornerRadius = 10;
        [_baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.centerY.offset(-40);
            make.width.offset(SCREEN_WIDTH-80);
            make.height.offset(200);
        }];
        
        
        UILabel *lab = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"请输入验证码" textColor:BlackColor textAlignment:Center font:kFont16];
        [_baseView addSubview:lab];
        
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.offset(25);
        }];
        
        _codeTextFiled = [UITextField new];
        _codeTextFiled.borderStyle = UITextBorderStyleRoundedRect;
        [_baseView addSubview:_codeTextFiled];
        [_codeTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(20);
            make.centerY.offset(0);
            make.height.offset(40);
            make.right.equalTo(_baseView.mas_centerX).offset(20);
        }];
        
        _codeImageView = [UIImageView new];
        _codeImageView.backgroundColor = kAppThemeColor;
        [_baseView addSubview:_codeImageView];
        _codeImageView.userInteractionEnabled = YES;
       UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappp)];
        [_codeImageView addGestureRecognizer:tap];
        
        [_codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.equalTo(_codeTextFiled.mas_right).offset(10);
            make.right.offset(-20);
            make.height.equalTo(_codeTextFiled.mas_height);
        }];
        
        
        UIView *bottomHLine = [ViewCreate createLineFrame:CGRectMake(0, 0, 20, 0) backgroundColor:RGB(222, 222, 222)];
        [_baseView addSubview:bottomHLine];
        [bottomHLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(0.6);
            make.centerX.offset(0);
            make.bottom.offset(0);
            make.height.offset(SIZEFIT(45));
        }];
        
        UIView *bottomVLine = [ViewCreate createLineFrame:CGRectMake(0, 0, 20, 0) backgroundColor:RGB(222, 222, 222)];
        [_baseView addSubview:bottomVLine];
        
        [bottomVLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.height.offset(0.6);
            make.bottom.offset(-SIZEFIT(45));
        }];
        
  
        //取消按钮
        UIButton *cancelBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"取消" titleColor: RGB(75, 75, 75) font:kFont16 backgroundColor:WhiteColor touchUpInsideEvent:^(UIButton *sender) {
            [bself cancelBtClick];
        }];
        [_baseView addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.offset(0);
            make.top.equalTo(bottomVLine.mas_bottom);
            make.right.equalTo(bottomHLine.mas_left);
        }];
        
        //确定按钮
        UIButton *sureBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"确定" titleColor:kAppThemeColor font:kFont16 backgroundColor:WhiteColor touchUpInsideEvent:^(UIButton *sender) {
            
            if (_codeTextFiled.text.length == 0) {
                [Dialog toastCenter:@"请输入验证码"];
                return ;
            }
            
            if (_sureBlock) {
                _sureBlock(_codeTextFiled.text);
            }
        }];
        
        [_baseView addSubview:sureBtn];
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.bottom.offset(0);
            make.top.equalTo(bottomVLine.mas_bottom);
            make.left.equalTo(bottomHLine.mas_right);
        }];
    }
    return self;
}

#pragma mark----取消按钮点击事件
-(void)cancelBtClick
{
    [_baseView removeFromSuperview];
    _baseView = nil;
    [self removeFromSuperview];
}
#pragma mark----确定按钮点击事件
-(void)sureBtClick
{
//    [_baseView removeFromSuperview];
//    _baseView = nil;
//    [self removeFromSuperview];
//    self.sure_block();
}

-(void)tappp
{
    if (_selectImageCallBack) {
        _selectImageCallBack();
    }
}

-(void)setCodeImage:(UIImage *)codeImage{
    _codeImage = codeImage;
    
    _codeImageView.image = _codeImage;

}

@end
