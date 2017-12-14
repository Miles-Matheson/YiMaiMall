//
//  LDCommentModel.m
//  BaseFrame
//
//  Created by Miles on 2017/7/3.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import "LDCommentModel.h"

@implementation LDCommentModel

- (CGFloat)cellHeight
{

    CGFloat top =  70.0;
    CGFloat contentHeight = 0.0;
    CGFloat imgViewHeight = 0.0;
    CGFloat commentViewHeight = 0.0;
    
    if (self.evaluateInfo != nil) {
        contentHeight =   [LLUtils getSpaceLabelHeight: self.evaluateInfo withFont:13 lineSpacing:3 withWidth:SCREEN_WIDTH-68-8] +15;
    }

    CGFloat cha = 0;
    
    CGFloat height = 0;
    
    int indexRow = 0;
    
    if (_imgs.count >0 ) {
        
        if (_imgs.count == 1) {
            height =   (SCREEN_WIDTH-68)/2.;
        }else if (_imgs.count > 1){
            height =   (SCREEN_WIDTH-68)/3.;
        }
        if (_imgs.count>3) {
            cha = 10;
        }
        indexRow  = (int)_imgs.count/3;
        imgViewHeight = indexRow*(height+cha) +10;
    }
    
    if (self.Reply.length >0) {
        NSString *str = [NSString stringWithFormat:@"商家回复: %@",self.Reply];
        CGSize size =   [LLUtils getStringSize:str font:14 width:SCREEN_WIDTH-68];
        commentViewHeight = size.height + 35;
    }
    
    _cellHeight = top + contentHeight +imgViewHeight  +commentViewHeight;

    return _cellHeight;
}


@end
