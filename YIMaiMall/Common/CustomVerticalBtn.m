//
//  CustomVerticalBtn.m
//  BaseFrame
//
//  Created by 陈舟为 on 2017/3/13.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import "CustomVerticalBtn.h"

@interface CustomVerticalBtn ()

@property(nonatomic,weak)UIImageView *img;

@property(nonatomic,weak)UILabel *lab;

@end

@implementation CustomVerticalBtn

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(SIZEFIT(10), SIZEFIT(10), self.width - SIZEFIT(10) * 2, self.height - SIZEFIT(20))];
        
        imgV.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:imgV];
        
        self.img = imgV;
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imgV.frame) + 5, self.width, SIZEFIT(20))];
        lab.textAlignment = 1;
        [self addSubview:lab];
        
        self.lab = lab;
        
        
    }
    
    return self;
}

-(void)setImgName:(NSString *)imgName{
    _imgName = imgName;
    
    self.img.image = [UIImage imageNamed:imgName];
    
    
}

-(void)setPlatformName:(NSString *)platformName{
    
    _platformName = platformName;
    
    self.lab.text = platformName;
    
    
}

-(void)setFont:(float)font{
    
    _font = font;
    
    self.lab.font = [UIFont systemFontOfSize:SIZEFIT(font)];
    
}

-(void)setColor:(UIColor *)color{
    
    _color = color;
    
    self.lab.textColor = color;
    
}

@end
