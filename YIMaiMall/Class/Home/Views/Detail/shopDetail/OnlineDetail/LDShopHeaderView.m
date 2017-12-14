//
//  LDShopHeaderView.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/25.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDShopHeaderView.h"

@implementation LDShopHeaderView
{
    NSMutableArray *starsArray;
    UIImageView *bgImageView;
    UIImageView *logoImageView;
    UILabel *shopNameLB;
    UILabel *foxLB;
}
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    ws(bself);
    
    bgImageView = [UIImageView new];
    bgImageView.backgroundColor = kAppSubThemeColor;
    [self addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.offset(0);
    }];
    
    logoImageView = [[UIImageView alloc]init];
    logoImageView.image = [UIImage imageNamed:@"tx_def"];
    [self addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.equalTo(bself.mas_centerY).offset(-10);
        make.width.height.offset(SIZEFIT(40));
    }];
    
    shopNameLB = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"***" textColor:WhiteColor textAlignment:Left font:kFont15];
    [self addSubview:shopNameLB];
    [shopNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.equalTo(logoImageView.mas_right).offset(8);
    }];
    
    starsArray = [NSMutableArray array];
    
    for (int i = 0; i < 5; i ++) {
        UIImageView *startView = [UIImageView new];
        startView.tag = 100+i;
        startView.image = [UIImage imageNamed:@"store_grade"];
        [starsArray addObject:startView];
    }
    
    UIView *lineH = [UIView new];
    lineH.backgroundColor = RGB(225, 225, 225);
    [self addSubview:lineH];
    [lineH mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImageView.mas_top).offset(3);
        make.bottom.equalTo(logoImageView.mas_bottom).offset(-3);
        make.width.offset(1);
        make.right.offset(-130);
    }];
    
    
    UILabel *guanZhuLB = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"关注" textColor:WhiteColor textAlignment:Center font:kFont11];
    [self addSubview:guanZhuLB];
    [guanZhuLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineH.mas_right).offset(10);
        make.bottom.equalTo(lineH.mas_bottom);
    }];
    
    foxLB = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"***" textColor:WhiteColor textAlignment:Center font:kFont11];
    [self addSubview:foxLB];
    [foxLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(guanZhuLB.mas_centerX);
        make.top.equalTo(lineH.mas_top);
    }];
    
    
    _foxButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_foxButton setImage:[UIImage imageNamed:@"store_attention-"] forState:UIControlStateNormal];
    [_foxButton setImage:[UIImage imageNamed:@"store_attention-s"] forState:UIControlStateSelected];
    [_foxButton addTarget:self action:@selector(foucsClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_foxButton];
    [_foxButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(guanZhuLB.mas_right).offset(15);
        make.centerY.equalTo(lineH.mas_centerY);
    }];
}

-(void)setStartCount:(NSInteger)count{
    
    ws(bself);
    
    for (int  i = 0; i <count; i++) {
        UIImageView *imvgView = starsArray[i];
        
        if (imvgView != [self viewWithTag:imvgView.tag]) {
            [self addSubview:imvgView];
            
            [imvgView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                if (i == 0) {
                    make.left.equalTo(logoImageView.mas_right).offset(8);
                    make.centerY.equalTo(logoImageView.mas_bottom).offset(-5);
                }else{
                    
                    UIView *lastImgView = [bself viewWithTag:imvgView.tag-1];
                    if (lastImgView) {
                        make.left.equalTo(lastImgView.mas_right).offset(5);
                        make.centerY.equalTo(lastImgView.mas_centerY);
                    }
                }
            }];
        }
    }
}

-(void)foucsClick:(UIButton *)button{
    if (_foucsClick) {
        _foucsClick();
    }
}

-(void)setModel:(LDStoreModel *)model{
    _model = model;
    
    [logoImageView sd_setImageWithURL:[NSURL URLWithString:_model.logo] placeholderImage:[UIImage imageNamed:@"tx_def"]];
    shopNameLB.text = _model.storeName;
    [self setStartCount:_model.gradeLevel];
    foxLB.text = [NSString stringWithFormat:@"%ld",_model.favoriteCount];
    _foxButton.selected = _model.isAttention;
}
@end
