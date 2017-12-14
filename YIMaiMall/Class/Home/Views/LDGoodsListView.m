//
//  LDGoodsListView.m
//  FullAndFresh
//
//  Created by Miles on 2017/10/17.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDGoodsListView.h"

@implementation LDGoodsListView
{
    UILabel *counentLab;
     UILabel *titleLB;
    UIImageView *topImageView;
}
-(instancetype)init
{
    if (self = [super init]) {
        [self initUI];
        self.backgroundColor = WhiteColor;
    }
    return self;
}
- (void)initUI{
    
    topImageView = [UIImageView new];
    topImageView.layer.masksToBounds = YES;
    topImageView.layer.cornerRadius = 5;
    [self addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.bottom.offset(-SIZEFIT(35));
    }];
    
    titleLB = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"" textColor:RGB(51,51,51) textAlignment:Left font:kFont12];
    [self addSubview:titleLB];
    
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topImageView.mas_left);
        make.right.equalTo(topImageView.mas_right);
        make.top.equalTo(topImageView.mas_bottom).offset(5);
    }];
    
    counentLab = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"" textColor:RGB(153,153,153) textAlignment:Left font:kFont11];
    counentLab.numberOfLines = 2;
    [self addSubview:counentLab];
    
    [counentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topImageView.mas_left);
        make.right.equalTo(topImageView.mas_right);
        make.top.equalTo(titleLB.mas_bottom).offset(5);
    }];

    UITapGestureRecognizer   *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappp)];
    [self addGestureRecognizer:tap];
}

-(void)tappp{
    if (self.itemClickCallBack) {
        self.itemClickCallBack(_model);
    }
}
-(void)setModel:(LDGoodsListModel *)model
{
    _model = model;
    
    [topImageView sd_setImageWithURL:[NSURL URLWithString:_model.img] placeholderImage:[UIImage imageNamed:KplaceholderImage]];
    titleLB.text = _model.gName;
    counentLab.text = _model.gName;
}
@end
