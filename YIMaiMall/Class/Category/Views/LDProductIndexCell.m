//
//  LDProductIndexCell.m
//  FullAndFresh
//
//  Created by Miles on 2017/9/7.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDProductIndexCell.h"

@implementation LDProductIndexCell
{
    UIImageView *imageView;
    UILabel *titleLab;
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
    [self.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.equalTo(imageView.mas_width);
    }];
    
    titleLab = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"" textColor:BlackColor textAlignment:Left font:kFont13];
    titleLab.textColor = RGB(46, 46, 46);
    [self.contentView addSubview:titleLab];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.offset(0);
    }];
}

-(void)setImageUrlString:(NSString *)imageUrlString
{
    _imageUrlString = imageUrlString;
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrlString] placeholderImage:[UIImage imageNamed:KplaceholderImage]];

}

-(void)setNameString:(NSString *)nameString
{
    _nameString = nameString    ;
    
    titleLab.text = _nameString;
}
@end
