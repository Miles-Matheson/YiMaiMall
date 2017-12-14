//
//  LDCustomNavView.m
//  StairOrder
//
//  Created by Miles on 2017/8/15.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDCustomNavView.h"

@implementation LDCustomNavView
{
    UIButton *searchBtn;
    UILabel *subLB;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = kAppThemeColor;

        searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(SIZEFIT(40), 25, SCREEN_WIDTH - 90 , 30)];
        searchBtn.backgroundColor = [UIColor whiteColor];
        [searchBtn setImage:[UIImage imageNamed:@"search_2"] forState:UIControlStateNormal];
        [searchBtn setTitle:@" 搜索商品" forState:UIControlStateNormal];
        [searchBtn setTitleColor:RGB(188, 188, 188) forState:UIControlStateNormal];
        searchBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        searchBtn.layer.cornerRadius = 15;
        searchBtn.layer.masksToBounds = YES;
        searchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        searchBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        searchBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        searchBtn.tag = 20;
        [searchBtn addTarget:self action:@selector(navClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:searchBtn];
        [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(SIZEFIT(70));
           
            if (isIPhpneX) {
                 make.bottom.offset(-15);
            }else{
                 make.top.offset(25);
            }
            make.right.offset(-SIZEFIT(50));
            make.height.offset(30);
        }];
        
        _scanCodeBtn = [[VerticalBtn alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 30, 25, 30, 30)];
        _scanCodeBtn.imgName = @"scan";
        _scanCodeBtn.tag = 30;
        [_scanCodeBtn addTarget:self action:@selector(navClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_scanCodeBtn];
        [_scanCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(searchBtn.mas_right).offset(10);
            make.centerY.equalTo(searchBtn.mas_centerY).offset(5);
            make.height.offset(30);
        }];
        
        
        UIView *addView = [UIView new];
        addView.tag = 0;
        [self addSubview:addView];
        [addView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.offset(2);
            make.top.equalTo(searchBtn.mas_top);
            make.right.equalTo(searchBtn.mas_left);
        }];
        
        _addTitleBtn = [LFButton buttonWithType:UIButtonTypeCustom];
        _addTitleBtn.userInteractionEnabled = NO;
        [addView addSubview:_addTitleBtn];
        
        _addTitleBtn.tag = 10;
        _addTitleBtn.titleLabel.font = kFont14;
        [_addTitleBtn setTitle:@"合肥" forState:0];
        [_addTitleBtn setTitleColor:WhiteColor forState:0];
        [_addTitleBtn setImage:[UIImage imageNamed:@"icon_bt"] forState:0];

        [_addTitleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.top.offset(0);
        }];
        

        subLB = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"包河花园C区" textColor:BlackColor textAlignment:Center font:kFont11];
        subLB.numberOfLines = 1;
        subLB.textColor = WhiteColor;
        [addView addSubview:subLB];
        [subLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.bottom.equalTo(searchBtn.mas_bottom).offset(5);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [addView addGestureRecognizer:tap];
    }
    return  self;
}

//点击 搜索按钮 点击消息
- (void)tapClick:(UITapGestureRecognizer*)tap
{
    UIView *view = tap.view;
    
    if ([_delegate respondsToSelector:@selector(navClickHandel:WithIndex:)]) {
        
        [_delegate navClickHandel:view WithIndex:view.tag];
    }
}

//点击 搜索按钮 点击消息
- (void)navClick:(UIButton*)btn
{
    UIButton *button = (UIButton *)btn;
    
    if ([_delegate respondsToSelector:@selector(navClickHandel:WithIndex:)]) {
        
        [_delegate navClickHandel:button WithIndex:button.tag];
    }
}

- (void)setMessageCount:(NSInteger)messageCount
{
    if (messageCount < 1) {
        return;
    }
    _messageCount = messageCount;
    _scanCodeBtn.index = messageCount;
}
@end
