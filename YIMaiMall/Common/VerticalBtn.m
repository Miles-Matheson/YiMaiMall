//
//  VerticalBtn.m
//  BaseFrame
//
//  Created by 陈舟为 on 2017/6/14.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import "VerticalBtn.h"

@interface VerticalBtn ()

@property(nonatomic,weak)UIImageView *imgView;

@property(nonatomic,weak)UILabel *titLab;

@property(nonatomic,weak)UIView *countView;

@end

@implementation VerticalBtn

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
    
        UIImageView *image = [[UIImageView alloc] init];
        
        image.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:image];
        
        self.imgView = image;
        
        UILabel *lab = [[UILabel alloc] init];
        
        lab.textAlignment = 1;
        
        [self addSubview:lab];
        
        self.titLab = lab;
        
        UIView *countView = [[UIView alloc] init];
        
        countView.backgroundColor = [UIColor redColor];
        
        countView.layer.cornerRadius = 2.5;
        
        countView.layer.masksToBounds = YES;
        
        countView.hidden = YES;
        
        [self addSubview:countView];
        
        self.countView = countView;
        
    
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.offset(0);
            
            make.left.offset(5);
            
            make.right.offset(-5);
            
            make.bottom.offset(-10);
            
        }];
        
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(image.mas_bottom).offset(2);
            
            make.centerX.offset(0);
            
        }];
        
        [countView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.top.offset(0);
            
            make.size.sizeOffset(CGSizeMake(5, 5));
            
        }];
        
        lab.font = [UIFont systemFontOfSize:10];
        
        lab.textColor = [UIColor whiteColor];
        
        
    }
    
    return self;
}

-(void)setImgName:(NSString *)imgName{
    
    _imgName = imgName;
    
    self.imgView.image = [UIImage imageNamed:imgName];
    
}

-(void)setTitName:(NSString *)titName{
    
    _titName = titName;
    
    self.titLab.text = titName;
    
}

-(void)setCountHiden:(BOOL)countHiden{
    
    _countHiden = countHiden;
    
    if (countHiden) {
        
        self.countView.hidden = YES;
        
    }else{
        
        self.countView.hidden = NO;
        
    }
    
}

@end
