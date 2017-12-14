//
//  LDDetailBottomView.m
//  StairOrder
//
//  Created by Miles on 2017/8/17.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDDetailBottomView.h"

@implementation LDDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    CGFloat width1 = SCREEN_WIDTH/3/3;
    CGFloat width2 = SCREEN_WIDTH/3;

    ws(bself);
    //联系客服
    ToolBtn *kfBtn = [[ToolBtn alloc] init];
    [kfBtn configDataWithImageName:@"service" title:@"客服"];
    kfBtn.titleLabel.font = kFont10;
    [self addSubview:kfBtn];
    [kfBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [kfBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
        [bself itemClick:sender];
    }];
    kfBtn.tag = 0;
    [kfBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0);
        make.width.offset(width1);
    }];
    
    //联系客服
    ToolBtn *dianPuBtn = [[ToolBtn alloc] init];
    dianPuBtn.titleLabel.font = kFont10;
    [dianPuBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [dianPuBtn configDataWithImageName:@"shop_2" title:@"店铺"];
    [self addSubview:dianPuBtn];
    [dianPuBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
        [bself itemClick:sender];
    }];
    dianPuBtn.tag = 1;
    [dianPuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.left.equalTo(kfBtn.mas_right);
        make.width.offset(width1);
    }];
    
    //收藏
    _shopCartBtn = [[ToolBtn alloc] init];
    _shopCartBtn.titleLabel.font = kFont10;
    [_shopCartBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [_shopCartBtn configDataWithImageName:@"shopping_2" title:@"购物车"];
    [self addSubview:_shopCartBtn];
    [_shopCartBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
        [bself itemClick:sender];
    }];
    _shopCartBtn.tag = 2;
    [_shopCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.left.equalTo(dianPuBtn.mas_right);
        make.width.offset(width1);
    }];
    
    UIView *lView = [[UIView alloc] init];
    [self addSubview:lView];
    [lView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.right.offset(0);
        make.width.offset(SCREEN_WIDTH/3*2);
    }];
    
    UIButton *addShopCart = [[UIButton alloc] init];
    addShopCart.backgroundColor = kAppThemeColor;
    addShopCart.titleLabel.font = kFont14;
    [addShopCart setTitle:@"加入购物车" forState:UIControlStateNormal];
    [lView addSubview:addShopCart];
    [addShopCart handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
        [bself itemClick:sender];
    }];
    addShopCart.tag = 3;
    [addShopCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0);
        make.width.offset(width2);
    }];
    
    UIButton *buy = [[UIButton alloc] init];
    buy.backgroundColor = kAppSubThemeColor;
    buy.titleLabel.font = kFont14;
    [buy setTitle:@"立即购买" forState:UIControlStateNormal];
    [lView addSubview:buy];
    [buy handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
        [bself itemClick:sender];
    }];
    buy.tag = 4;
    [buy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.offset(0);
        make.left.equalTo(addShopCart.mas_right);
    }];
}

- (void)itemClick:(UIButton *)btn
{
    UIButton *button = (UIButton *)btn;
//    NSString *str = didLogin;
//
//    if (str.length < 1) {
//
//        [[LLUtils getCurrentVC].view showCenterToast:@"请登录后再操作"];
//        return;
//    }
    
    if ([_delegate respondsToSelector:@selector(LDDetailBottomView:ClickItem:)]) {

         [_delegate LDDetailBottomView:self ClickItem:button];
    }
}

@end
