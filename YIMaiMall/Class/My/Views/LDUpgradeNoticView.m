//
//  LDUpgradeNoticView.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/30.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDUpgradeNoticView.h"

@implementation LDUpgradeNoticView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)tapBaseView:(UITapGestureRecognizer *)sender {
    
}
-(id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        NSArray *nibView =  [[NSBundle mainBundle] loadNibNamed:@"LDUpgradeNoticView"owner:self options:nil];
        UIView *backView = [nibView objectAtIndex:0];
        backView.frame = frame;
        [self addSubview:backView];
        
        backView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeSelf)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)removeSelf{
    
    [self removeFromSuperview];
}
- (IBAction)agreeClick:(UIButton *)sender {
    
    [LDAlterView  alterViewWithTitle:@"温馨提示" content:@"您已提交申请，请耐心等待，颐脉工作人员会及时联系您，请保持电话畅通" cancel:nil sure:@"确定" cancelBtClcik:nil  sureBtClcik:^{
        
    }];
//    if (self.agreeItemClick) {
//        self.agreeItemClick();
//    }
}

@end
