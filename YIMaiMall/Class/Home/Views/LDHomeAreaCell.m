//
//  LDHomeAreaCell.m
//  StairOrder
//
//  Created by Miles on 2017/8/21.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDHomeAreaCell.h"

@implementation LDHomeAreaCell
{
    UIImageView *imageView0;
    UIImageView *rightImageView1;
    UIImageView *rightImageView2;
    UIImageView *rightImageView3;
    UIImageView *rightImageView4;
    
    NSMutableArray *items;
}

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
- (void)initUI
{
    WS(bself);
    CGFloat width = (SCREEN_WIDTH - SCREEN_WIDTH*.416)/2.;
    
    imageView0 = [UIImageView new];
    [self.contentView   addSubview:imageView0];
    [imageView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0);
        make.width.offset(SCREEN_WIDTH*.416);
    }];

    
    rightImageView1 = [UIImageView new];
    [self.contentView  addSubview:rightImageView1];
    [rightImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView0.mas_right);
        make.top.offset(0);
        make.width.mas_equalTo(width);
        make.bottom.equalTo(bself.mas_centerY);
    }];

    rightImageView2 = [UIImageView new];
    [self.contentView  addSubview:rightImageView2];
    [rightImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rightImageView1.mas_right);
        make.top.right.offset(0);
        make.bottom.equalTo(bself.mas_centerY);
    }];
    
    rightImageView3 = [UIImageView new];
    [self.contentView  addSubview:rightImageView3];
    [rightImageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView0.mas_right);
        make.top.equalTo(rightImageView1.mas_bottom);
        make.width.mas_equalTo(width);
        make.bottom.equalTo(bself.mas_bottom);
    }];
    
    rightImageView4 = [UIImageView new];
    [self.contentView  addSubview:rightImageView4];
    [rightImageView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0);
        make.left.equalTo(rightImageView3.mas_right);
        make.top.equalTo(rightImageView2.mas_bottom);
        make.width.mas_equalTo(width);
        make.bottom.equalTo(bself.mas_bottom);
    }];
    
    imageView0.userInteractionEnabled  =  rightImageView1.userInteractionEnabled =  rightImageView2.userInteractionEnabled =rightImageView3.userInteractionEnabled = rightImageView4.userInteractionEnabled = YES;

    UITapGestureRecognizer *tap0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClick:)];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClick:)];
    UITapGestureRecognizer *tap2 =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClick:)];
    UITapGestureRecognizer *tap3 =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClick:)];
     UITapGestureRecognizer *tap4 =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClick:)];

    [imageView0 addGestureRecognizer:tap0];
    [rightImageView1 addGestureRecognizer:tap1];
    [rightImageView2 addGestureRecognizer:tap2];
    [rightImageView3 addGestureRecognizer:tap3];
    [rightImageView4 addGestureRecognizer:tap4];

    
    UIView *centerHLine0 = [ViewCreate createLineFrame:CGRectMake(0, 0, 20, 0) backgroundColor:RGB(236, 236, 236)];
    [self.contentView addSubview:centerHLine0];
    [centerHLine0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView0.mas_right);
        make.centerY.offset(0);
        make.width.offset(0.5);
        make.height.offset(SCREEN_WIDTH/2.);
    }];
    
    UIView *centerHLine1 = [ViewCreate createLineFrame:CGRectMake(0, 0, 20, 0) backgroundColor:RGB(236, 236, 236)];
    [self.contentView addSubview:centerHLine1];
    [centerHLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rightImageView1.mas_right);
        make.centerY.offset(0);
        make.width.offset(0.5);
        make.height.offset(SCREEN_WIDTH/2.);
    }];
    
    
    UIView *centerVLine = [ViewCreate createLineFrame:CGRectMake(0, 0, 20, 0) backgroundColor:RGB(236, 236, 236)];
    [self.contentView addSubview:centerVLine];
    
    [centerVLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.equalTo(imageView0.mas_right);
        make.height.offset(0.5);
        make.right.offset(0);
    }];
    
    
    items = [[NSMutableArray alloc]initWithObjects:imageView0,rightImageView1,rightImageView2,rightImageView3,rightImageView4,nil];
    
}

- (void)itemClick:(UITapGestureRecognizer *)tapppp
{
    UIImageView *imgView = (UIImageView *)tapppp.view;
    if (self.areaItemClick) {
        self.areaItemClick(_models[imgView.tag]);
    }
}


- (void)setModels:(NSArray<LDHomeAreaModel *> *)models
{
    _models = models;
    
    for (int i = 0; i < models.count; i ++) {
        
        LDHomeAreaModel *model = (LDHomeAreaModel*)models[i];
        UIImageView *imageView =  (UIImageView *)items[i];
        imageView.tag = i;
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:KplaceholderImage]];
    }
}

@end
