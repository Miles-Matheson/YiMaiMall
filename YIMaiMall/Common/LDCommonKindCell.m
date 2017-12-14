
//
//  LDCommonKindCell.m
//  StairOrder
//
//  Created by Miles on 2017/8/19.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDCommonKindCell.h"

@interface LDCommonKindCell  ()<UITextFieldDelegate>

@property (nonatomic,strong)UIView *bottomLine;

@end

@implementation LDCommonKindCell


+ (instancetype)cellWithTableView:(UITableView *)tableView KindTypetype:(LDCommonKindType)kindType
 {
        // NSLog(@"cellForRowAtIndexPath");

         // 1.缓存中取
         LDCommonKindCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%ld",kindType]];
         // 2.创建
         if (cell == nil) {
                 cell = [[LDCommonKindCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%ld",kindType]];
             }
         return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle  = UITableViewCellSelectionStyleNone;
        [self initUIWithKindTypetype:[self.reuseIdentifier integerValue]];
    }
    return self;
}

- (void)initUIWithKindTypetype:(LDCommonKindType)kindType
{
    if (kindType == LDCommonKindTypeDeulat) {
        
        [self.countentTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.right.offset(-10);
            make.centerY.offset(0);
        }];
        
    }else if (kindType == LDCommonKindTypeCode){
        
    }else if (kindType == LDCommonKindTypeCountTF){
        
    }else if (kindType == LDCommonKindTypeSwitch){
        
    }
}

- (UIButton *)countDownBtn
{
    if (!_countDownBtn) {
        _countDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_countDownBtn];
    }
    return _countDownBtn;
}

-(UIView*)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        [self.contentView addSubview:_bottomLine];
        _bottomLine.backgroundColor = RGB(235, 235, 235);
        [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.bottom.offset(-0.5);
            make.height.offset(0.5);
        }];
    }
    return _bottomLine;
}

- (UITextField *)countentTF
{
    if (!_countentTF) {
        _countentTF = [UITextField new];
        _countentTF.delegate = self;
        [self.contentView addSubview:_countentTF];
    }
    return _countentTF;
}

//判断输入钱的正则表达式，可输入正负，小数点前5位，小数点后2位，位数可控
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *toString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (_commonTFType == LDCommonTFTypePrice) {
        
        if (toString.length > 0) {
            NSString *stringRegex = @"(\\+|\\-)?(([0]|(0[.]\\d{0,2}))|([1-9]\\d{0,10}(([.]\\d{0,2})?)))?";
            NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegex];
            BOOL flag = [phoneTest evaluateWithObject:toString];
            if (!flag) {
                return NO;
            }
        }
         return YES;
    }else if (_commonTFType == LDCommonTFTypeNumber){
        
    }else if (_commonTFType == LDCommonTFTypePhone){
        
       
        if (toString.length > 0) {
            
            return  ![LLUtils validateMobile:toString];
        }
        
    }else if (_commonTFType == LDCommonTFTypePassWord){
        
        return  ![LLUtils validatePassword:toString];
    }
    
    return YES;
}

- (void)setCommonTFType:(LDCommonTFType)commonTFType
{
    _commonTFType = commonTFType;
    
    if (commonTFType == LDCommonTFTypeDeulat) {
        
        
    }else if (commonTFType == LDCommonTFTypePhone){
        
        self.countentTF.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
        
    }else if (commonTFType == LDCommonTFTypeNumber){
        
        self.countentTF.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
        
    }else if (commonTFType == LDCommonTFTypePrice){
        
        self.countentTF.keyboardType = UIKeyboardTypeDecimalPad;
        
    }else if (commonTFType == LDCommonTFTypePassWord){

        
    }
    
    
}

@end
