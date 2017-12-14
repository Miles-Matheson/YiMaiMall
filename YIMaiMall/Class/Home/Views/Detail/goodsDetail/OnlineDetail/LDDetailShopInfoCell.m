//
//  LDDetailShopInfoCell.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/17.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDDetailShopInfoCell.h"
#import "AmotButton.h"
@interface LDDetailShopInfoCell ()

@property (nonatomic,strong)LDGoodsStoreInfoModel *storeModel;

@property (nonatomic,strong)  UIImageView *shopImgView;  ///店铺图片
@property (nonatomic,strong)  UILabel *shopNameLB;  ///店铺名
@property (nonatomic,strong)  UILabel *scoreLB;     ///综合评分
@property (nonatomic,strong)  UILabel *foxNumLB;    ///关注数量
@property (nonatomic,strong)  UILabel *goodsNumLB;///全部商品数量

@property (nonatomic,strong)  UILabel *goodsScoreLB;///商品评分
@property (nonatomic,strong)  UILabel *shopScoreLB;///卖家评分
@property (nonatomic,strong)  UILabel *logisticsScoreLB;///物流评分

@end
@implementation LDDetailShopInfoCell
-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self initUI];
        self.contentView.backgroundColor = WhiteColor;
    }
    return self;
}

-(void)initUI{
    
    _shopImgView = [UIImageView new];
    [self.contentView addSubview:_shopImgView];
    [_shopImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.top.offset(15);
        make.width.height.offset(SIZEFIT(40));
    }];

    _shopNameLB = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"****" textColor:kAppSubThemeColor textAlignment:Left font:kFont14];
    [self.contentView addSubview:_shopNameLB];
    [_shopNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopImgView.mas_right).offset(8);
        make.top.equalTo(_shopImgView.mas_top).offset(2);
    }];
    
    _scoreLB = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"综合评分 ***" textColor:kAppSubThemeColor textAlignment:Left font:kFont14];
    [self.contentView addSubview:_scoreLB];
    [_scoreLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopImgView.mas_right).offset(8);
        make.bottom.equalTo(_shopImgView.mas_bottom).offset(-2);
    }];
    
    UIView *lineH1 = [UIView new];
    lineH1.backgroundColor = RGB(225, 225, 225);
    [self.contentView addSubview:lineH1];
    [lineH1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SCREEN_WIDTH/3.);
        make.top.equalTo(_shopImgView.mas_bottom).offset(SIZEFIT(10));
        make.height.offset(SIZEFIT(50));
        make.width.offset(0.5);
    }];
    
    UIView *lineH2 = [UIView new];
    lineH2.backgroundColor = RGB(225, 225, 225);
    [self.contentView addSubview:lineH2];
    [lineH2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SCREEN_WIDTH/3.*2);
        make.top.equalTo(_shopImgView.mas_bottom).offset(SIZEFIT(10));
        make.height.offset(SIZEFIT(50));
        make.width.offset(0.5);
    }];
    
    {

        UILabel *foxLB =[ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"关注人数" textColor:RGB(102, 102, 102) textAlignment:Center font:kFont11];
        [self.contentView addSubview:foxLB];
        [foxLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(-SCREEN_WIDTH/6.*2);
            make.top.equalTo(lineH1.mas_centerY).offset(2);
        }];

        UILabel *allLB =[ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"全部商品" textColor:RGB(102, 102, 102) textAlignment:Center font:kFont11];
        [self.contentView addSubview:allLB];
        [allLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.equalTo(lineH1.mas_centerY).offset(2);
        }];

        /*********************************************/

        _foxNumLB =[ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"*" textColor:RGB(51, 51, 51) textAlignment:Center font:kFont14];
        [self.contentView addSubview:_foxNumLB];
        [_foxNumLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(-SCREEN_WIDTH/6.*2);
            make.bottom.equalTo(lineH1.mas_centerY).offset(-2);
        }];

        _goodsNumLB =[ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"**" textColor:RGB(51, 51, 51) textAlignment:Center font:kFont14];
        [self.contentView addSubview:_goodsNumLB];
        [_goodsNumLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.bottom.equalTo(lineH1.mas_centerY).offset(-2);
        }];

    }
    

    {
        UILabel *title1 =[ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"宝贝描述" textColor:RGB(51, 51, 51) textAlignment:Left font:kFont11];
        [self.contentView addSubview:title1];
        [title1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lineH2.mas_right).offset(8);
            make.top.equalTo(lineH2.mas_top).offset(2);
        }];

        UILabel *title2 =[ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"卖家服务" textColor:RGB(51, 51, 51) textAlignment:Left font:kFont11];
        [self.contentView addSubview:title2];
        [title2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lineH2.mas_right).offset(8);
            make.centerY.equalTo(lineH2.mas_centerY);
        }];

        UILabel *title3 =[ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"物流服务" textColor:RGB(51, 51, 51) textAlignment:Left font:kFont11];
        [self.contentView addSubview:title3];
        [title3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lineH2.mas_right).offset(8);
            make.bottom.equalTo(lineH2.mas_bottom).offset(-2);
        }];

         /*********************************************/
        _goodsScoreLB =[ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"******" textColor:kAppSubThemeColor textAlignment:Left font:kFont11];
        [self.contentView addSubview:_goodsScoreLB];
        [_goodsScoreLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title1.mas_right).offset(10);
            make.centerY.equalTo(title1.mas_centerY);
        }];

        _shopScoreLB =[ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"***" textColor:kAppSubThemeColor textAlignment:Left font:kFont11];
        [self.contentView addSubview:_shopScoreLB];
        [_shopScoreLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title1.mas_right).offset(10);
             make.centerY.equalTo(title2.mas_centerY);
        }];

        _logisticsScoreLB =[ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"2.3" textColor:kAppSubThemeColor textAlignment:Left font:kFont11];
        [self.contentView addSubview:_logisticsScoreLB];
        [_logisticsScoreLB mas_makeConstraints:^(MASConstraintMaker *make) {
             make.left.equalTo(title1.mas_right).offset(10);
             make.centerY.equalTo(title3.mas_centerY);
        }];

    }
    
    AmotButton *touchLineSellerBtn = [[AmotButton alloc]init];
    [self.contentView addSubview:touchLineSellerBtn];
    [touchLineSellerBtn setTitle:@"联系卖家" forState:0];
    [touchLineSellerBtn setTitleColor:RGB(102, 102, 102) forState:0];
    touchLineSellerBtn.titleLabel.font = kFont14;
    touchLineSellerBtn.layer.masksToBounds = YES;
    touchLineSellerBtn.layer.cornerRadius = 3;
    touchLineSellerBtn.layer.borderColor = RGB(102, 102, 102).CGColor;
    touchLineSellerBtn.layer.borderWidth = 0.8;
    touchLineSellerBtn.tag = 0;
    [touchLineSellerBtn addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    [touchLineSellerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.width.offset(SIZEFIT(165));
        make.height.offset(SIZEFIT(40));
        make.bottom.offset(-10);
    }];
    
    AmotButton *goShopBtn = [[AmotButton alloc]init];
    [self.contentView addSubview:goShopBtn];
    [goShopBtn setTitle:@"进店逛逛" forState:0];
    [goShopBtn setTitleColor:RGB(102, 102, 102) forState:0];
    goShopBtn.titleLabel.font = kFont14;
    goShopBtn.layer.masksToBounds = YES;
    goShopBtn.layer.cornerRadius = 3;
    goShopBtn.layer.borderColor = RGB(102, 102, 102).CGColor;
    goShopBtn.layer.borderWidth = 0.8;
    goShopBtn.tag = 1;
    [goShopBtn addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    [goShopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-12);
        make.width.offset(SIZEFIT(165));
        make.height.offset(SIZEFIT(40));
        make.bottom.offset(-10);
    }];
}

