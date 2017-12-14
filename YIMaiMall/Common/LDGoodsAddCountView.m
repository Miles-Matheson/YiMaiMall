//
//  LDGoodsAddCountView.m
//  FullAndFresh
//
//  Created by Miles on 2017/9/18.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDGoodsAddCountView.h"

@interface LDGoodsAddCountView ()
@property (nonatomic,strong)UITextField *textField;
@property (nonatomic,strong)UIButton *releaseBtn;
@property (nonatomic,strong)UIButton *addBtn;
@property (nonatomic,assign)NSInteger number;
@end

@implementation LDGoodsAddCountView

-(id)init
{
    if (self = [super init]) {
        
        [self initUI];
        
        _canBeZero = YES;
    }
    return self;
}

-(void)initUI
{
    ws(bself);
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn setTitleColor:kAppThemeColor forState:0];
    [_addBtn setTitle:@"+" forState:0];
    _addBtn.titleLabel.font = Font20;
    _addBtn.layer.masksToBounds = YES;
    _addBtn.layer.cornerRadius = 25/2.;
    _addBtn.layer.borderColor = RGB(223,223, 223).CGColor;
    _addBtn.layer.borderWidth = 0.5;
    _addBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //但是问题又出来，此时文字会紧贴到做边框，我们可以设置
    _addBtn.contentEdgeInsets = UIEdgeInsetsMake(-2,0, 0, 0);
    [self addSubview:_addBtn];
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.bottom.offset(-10);
        make.width.height.offset(25);
    }];
    [_addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _textField = [UITextField new];
    _textField.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
    _textField.textAlignment = 1;
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.font = [UIFont systemFontOfSize:15];
    _textField.textColor = RGB(136, 137, 137);
    _textField.hidden = YES;
    [self addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_addBtn.mas_left).offset(-3);
        make.centerY.equalTo(_addBtn.mas_centerY);
        make.height.offset(30);
        make.width.offset(40);
    }];
    
    _releaseBtn = [[UIButton alloc] init];
    _releaseBtn.hidden = YES;
    [_releaseBtn setTitleColor:kAppThemeColor forState:0];
    [_releaseBtn setTitle:@"-" forState:0];
    _releaseBtn.titleLabel.font = Font20;
    _releaseBtn.layer.masksToBounds = YES;
    _releaseBtn.layer.cornerRadius = 25/2.;
    _releaseBtn.layer.borderColor = RGB(223,223, 223).CGColor;
    _releaseBtn.layer.borderWidth = 0.5;
    _releaseBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //但是问题又出来，此时文字会紧贴到做边框，我们可以设置
    _releaseBtn.contentEdgeInsets = UIEdgeInsetsMake(-2,0, 0, 0);
    [_releaseBtn addTarget:self action:@selector(releaseClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_releaseBtn];
    [_releaseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bself.addBtn.mas_centerY);
        make.right.offset(-90);
        make.width.height.offset(25);
    }];
    
    [_textField.rac_textSignal subscribeNext:^(id x){
        
        if ([_textField isFirstResponder]) {
            return ;
        }
        
        if (!_canBeZero && [x isEqualToString:@"0"]) {
            
            _textField.text = @"1";
            
            return;
        }else{
            
            NSInteger num = [x integerValue];
            
            NSInteger nowCount = 0;
            
            if (num == bself.number) {
                return ;
                
            }else{
                nowCount = num-bself.number;
            }
            
            //  bself.model.ShoppingCart = num;
            bself.number = num;
            
            // if (bself.addOrRelease) {
            //    bself.addOrRelease(nowCount,bself);
            // }
            
            [self itemClickWithAddCount:nowCount currentCount:_number];
        }
    }];
}


-(void)releaseClick:(UIButton *)button
{
    WS(bself);
    
    
    if (!_canBeZero && _number == 1) {
        return;
    }else{
       
        _number --;
        
        self.textField.text = [NSString stringWithFormat:@"%ld",_number];
        
        if (_number == 0) {
            self.textField.hidden = YES;
            [UIView animateWithDuration:0.5 animations:^{
                [bself.releaseBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(bself.addBtn.mas_centerY);
                    make.right.offset(-80);
                    make.width.height.offset(25);
                    bself.releaseBtn.hidden = YES;
                }];
            }];
        }
        
        //    bself.model.ShoppingCart = _number;
        //
        //    if (bself.addOrRelease) {
        //        bself.addOrRelease(-1,bself);
        //    }
        
        [self itemClickWithAddCount:-1 currentCount:_number];
        
        if (_number<= 0) {
            //        bself.model.ShoppingCart = _number = 0;
            _releaseBtn.hidden = _textField.hidden = YES;
        }else{
            _releaseBtn.hidden = _textField.hidden = NO;
        }
    }
}


-(void)addBtnClick:(UIButton *)button
{
    WS(bself);
    _number ++;
    self.textField.text = [NSString stringWithFormat:@"%ld",_number];
    self.textField.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        [bself.releaseBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bself.addBtn.mas_centerY);
            make.right.offset(-80);
            make.width.height.offset(25);
            bself.releaseBtn.hidden = NO;
        }];
    }];
    
    //    bself.model.ShoppingCart = _number;
    //
    //    if (bself.addOrRelease) {
    //        bself.addOrRelease(1,bself);
    //    }
    
    [self itemClickWithAddCount:1 currentCount:_number];
}

-(void)setCount:(NSInteger)count
{
    _count = count;
    self.number = count;
    self.textField.text = [NSString stringWithFormat:@"%ld",count];
}

-(void)setNumber:(NSInteger)number
{
    _number = number;
    
    if (_number<= 0) {
        _releaseBtn.hidden = _textField.hidden = YES;
    }else{
        _releaseBtn.hidden = _textField.hidden = NO;
    }
}

-(void)itemClickWithAddCount:(NSInteger)addcount currentCount:(NSInteger)currentCount
{
    if ([_delegate respondsToSelector:@selector(LDGoodsAddCountViewClickView:currentCount:AddCount:)]) {
        
        [_delegate LDGoodsAddCountViewClickView:self currentCount:currentCount AddCount:addcount];
    }
}

@end
