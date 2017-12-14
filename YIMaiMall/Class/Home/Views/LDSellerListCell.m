
//
//  LDSellerListCell.m
//  BaseFrame
//
//  Created by Miles on 2017/6/24.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import "LDSellerListCell.h"
#import "AmotButton.h"
#import "StarsView.h"

@interface LDSellerListCell ()

@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UILabel *titleLab;
@property (nonatomic,strong)UILabel *addrssLab;
@property (nonatomic,strong)AmotButton *distanceBtn;
@property(nonatomic,strong)UILabel *distanceLB;

@end


@implementation LDSellerListCell


-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
         [self initUI];
        self.contentView.backgroundColor = WhiteColor;
    }
    return self;
}

- (void)initUI
{
    ws(bself);
    if (!_imgView) {

        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imgView];
        
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(SIZEFIT(15));
            make.top.offset(SIZEFIT(15));
            make.bottom.offset(-SIZEFIT(15));
            make.width.equalTo(_imgView.mas_height);
        }];
    }
    
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = RGB(51, 51, 51);
        _titleLab.font = [UIFont systemFontOfSize:FONTFIT(15)];
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_imgView.mas_right).offset(SIZEFIT(3));
            make.top.equalTo(_imgView.mas_top);
        }];
    }
    
    UIView *lineH = [UIView new];
    [self addSubview:lineH];
    lineH.backgroundColor = RGB(153, 153, 153);
    [lineH mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLab.mas_right).offset(10);
        make.width.offset(1);
        make.height.offset(10);
        make.centerY.equalTo(_titleLab.mas_centerY);
    }];
    
    _distanceLB = [[UILabel alloc] init];
    _distanceLB.textColor = RGB(153, 153, 153);
    _distanceLB.font = [UIFont systemFontOfSize:FONTFIT(13)];
    _distanceLB.textAlignment = Left;
    [self.contentView addSubview:_distanceLB];
    [_distanceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleLab.mas_centerY);
        make.left.equalTo(lineH.mas_right).offset(50);
    }];
    
        _distanceBtn = [[AmotButton alloc]init];
        [_distanceBtn setTitleColor:RGB(58, 58, 58) forState:UIControlStateNormal];
        [_distanceBtn setImage:[UIImage imageNamed:@"local"] forState:UIControlStateNormal];
        _distanceBtn.titleLabel.font = [MyAdapter lfontADapter:15];
        _distanceBtn.titleLabel.font = [UIFont systemFontOfSize:FONTFIT(13)];
        _distanceBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_distanceBtn];
        
        [_distanceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleLab.mas_left);
            make.top.equalTo(_titleLab.mas_bottom).offset(5);
        }];
    
    _addrssLab = [ViewCreate createLabelFrame:CGRectMake(_imgView.right +SIZEFIT(12), _titleLab.bottom, SCREEN_WIDTH -_imgView.width -12, 20) backgroundColor:ClearColor   text:@"" textColor:RGB(141, 141, 143) textAlignment:Left font:[UIFont systemFontOfSize:FONTFIT(11)]];
    _addrssLab.numberOfLines = 2;
    [self.contentView addSubview:_addrssLab];
    
    [_addrssLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bself.distanceBtn.mas_right).offset(5);
        make.top.equalTo(bself.titleLab.mas_bottom).offset(5);
        make.right.equalTo(bself.contentView.mas_right).offset(-SIZEFIT(35));
    }];
    
    
    UIButton *contactBtn = [ViewCreate   createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"电话联系" titleColor:kAppThemeColor font:kFont15 backgroundColor:WhiteColor touchUpInsideEvent:^(UIButton *sender) {
        if (bself.callItemClick) {
            bself.callItemClick(bself.model);
        }
    }];;
    contactBtn.layer.masksToBounds = YES;
    contactBtn.layer.borderWidth = 1.2;
    contactBtn.layer.cornerRadius = SIZEFIT(30)/2.;
    contactBtn.layer.borderColor = kAppThemeColor.CGColor;
    [self.contentView addSubview:contactBtn];
    [contactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLab.mas_left);
        make.bottom.equalTo(_imgView.mas_bottom);
        make.width.offset(SIZEFIT(90));
        make.height.offset(SIZEFIT(30));
    }];
}

- (void)setModel:(LDSellerListModel *)model
{
    _model = model;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:_model.BusinessPic] placeholderImage:[UIImage imageNamed:KplaceholderImage]];

    _titleLab.text = @"牧羊人火锅(包河花园店)";
    _addrssLab.text = @"包河花园繁华大道与上海路交叉口向东三公里(原派出所对面)";
    
    if (_model.Distance < 1) {
        _distanceLB.text = [NSString stringWithFormat:@" %.0fm",_model.Distance *1000];
    }else{
         _distanceLB.text = [NSString stringWithFormat:@" %.2lfkm",_model.Distance];
    }
}
@end
