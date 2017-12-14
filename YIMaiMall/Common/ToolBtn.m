//
//  ToolBtn.m
//  yt
//
//  Created by XH on 16/6/3.
//  Copyright © 2016年 PP. All rights reserved.
//

#import "ToolBtn.h"

@interface ToolBtn()
@property (nonatomic,strong)UIImageView * imgView;
@property (nonatomic,strong)UILabel * textLabel;
@end

@implementation ToolBtn

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.width)];
    if (self) {
        //创建视图
        [self createView];
    }
    return self;
}

- (void)createView{
    
    _textLabel = [[UILabel alloc] init];
    
    _textLabel.textAlignment = NSTextAlignmentCenter;
    
    _textLabel.font = [MyAdapter lfontADapter:10];
    
    _textLabel.textColor = RGB(51, 51, 51);
    
    [self addSubview:_textLabel];
    
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.offset(-SIZEFIT(2));
        
        make.centerX.offset(0);
        
    }];
    
    _imgView = [[UIImageView alloc] init];
    _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.offset(0);
        
        make.bottom.equalTo(_textLabel.mas_top).offset(-SIZEFIT(2));
        
        make.size.sizeOffset(CGSizeMake(25, 25));
        
    }];
}

- (void)configDataWithImageName:(NSString *)imageName title:(NSString *)title{
    _imgView.image = [UIImage imageNamed:imageName];
    _textLabel.text = title;
    self.name = title;
}

@end
