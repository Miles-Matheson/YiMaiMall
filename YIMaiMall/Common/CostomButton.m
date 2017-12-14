//
//  CostomButton.m
//  NiuNiuJieBa
//
//  Created by 陈舟为 on 2017/2/27.
//  Copyright © 2017年 DaveChen. All rights reserved.
//

#import "CostomButton.h"

@interface CostomButton ()

@end

@implementation CostomButton

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self =  [super initWithFrame:frame] ) {
        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(SIZEFIT(30));
            make.right.offset(-SIZEFIT(30));
            make.height.equalTo(_imgView.mas_width);
            make.top.offset(10);
        }];

        _titleLable = [[UILabel alloc] init];
        _titleLable.font = [UIFont systemFontOfSize:FONTFIT(13)];
        _titleLable.textAlignment = 1;
        _titleLable.textColor = RGB(69, 69, 69);
        [self addSubview:_titleLable];
        
        [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.right.offset(0);
            make.bottom.offset(-10);
        }];
        
        _countLab = [[UILabel alloc] init];
        _countLab.layer.masksToBounds = YES;
        _countLab.textAlignment = 1;
        _countLab.textColor = [UIColor whiteColor];
        _countLab.font = [UIFont systemFontOfSize:9];
        [self addSubview:_countLab];
        [_countLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_imgView.mas_right).offset(-5);
            make.bottom.equalTo(_imgView.mas_top).offset(55);
        }];
        _countLab.hidden = YES;
    }
    
    return self;
    
}

-(void)setTextLable:(NSString *)textLable{
    
    _textLable = textLable;
    
    _titleLable.text = textLable;
}

- (void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:KplaceholderImage]];
}

-(void)setImageName:(NSString *)imageName{
    
    _imageName = imageName;
    _imgView.image = [UIImage imageNamed:imageName];
}

-(void)setCount:(NSInteger)count{
        
    _count = count;
    _countLab.hidden =count?NO:YES;
    _countLab.text = [NSString stringWithFormat:@"%ld",count];
    _countLab.backgroundColor = RedColor;
    
   CGSize size =   [LLUtils getStringSize:[NSString stringWithFormat:@"%ld",count] font:9 width:100];
    
    CGFloat width = 0;
    
    if (size.width <= 13) {
        width = 13;
    }else{
        width = size.width +5;
    }
  _countLab.cornerRadius  = 13/2.;
    
    [_countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgView.mas_right).offset(-5);
        make.bottom.equalTo(_imgView.mas_top).offset(8);
        make.height.offset(13);
        make.width.offset(width);
    }];
}

@end
