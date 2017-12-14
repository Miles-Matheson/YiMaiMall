//
//  LDStarView.m
//  BaseFrame
//
//  Created by Miles on 2017/6/24.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import "LDStarView.h"

@implementation LDStarView
{
    UILabel *timeLab;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
       CGFloat width = (100 - 24)/5;
        
       CGFloat top = (frame.size.height-width)/2. + width/2.;
        for (int i = 0; i < 5; i ++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake((i *(width +6)) ,top , width, width);
            btn.tag = (i+1)*10;
            [btn setBackgroundImage:[UIImage imageNamed:@"star_3"] forState:0];
            [self addSubview:btn];
            btn.centerY = frame.size.height/2.;
            btn.userInteractionEnabled = NO;
        }
    }
    
    return self;
}

- (void)setStarCount:(CGFloat)starCount
{
    
    NSInteger  count = [[NSString stringWithFormat:@"%.f",starCount]  integerValue];
    
    for (UIView *view in self.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            if (view.tag <= (count*10)) {
                
                [btn setBackgroundImage:[UIImage imageNamed:@"star_3"] forState:0];
                
            }else{
                
                [btn setBackgroundImage:[UIImage imageNamed:@"star_4"] forState:0];
            }
        }
    }
    
    self.fenShuLab.text = [NSString stringWithFormat:@"%.1f分",starCount];
    
}


- (void)setTimeStr:(NSString *)timeStr
{
    _timeStr = timeStr;
    
    ws(bself);
    
    if (!timeLab) {
        
        timeLab = [[UILabel alloc]init];
        timeLab.textColor = RGB(138, 138, 138);
        timeLab.font = kFont14;
        [self  addSubview:timeLab];
        
        [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bself.fenShuLab.mas_right).offset(5);
            make.centerY.equalTo(bself.mas_centerY);
            make.width.offset(100);
            make.height.offset(25);
        }];
    }
    
    timeLab.text  = _timeStr;

}

- (UILabel *)fenShuLab
{
    if (!_fenShuLab) {
        UIView *view = self.subviews.lastObject;
        
        _fenShuLab = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"" textColor:BlackColor textAlignment:Left font:[UIFont systemFontOfSize:FONTFIT(15)]];
        [self addSubview:_fenShuLab];
        
        [_fenShuLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_right).offset(5);
            make.centerY.equalTo(view.mas_centerY);
        }];
    }
    return _fenShuLab;
}



@end
