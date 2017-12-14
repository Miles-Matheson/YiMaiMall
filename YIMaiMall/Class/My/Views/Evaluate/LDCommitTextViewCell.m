//
//  LDCommitTextViewCell.m
//  StairOrder
//
//  Created by Miles on 2017/9/13.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDCommitTextViewCell.h"

@interface LDCommitTextViewCell ()<UITextViewDelegate>
{
    UILabel *textViewPlaceholderLabel;
    
}
@end

@implementation LDCommitTextViewCell

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
    
    _textView = [UITextView new];
    [self.contentView addSubview:_textView];
    _textView.delegate  = self;
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(5);
        make.right.bottom.offset(-5);
    }];
    
    textViewPlaceholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 6, 200, 20)];
    textViewPlaceholderLabel.text = @"请输入评价内容";
    textViewPlaceholderLabel.textColor = [UIColor grayColor];
    textViewPlaceholderLabel.font = kFont14;
    [_textView addSubview: textViewPlaceholderLabel];
}
//设置textView的placeholder
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //[text isEqualToString:@""] 表示输入的是退格键
    if ([text length] > 0)
    {
        textViewPlaceholderLabel.hidden = YES;
    }else if ([textView.text length] == 1 && [text isEqualToString:@""]){
        textViewPlaceholderLabel.hidden = NO;
    }
    if([text rangeOfString:@"\n"].location !=NSNotFound)//_roaldSearchText
    {
        [textView endEditing:YES];
    }
    else
    {
        NSLog(@"no");
    }
    
    
    NSString * toBeString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if (toBeString.length > 100 && range.length!=1){
        
        textView.text = [toBeString substringToIndex:100];
        
        return NO;
    }
    
    return YES;
}


@end