-(void)setModel:(LDGoodsDetailModel *)model{
    _model = model;
    
    self.storeModel = _model.shopStoreDto;
}

-(void)setStoreModel:(LDGoodsStoreInfoModel *)storeModel{
    
    _storeModel = storeModel;
    [_shopImgView sd_setImageWithURL:[NSURL URLWithString:_storeModel.logo] placeholderImage:[UIImage imageNamed:KplaceholderImage]];
    _shopNameLB.text = _storeModel.storeName;
    
    _scoreLB.text = [NSString stringWithFormat:@"综合评分 %.1f",_storeModel.generalScore];
    
    _foxNumLB.text = [NSString stringWithFormat:@"%ld",_storeModel.favoriteCount];
    
    _goodsNumLB.text = [NSString stringWithFormat:@"%ld",_storeModel.goodsCount];
    
    _goodsScoreLB.text = [NSString stringWithFormat:@"%.1f",_storeModel.serviceEvaluate];
    _shopScoreLB.text = [NSString stringWithFormat:@"%.1f",_storeModel.descriptionEvaluate];
    _logisticsScoreLB.text =[NSString stringWithFormat:@"%.1f",_storeModel.shipEvaluate];
}

-(void)itemClick:(UIButton*)btn{
    
    UIButton *button = (UIButton *)btn;
    if (self.shopInfoClick) {
        self.shopInfoClick(button.tag);
    }
}
@end
