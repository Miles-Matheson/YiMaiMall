//
//  LDProductTopCell.m
//  FullAndFresh
//
//  Created by Miles on 2017/9/7.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDProductTopCell.h"

@implementation LDProductTopCell
{
    UIImageView *imageView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initUI];
        
    }
    return self;
}

- (void)initUI
{
    imageView = [UIImageView new];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
    }];
}

-(void)setImageUrlString:(NSString *)imageUrlString
{
    _imageUrlString = imageUrlString;
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrlString] placeholderImage:[UIImage imageNamed:KplaceholderImage]];
}
@end
