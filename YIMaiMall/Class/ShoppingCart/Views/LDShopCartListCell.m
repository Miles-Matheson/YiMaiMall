//
//  LDShopCartListCell.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/18.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDShopCartListCell.h"
#import <PPNumberButton/PPNumberButton.h>

@interface LDShopCartListCell ()<PPNumberButtonDelegate>

@property (nonatomic,strong)PPNumberButton *PPNumberBtn;
@end

@implementation LDShopCartListCell
{
    UIButton *deleteBtn;
    UILabel *titleLB;
    UILabel *counentLab;
    UILabel *priceLab;
    UILabel *countLB;
    UIButton *selectBtn;
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initUI];
    }
    return self;
}
-(void)initUI
{
    WS(bself);
    _topImageView = [UIImageView new];
    [self.contentView addSubview:_topImageView];
    
    
    deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setBackgroundColor:kAppThemeColor];
    [deleteBtn setTitleColor:WhiteColor forState:0];
    deleteBtn.titleLabel.font = kFont15;
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
    deleteBtn.userInteractionEnabled = YES;
    [self.contentView addSubview:deleteBtn];
    
    
    selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectBtn setImage:[UIImage imageNamed:@"goods_choose"] forState:UIControlStateNormal];
    [selectBtn setImage:[UIImage imageNamed:@"goods_choose_select"] forState:UIControlStateSelected];
    selectBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [selectBtn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:selectBtn];
    
    
    titleLB = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"***" textColor:RGB(26, 26, 26) textAlignment:Left font:kFont14];
    titleLB.numberOfLines = 2;
    [self.contentView addSubview:titleLB];
    
    counentLab = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"" textColor:RGB(153,153,153) textAlignment:Left font:kFont12];
    counentLab.numberOfLines = 2;
    [self.contentView addSubview:counentLab];
    
    
    countLB = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"X*" textColor:RGB(102,102,102) textAlignment:Right font:kFont13];
    [self.contentView addSubview:countLB];
    
    
    priceLab = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"¥**.00" textColor:kAppSubThemeColor textAlignment:Right font:kFont15];
    [self.contentView addSubview:priceLab];
    
    
    [_topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(SIZEFIT(15));
        make.bottom.offset(-SIZEFIT(15));
        make.left.offset(SIZEFIT(45));
        make.width.equalTo(_topImageView.mas_height);
    }];
    
    _topImageView.backgroundColor = RedColor;
    
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.width.offset(0);
    }];
    
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0);
        make.right.equalTo(_topImageView.mas_left);
    }];

    [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-SIZEFIT(15));
        make.top.equalTo(_topImageView.mas_top);
    }];
    
    [self.contentView layoutIfNeeded];
    
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topImageView.mas_right).offset(10);
        make.top.equalTo(_topImageView.mas_top);
        make.right.equalTo(priceLab.mas_left).offset(-8);
    }];
    
    [counentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topImageView.mas_right).offset(10);
        make.right.offset(-SIZEFIT(80));
        make.top.equalTo(_topImageView.mas_centerY);
    }];
    
    
   
    [countLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-SIZEFIT(15));
        make.top.equalTo(priceLab.mas_bottom).offset(SIZEFIT(10));
    }];
    
    _PPNumberBtn = [PPNumberButton numberButtonWithFrame:CGRectMake(100, 160, 150, 30)];
    //设置边框颜色
    _PPNumberBtn.borderColor = [UIColor grayColor];
    _PPNumberBtn.increaseTitle = @"＋";
    _PPNumberBtn.decreaseTitle = @"－";
    _PPNumberBtn.minValue = 1;
    _PPNumberBtn.delegate = self;
    _PPNumberBtn.resultBlock = ^(NSInteger num ,BOOL increaseStatus){

        NSInteger changeCount = num - bself.model.count;
        if (bself.changeCountClick) {
            bself.changeCountClick(bself.model, changeCount, num);
        }
    };
    _PPNumberBtn.alpha = 0;
    _PPNumberBtn.hidden = YES;
    [self.contentView addSubview:_PPNumberBtn];
    [_PPNumberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-SIZEFIT(75));
        make.top.equalTo(_topImageView.mas_top);
        make.width.offset(SIZEFIT(140));//0.21428
        make.height.offset(SIZEFIT(140)*0.21428);// 高/宽
    }];
}

