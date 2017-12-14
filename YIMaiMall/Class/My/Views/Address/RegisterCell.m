//
//  RegisterCell.m
//  BaseFrame
//
//  Created by Zxs on 16/12/14.
//  Copyright © 2016年 Zxs. All rights reserved.
//

#import "RegisterCell.h"
#define TextColor_shen RGB(104,104,104)
#define TextColor_qian RGB(205,203,204)

@interface RegisterCell()<UITextViewDelegate>

@property(nonatomic,strong)MASConstraint * titleLabelW;
@property(nonatomic,strong)MASConstraint * titleLabelL;
@property(nonatomic,strong)MASConstraint * contentTFR;
@property(nonatomic,strong)UIButton * qrButton;
@property(nonatomic,strong)UIView *line;

@end

@implementation RegisterCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        ws(bself);
        
        if ([reuseIdentifier isEqualToString:ReuseIdentifier_Address]) {
            if (!_addressTV) {
                _addressTV = [[UITextView alloc]initWithFrame:CGRectMake([MyAdapter laDapter:15], [MyAdapter laDapter:10], SCREEN_WIDTH-[MyAdapter laDapter:30], [MyAdapter laDapter:60])];
                _addressTV.font = [MyAdapter lfontADapter:15];
                _addressTV.delegate = self;
                [self.contentView addSubview:_addressTV];
                [_addressTV mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(SIZEFIT(15));
                    make.top.offset(SIZEFIT(10));
                    make.width.equalTo(bself.contentView.mas_width).offset(-SIZEFIT(30));
                    make.bottom.equalTo(bself.contentView.mas_bottom).offset(-0.5);
                }];
                
            }
            if (!_placeLabel) {
                _placeLabel = [[UILabel alloc]init];
                _placeLabel.textColor = RGB(51, 51, 51);
                _placeLabel.text = @"请填写详细地址，不少于5个字";
                _placeLabel.font = [MyAdapter lfontADapter:15];
                [self.contentView addSubview:_placeLabel];
                [_placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset([MyAdapter laDapter:15]);
                    make.top.offset([MyAdapter laDapter:15]);
                }];
            }
        }else{
            if (!_titleLabel) {
                _titleLabel = [[UILabel alloc]init];
                _titleLabel.font = [MyAdapter lfontADapter:16];
                _titleLabel.textColor = TextColor_shen;
                [self.contentView addSubview:_titleLabel];
                [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    _titleLabelL = make.left.offset([MyAdapter laDapter:20]);
                    _titleLabelW = make.width.offset([MyAdapter laDapter:100]);
                    make.centerY.offset(0);
                }];
            }
            if ([reuseIdentifier isEqualToString:ReuseIdentifier_DefaultAddress]){
                if (!_defaultSwitch) {
                    _defaultSwitch = [[UISwitch alloc]init];
                    [_defaultSwitch addTarget:self action:@selector(changeSeitch:) forControlEvents:UIControlEventValueChanged];
                    [self.contentView addSubview:_defaultSwitch];
                    [_defaultSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.offset(0);
                        make.right.offset([MyAdapter laDapter:-20]);
                    }];
                }
                [_titleLabelW uninstall];
                [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.offset([MyAdapter laDapter:20]);
                    _titleLabelW = make.width.offset([MyAdapter laDapter:160]);
                }];
            }else{
                if (!_contentTF) {
                    _contentTF = [[UITextField alloc]init];
                    _contentTF.font = [MyAdapter lfontADapter:16];
                    [self.contentView addSubview:_contentTF];
                    [_contentTF mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(_titleLabel.mas_right);
                        if ([reuseIdentifier isEqualToString:ReuseIdentifier_Code]) {
                            make.right.offset([MyAdapter laDapter:-120]);
                        }else if ([reuseIdentifier isEqualToString:ReuseIdentifier_QR]){
                            make.right.offset([MyAdapter laDapter:-50]);
                        }else{
                            _contentTFR = make.right.offset([MyAdapter laDapter:-20]);
                        }
                        make.height.offset([MyAdapter laDapter:55]);
                        make.centerY.offset(0);
                    }];
                }
                if ([reuseIdentifier isEqualToString:ReuseIdentifier_QR]) {
                    if (!_qrButton) {
                        _qrButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        [_qrButton addTarget:self action:@selector(qrClick) forControlEvents:UIControlEventTouchUpInside];
                        [_qrButton setImage:[UIImage imageNamed:@"qr"] forState:UIControlStateNormal];
                        [self.contentView addSubview:_qrButton];
                        [_qrButton mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.right.offset([MyAdapter laDapter:-15]);
                            make.centerY.offset(0);
                            make.width.height.offset([MyAdapter laDapter:25]);
                        }];
                    }
                }
                if ([reuseIdentifier isEqualToString:ReuseIdentifier_Code]) {
                    if (!_codeButton) {
                        UIView * verticalView = [[UIView alloc] init];
                        verticalView.backgroundColor = RGB(213, 213, 213);
                        [self.contentView addSubview:verticalView];
                        [verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.centerY.offset(0);
                            make.left.equalTo(_contentTF.mas_right).offset(0);
                            make.height.offset([MyAdapter laDapter:20]);
                            make.width.mas_equalTo(0.5);
                        }];
                        _codeButton = [[VerifyCodeButton alloc]init];
//                        [_codeButton setTitleColor:COMMON_TITLE_COLOE forState:UIControlStateNormal];
                        _codeButton.titleLabel.font = [MyAdapter lfontADapter:16];
                        [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                        [_codeButton addTarget:self action:@selector(sendCode) forControlEvents:UIControlEventTouchUpInside];
                        [self.contentView addSubview:_codeButton];
                        [_codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.equalTo(verticalView.mas_right).offset([MyAdapter laDapter:10]);
                            make.right.offset([MyAdapter laDapter:-20]);
                            make.centerY.equalTo(verticalView.mas_centerY);
                            make.height.offset([MyAdapter laDapter:30]);
                        }];
                    }
                }
            }
        }
        
        
        _line = [ViewCreate createLineFrame:CGRectMake([MyAdapter laDapter:15], [MyAdapter laDapter:55]-0.5, SCREEN_WIDTH -[MyAdapter laDapter:30], 0.5) backgroundColor:RGB(224, 226, 226)];
        [self.contentView addSubview:_line];
    }
    return self;
}
- (void)changeSeitch:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    if (self.switchChange) {
        self.switchChange(switchButton.isOn);
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (self.placeLabel) {
        self.placeLabel.hidden = YES;
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length<=0) {
        self.placeLabel.hidden = NO;
    }
}
-(void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    _titleLabel.textColor = titleColor;
}
-(void)setIsArea:(BOOL)isArea
{
    [_contentTFR uninstall];
    [_contentTF mas_updateConstraints:^(MASConstraintMaker *make) {
        _contentTFR = make.right.offset([MyAdapter laDapter:-5]);
    }];
}
-(void)setIsLOGIN:(BOOL)isLOGIN
{
    _isLOGIN = isLOGIN;
    if (isLOGIN) {
        [_titleLabelW uninstall];
        [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            _titleLabelW = make.width.offset([MyAdapter laDapter:80]);
        }];
    }
}
-(void)setTitleLabelLeft:(CGFloat)titleLabelLeft
{
    _titleLabelLeft = titleLabelLeft;
    [_titleLabelL uninstall];
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        _titleLabelL = make.left.offset(titleLabelLeft);
    }];
}

-(void)setTitleWidth:(CGFloat)titleWidth
{
    _titleWidth = titleWidth;
    [_titleLabelL uninstall];
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        _titleLabelL = make.width.offset(titleWidth);
        make.left.offset(0);
    }];
}
-(void)sendCode{
    if (self.code) {
        self.code();
    }
}

-(void)qrClick
{
    if (self.qrBlock) {
        self.qrBlock();
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _line.bottom = self.contentView.height;
}

@end
