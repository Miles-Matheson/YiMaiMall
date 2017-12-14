//
//  LDMineHeadView.m
//  StairOrder
//
//  Created by Miles on 2017/8/15.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDMineHeadView.h"

@implementation LDMineHeadView

{
    UIButton *headBtn;
    UILabel  *nameLB;
    UILabel  *gradeLB;
    UILabel  *roleLB;
    
    UILabel  *goodsSaveLB;
    UILabel  *shopSaveLB;
    UILabel  *historicalRecordLB;
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        [self initUI];
    }
    return self;
}

- (void)initUI{

    ws(bself);
    self.backgroundColor = kAppSubThemeColor;
    
   
    UIView *bgView = [UIView new];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.width.offset(kScreenWidth);
    }];
    
    headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [headBtn setImage:[UIImage imageNamed:@"per_photo"] forState:0];
    [headBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
        
        [bself loginClick];
    }];

    headBtn.backgroundColor = YellowColor;
    headBtn.layer.cornerRadius = SIZEFIT(52)/2.;
    headBtn.layer.masksToBounds  = YES;
    [bgView addSubview:headBtn];
    [headBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.bottom.equalTo(bgView.mas_centerY);
        make.width.height.offset(SIZEFIT(52));
        make.height.equalTo(headBtn.mas_width);
    }];
    
    nameLB = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"欢迎! 欢迎回来" textColor:WhiteColor textAlignment:Left font:kFont11];
    [bgView addSubview:nameLB];
    nameLB.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginClick)];
    [nameLB addGestureRecognizer:tap];
    [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headBtn.mas_right).offset(SIZEFIT(13));
        make.top.equalTo(headBtn.mas_top);
    }];
    
    gradeLB = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"消费等级" textColor:WhiteColor textAlignment:Left font:kFont11];
    [self addSubview:gradeLB];
    [gradeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headBtn.mas_centerY);
        make.left.equalTo(nameLB.mas_left);
    }];
    
    roleLB = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"合作伙伴" textColor:WhiteColor textAlignment:Left font:kFont11];
    [self addSubview:roleLB];
    [roleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLB.mas_left);
        make.bottom.equalTo(headBtn.mas_bottom);
    }];
    
    
    
    UIView *lineH1 = [UIView new];
    lineH1.backgroundColor = RGB(225, 225, 225);
    [self addSubview:lineH1];
    [lineH1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(-SCREEN_WIDTH/6);
        make.bottom.offset(-10);
        make.height.offset(40);
        make.width.offset(0.8);
    }];
    
    UIView *lineH2 = [UIView new];
    lineH2.backgroundColor = RGB(225, 225, 225);
    [self addSubview:lineH2];
    [lineH2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(SCREEN_WIDTH/6);
        make.bottom.offset(-10);
        make.height.offset(40);
        make.width.offset(0.8);
    }];
    
    goodsSaveLB = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"**" textColor:WhiteColor textAlignment:Center font:kFont13];
    [bgView addSubview:goodsSaveLB];
    
    UILabel *shangPinLB = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"商品收藏" textColor:WhiteColor textAlignment:Center font:kFont13];
    [bgView addSubview:shangPinLB];
    
    shopSaveLB = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"**" textColor:WhiteColor textAlignment:Center font:kFont13];
    [bgView addSubview:shopSaveLB];
    

    UILabel *dianPuLB = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"店铺收藏" textColor:WhiteColor textAlignment:Center font:kFont13];
    [bgView addSubview:dianPuLB];

    
    historicalRecordLB = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"**" textColor:WhiteColor textAlignment:Center font:kFont13];
    [bgView addSubview:historicalRecordLB];
    
    
    UILabel *zuJiLB = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"我的足迹" textColor:WhiteColor textAlignment:Center font:kFont13];
    [bgView addSubview:zuJiLB];
    
    
    [goodsSaveLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bself.mas_centerX).offset(-SCREEN_WIDTH/3.);
        make.bottom.equalTo(lineH1.mas_centerY).offset(-2);
    }];
    
    [shangPinLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bself.mas_centerX).offset(-SCREEN_WIDTH/3.);
        make.top.equalTo(lineH1.mas_centerY).offset(2);
    }];
    
    [shopSaveLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.equalTo(lineH1.mas_centerY).offset(-2);
    }];
    
    [dianPuLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(lineH1.mas_centerY).offset(2);
    }];
    
    [historicalRecordLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bself.mas_centerX).offset(SCREEN_WIDTH/3.);
        make.bottom.equalTo(lineH1.mas_centerY).offset(-2);
    }];
    
    [zuJiLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bself.mas_centerX).offset(SCREEN_WIDTH/3.);
        make.top.equalTo(lineH1.mas_centerY).offset(2);
    }];
    
}
- (void)loginClick{
   
    if (self.clickHeadBtnLogin) {
        self.clickHeadBtnLogin();
    }
}

- (void)setHeadImageUrl:(NSString *)headImageUrl{
    
    _headImageUrl = headImageUrl;

    [headBtn sd_setImageWithURL:[NSURL URLWithString:headImageUrl] forState:0 placeholderImage:[UIImage imageNamed:@"per_photo"]];
}

@end
