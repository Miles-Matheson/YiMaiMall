//
//  ShopCartBottomView.m
//  BaseFrame
//
//  Created by 陈舟为 on 2017/6/27.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import "ShopCartBottomView.h"

@interface ShopCartBottomView ()

@property (nonatomic, strong) UIButton *allSelectButton;
@property (nonatomic, strong) UILabel *totalPriceLable;

@property (nonatomic, strong) UIButton *settleButton;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UIView *separateLine;

@end

@implementation ShopCartBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = RGB(247, 247, 247);
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.allSelectButton];
    [self addSubview:self.totalPriceLable];
    [self renderWithTotalPrice:@"￥0"];
    [self addSubview:self.settleButton];
    [self addSubview:self.deleteButton];
    [self addSubview:self.separateLine];
}

//- (void)changeShopcartBottomViewWithStatus:(BOOL)status {
//
//    if (!status) {
//        [self configureShopcartBottomViewWithTotalPrice:0 totalCount:0 isAllselected:NO];
//    }
//    self.deleteButton.hidden = !status;
//
//    self.totalPriceLable.hidden = status;
//
//
//    self.allSelectButton.selected = NO;
//
//    [self clickItenIndex:0];
//
//}

- (void)configureShopcartBottomViewWithTotalPrice:(float)totalPrice selectCount:(NSInteger)selectCount isAllselected:(BOOL)isAllSelected {
    
    _price = totalPrice;
    _count = selectCount;
    
    self.allSelectButton.selected = isAllSelected;
    
    self.totalPriceLable.text = [NSString stringWithFormat:@"合计：￥%.2lf", totalPrice];
    [self renderWithTotalPrice:[NSString stringWithFormat:@"￥%.2lf", totalPrice]];
    
    [self.settleButton setTitle:[NSString stringWithFormat:@"结算(%ld)", selectCount] forState:UIControlStateNormal];
    
    self.settleButton.enabled = selectCount && totalPrice;
    self.deleteButton.enabled = selectCount && totalPrice;
    
    if (self.settleButton.isEnabled) {
        [self.settleButton setBackgroundColor:kAppThemeColor];
        [self.deleteButton setBackgroundColor:[UIColor colorWithRed:0.918  green:0.141  blue:0.137 alpha:1]];
    } else {
        [self.settleButton setBackgroundColor:[UIColor lightGrayColor]];
        [self.deleteButton setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    if (totalPrice>0) {
        self.totalPriceLable.hidden = NO;
        self.settleButton.enabled = YES;
//        [self clickItenIndex:1];
        
    }else{
        self.totalPriceLable.hidden = YES;
        self.settleButton.enabled = NO;
//        [self clickItenIndex:0];
    }
    
    self.allSelectButton.selected = isAllSelected;
}

- (void)allSelectButtonAction {
    
    self.allSelectButton.selected = !self.allSelectButton.isSelected;
    

    if (self.allSelectButton.selected == YES) {
        [self clickItenIndex:1];
    }else{
        [self clickItenIndex:0];
    }
}


- (void)settleButtonAction {
    
    [self clickItenIndex:3];
}

- (void)deleteButtonAction {
    
    [self clickItenIndex:2];
}

- (void)renderWithTotalPrice:(NSString *)totalPrice {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 2;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.totalPriceLable.text attributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
    [attributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:210/255.0 green:50/255.0 blue:50/255.0 alpha:1]} range:[self.totalPriceLable.text rangeOfString:totalPrice]];
    self.totalPriceLable.attributedText = attributedString;
    self.totalPriceLable.textAlignment = NSTextAlignmentRight;
}


- (UIButton *)allSelectButton {
    if (_allSelectButton == nil){
        _allSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allSelectButton setTitle:@"全选" forState:UIControlStateNormal];
        [_allSelectButton setTitle:@"全不选" forState:UIControlStateSelected];
        [_allSelectButton setTitleColor:[UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1] forState:UIControlStateNormal];
        _allSelectButton.titleLabel.font = [UIFont systemFontOfSize:FONTFIT(14)];
        [_allSelectButton setImage:[UIImage imageNamed:@"all_choose"] forState:UIControlStateNormal];
        [_allSelectButton setImage:[UIImage imageNamed:@"all_choose_select"] forState:UIControlStateSelected];
        [_allSelectButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
        [_allSelectButton addTarget:self action:@selector(allSelectButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allSelectButton;
}

- (UILabel *)totalPriceLable {
    if (_totalPriceLable == nil){
        _totalPriceLable = [[UILabel alloc] init];
        _totalPriceLable.font = [UIFont systemFontOfSize:FONTFIT(14)];
        _totalPriceLable.textColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1];
        _totalPriceLable.numberOfLines = 2;
        _totalPriceLable.text = @"合计：￥0";
    }
    return _totalPriceLable;
}

- (UIButton *)settleButton {
    if (_settleButton == nil){
        _settleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_settleButton setTitle:@"结算(0)" forState:UIControlStateNormal];
        [_settleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _settleButton.titleLabel.font = [UIFont systemFontOfSize:FONTFIT(13)];
        [_settleButton setBackgroundColor:[UIColor lightGrayColor]];
        [_settleButton addTarget:self action:@selector(settleButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _settleButton.enabled = NO;
    }
    return _settleButton;
}


- (UIButton *)deleteButton {
    if (_deleteButton == nil){
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:FONTFIT(13)];
        [_deleteButton setBackgroundColor:[UIColor lightGrayColor]];
        [_deleteButton addTarget:self action:@selector(deleteButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _deleteButton.enabled = NO;
        _deleteButton.hidden = YES;
    }
    return _deleteButton;
}

- (UIView *)separateLine {
    if (_separateLine == nil){
        _separateLine = [[UIView alloc] init];
        _separateLine.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    }
    return _separateLine;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.allSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    [self.settleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.offset(0);
        make.width.equalTo(@100);
    }];
    
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
        make.width.equalTo(@100);
    }];
    
    [self.totalPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).offset(0);
        make.left.equalTo(self.allSelectButton.mas_right);
        make.right.equalTo(self.settleButton.mas_left).offset(-5);
    }];

    
    [self.separateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(@0.3);
    }];
}

- (void)clickItenIndex:(NSInteger)index
{
    if ([_delegate respondsToSelector:@selector(shopCartBotttomViewClickItemImdex:)]) {
        
        [_delegate shopCartBotttomViewClickItemImdex:index];
    }
}

@end