- (void)pp_numberButton:(__kindof UIView *)numberButton number:(NSInteger)number increaseStatus:(BOOL)increaseStatus{
    
    _model.count = number;
}

-(void)setIsHiddenSelectBtn:(BOOL)isHiddenSelectBtn{
    
    _isHiddenSelectBtn = isHiddenSelectBtn;
    
    selectBtn.hidden = _isHiddenSelectBtn;

    [_topImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(SIZEFIT(15));
        make.bottom.offset(-SIZEFIT(15));
        make.left.offset(SIZEFIT(15));
        make.width.equalTo(_topImageView.mas_height);
    }];
}

-(void)setModel:(LDShopGoodsCartsModel *)model{
    _model = model;
    
    LDShopGoodsModel * goodsModel = _model.goods;
    
    _isEditing = _model.isEditing;
    selectBtn.selected = _model.isselect;
    selectBtn.hidden = _model.isEditing;
    
    self.PPNumberBtn.currentNumber = _model.count;
    countLB.text = [NSString stringWithFormat:@"x%ld",_model.count];
    counentLab.text = _model.goodsSpec;
    priceLab.text = [NSString stringWithFormat:@"¥%.2f",_model.cartPrice];
    
    if (goodsModel) {

        [_topImageView sd_setImageWithURL:[NSURL URLWithString:goodsModel.goodsPhotoUrl] placeholderImage:[UIImage imageNamed:KplaceholderImage]];
        titleLB.text  = goodsModel.goodsName;
    }
    
    if (_isEditing) {
        _PPNumberBtn.hidden = NO;
    }
    
    [deleteBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.offset(0);
        make.width.offset(_isEditing?SIZEFIT(65):0);
    }];
    
    selectBtn.hidden = _isEditing;
    if (_isEditing) {
        _PPNumberBtn.hidden = NO;
    }
    titleLB.alpha = priceLab.alpha = countLB.alpha = _isEditing?0:1;
    self.PPNumberBtn.alpha = _isEditing?1:0;
}

-(void)setIsEditing:(BOOL)isEditing{
    
    _isEditing = isEditing;
    selectBtn.hidden = _isEditing;
    
    if (_isEditing) {
        _PPNumberBtn.hidden = NO;
    }
    ws(bself);
    [UIView animateWithDuration:0.4 animations:^{
        
        [deleteBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.offset(0);
            make.width.offset(_isEditing?SIZEFIT(65):0);
        }];
        
        titleLB.alpha = priceLab.alpha = countLB.alpha = _isEditing?0:1;
        bself.PPNumberBtn.alpha = _isEditing?1:0;
        
        [bself.contentView layoutIfNeeded];
    } completion:^(BOOL finished) {
        bself.PPNumberBtn.hidden = _isEditing?NO:YES;
    }];
}
-(void)setStatementModel:(LDStatementListModel *)statementModel{
    _statementModel = statementModel;
    
    selectBtn.hidden = YES;
     priceLab.text = [NSString stringWithFormat:@"¥%.2f",_statementModel.price];
    titleLB.text = _statementModel.name;
    counentLab.text = _statementModel.advert;
    countLB.text = [NSString stringWithFormat:@"x%ld",_statementModel.count];
    [NSString stringWithFormat:@"¥%.2f",_statementModel.price];
    
}

-(void)setOrderModel:(LDOrderGoodsIndexModel *)orderModel{
    
    _orderModel = orderModel;
    
    [_topImageView sd_setImageWithURL:[NSURL URLWithString:_orderModel.img] placeholderImage:[UIImage imageNamed:KplaceholderImage]];
    titleLB.text = _orderModel.name;
    
    countLB.text = [NSString stringWithFormat:@"x%ld",_orderModel.count];
    priceLab.text = [NSString stringWithFormat:@"¥%.2f",_orderModel.price];
    
}

-(void)selectClick:(UIButton*)btn{

    if (self.selectItemClick) {
        self.selectItemClick(self);
    } 
}

-(void)deleteClick:(UIButton *)btn{
    
    if (self.deleteItemClick) {
        self.deleteItemClick(self);
    }
}
@end
