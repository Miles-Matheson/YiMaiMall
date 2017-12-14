//
//  LDTostView.m
//  FullAndFresh
//
//  Created by Miles on 2017/9/11.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "UIView+LDTostView.h"


@implementation UIView (LDTostView)


-(void)showImageTost:(NSString *)tost
{
    UIView *baseView = [UIView new];
    [self addSubview:baseView];
    baseView.backgroundColor = RGB(51, 51, 51);
    baseView.layer.masksToBounds = YES;
    baseView.layer.cornerRadius = 10;
    
    UIImageView *imgView = [UIImageView new];
    imgView.image = [UIImage imageNamed:@"fxs"];
    [baseView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(SIZEFIT(20));
    }];
    
    UILabel *tostLB = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:tost textColor:WhiteColor textAlignment:Center font:kFont14];
    tostLB.numberOfLines = 0;
    [baseView addSubview:tostLB];
    

    [tostLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-SIZEFIT(21));
        make.left.offset(SIZEFIT(23));
        make.right.offset(-SIZEFIT(23));
        make.centerX.offset(0);
    }];
    
    UIImage *image  = [UIImage imageNamed:@"fxs"];
    
    CGSize size = [LLUtils getStringSize:tost font:14 width:SCREEN_WIDTH -SIZEFIT(100) - SIZEFIT(45)];
    
    CGFloat width = 0;
    
    CGFloat height1 = image.size.height +SIZEFIT(42);
    
    if (size.width < height1 + size.height +SIZEFIT(20)) {
        
        width = height1 + size.height +SIZEFIT(20);
        
    }else if (size.width + 50 > SCREEN_WIDTH -SIZEFIT(100) - SIZEFIT(45)){
        width = size.width+10;
    }
    
    baseView.center = self.center;
    
    [UIView animateKeyframesWithDuration:0.3 delay:0.01 options:UIViewKeyframeAnimationOptionOverrideInheritedDuration animations:^{
        baseView.frame = CGRectMake(0, 0, width +SIZEFIT(46), height1 + size.height +SIZEFIT(20));
        baseView.center = self.center;
        
    } completion:^(BOOL finished) {

        
        [UIView animateKeyframesWithDuration:0.3 delay:1.0 options:UIViewKeyframeAnimationOptionOverrideInheritedDuration animations:^{

            baseView.frame = CGRectMake(0, 0, width +SIZEFIT(46), height1 + size.height +SIZEFIT(20));
            baseView.center = self.center;
            
        } completion:^(BOOL finished) {
            
            baseView.bounds  = CGRectMake(0, 0, 10, 10);
            baseView.center = self.center;
            [baseView removeFromSuperview];
            
        }];
    }];
}

@end
