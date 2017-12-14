//
//  LFButton.m
//  FullAndFresh
//
//  Created by Miles on 2017/9/7.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LFButton.h"

@implementation LFButton

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect titleF = self.titleLabel.frame;
    CGRect imageF = self.imageView.frame;
    
//    titleF.origin.x = 0;
    self.titleLabel.frame = titleF;
    imageF.origin.x = CGRectGetMaxX(titleF);
    self.imageView.frame = imageF;
    
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
}
@end
