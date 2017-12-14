//
//  MyPersonalTableViewCell.m
//  BaseFrame
//
//  Created by 陈舟为 on 2017/6/23.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import "MyPersonalTableViewCell.h"

@interface MyPersonalTableViewCell ()



@end

@implementation MyPersonalTableViewCell

-(void)drawRect:(CGRect)rect
{
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(ctx,0.5);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(ctx,RGB(226, 226, 226).CGColor);
    CGContextMoveToPoint(ctx,0,rect.size.height-0.5);
    CGContextAddLineToPoint(ctx,rect.size.width,rect.size.height-0.5);
    CGContextStrokePath(ctx);
    [super drawRect:rect];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initUI];
        
    }
    
    return self;
}

-(void)initUI{
    
    UILabel *titLab = [[UILabel alloc] init];
    
    titLab.font = [UIFont systemFontOfSize:FONTFIT(17)];
    
    titLab.textColor = RGB(75, 74, 74);
    
    [self.contentView addSubview:titLab];
    
    self.titLab = titLab;
    
    [titLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.offset(0);
        
        make.left.offset(SIZEFIT(12));
        
    }];
    
    UITextField *messageTF = [[UITextField alloc] init];
    
    messageTF.textAlignment = 2;
    
    messageTF.textColor = RGB(193, 193, 193);
    
    messageTF.font = [UIFont systemFontOfSize:FONTFIT(16)];
    
    [self.contentView addSubview:messageTF];
    
    self.messageTF = messageTF;
    
    [messageTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-SIZEFIT(10));
        
        make.centerY.offset(0);
        
        make.left.equalTo(titLab.mas_right);
        
    }];
    
    UIImageView *userImg = [[UIImageView alloc] init];
    
    userImg.layer.cornerRadius = SIZEFIT(45)/2;
    
    userImg.layer.masksToBounds = YES;
    
    userImg.hidden = YES;
    
    [self.contentView addSubview:userImg];
    
    self.imgView = userImg;
    
    [userImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-SIZEFIT(10));
        
        make.centerY.offset(0);
        
        make.size.sizeOffset(CGSizeMake(SIZEFIT(45), SIZEFIT(45)));
        
    }];
    
}

-(void)setShowPhoto:(BOOL)showPhoto{
    
    _showPhoto = showPhoto;
    
    if (showPhoto) {
        
        self.imgView.hidden = NO;
        
        self.messageTF.userInteractionEnabled = NO;
        
    }else{
        
        self.imgView.hidden = YES;
        
        self.messageTF.userInteractionEnabled = YES;
    }
}

-(void)setTfColor:(UIColor *)tfColor{
    
    _tfColor = tfColor;
    
    self.messageTF.textColor = tfColor;
}
@end
