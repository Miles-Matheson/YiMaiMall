//
//  LDTableViewHeaderFooterView.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/23.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDOrderListTopCell.h"
#import "LFButton.h"

@interface LDOrderListTopCell ()

@property (nonatomic,strong) LFButton *titleBtn;
@property (nonatomic,strong) LFButton *statusBtn;
@property (nonatomic,strong) NSMutableArray *bottomStatusArray;

@property (nonatomic,strong) UIView *bgTopView;
@property (nonatomic,strong) UIView *bgBottomView;

@property (nonatomic,strong) NSArray *orderStatusArray;

@end

@implementation LDOrderListTopCell

-(LFButton *)titleBtn{
    if (!_titleBtn) {
        _titleBtn = [LFButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_titleBtn];
        [_titleBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        _titleBtn.titleLabel.font = kFont15;
        [_titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.offset(15);
        }];
    }
    return _titleBtn;
}

-(LFButton *)statusBtn{
    if (!_statusBtn) {
        _statusBtn = [LFButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_statusBtn];
        [_statusBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        _statusBtn.titleLabel.font = kFont15;
        [_statusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.right.offset(-15);
        }];
    }
    return _statusBtn;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        
         self.contentView.backgroundColor = WhiteColor;
    }
    return self;
}

-(void)initUI{
    
    [self.titleBtn setImage:[UIImage imageNamed:@"arrow_2"] forState:UIControlStateNormal];
    [self.statusBtn setTitleColor:kAppSubThemeColor forState:UIControlStateNormal];
}

-(void)setModel:(LDOrderModel *)model{
    
    _model = model;

    NSString *status = [LLUtils getOrderStatusWithStatus:_model.orderStatus];
    NSString *storeName = [NSString stringWithFormat:@"%@ ",_model.storeName];
    
    [self.statusBtn setTitle:status forState:UIControlStateNormal];
    [self.titleBtn setTitle:storeName forState:UIControlStateNormal];
}

@end
