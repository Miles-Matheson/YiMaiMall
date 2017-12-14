//
//  MessageModel.m
//  BaseFrame
//
//  Created by 陈舟为 on 2017/3/29.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

-(CGFloat)textHeight{
    
    if (_textHeight) return _textHeight;
    
    // 文字的宽度
    CGSize textMaxSize = CGSizeMake(SCREEN_WIDTH - 2 * (SIZEFIT(15) + SIZEFIT(12)),MAXFLOAT);
    
     CGFloat Height = [self.Content boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:FONTFIT(16)]} context:nil].size.height + SIZEFIT(5);
    
    
    _textHeight = Height;
    
    
    return _textHeight;
    
}

@end
