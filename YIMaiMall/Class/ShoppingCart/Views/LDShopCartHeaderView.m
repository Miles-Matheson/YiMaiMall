//
//  LDShopCartHeaderView.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/18.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDShopCartHeaderView.h"

@implementation LDShopCartHeaderView
{
    UIButton *selectBtn;
    UIButton *editingBtn;
    UILabel *titleLB;
}
-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.backgroundColor = WhiteColor;
    }
    return self;
}

-(void)initUI{
    
    selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectBtn setImage:[UIImage imageNamed:@"all_choose"] forState:UIControlStateNormal];
    [selectBtn setImage:[UIImage imageNamed:@"all_choose_select"] forState:UIControlStateSelected];
    [selectBtn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:selectBtn];
    
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZEFIT(15));
        make.top.bottom.offset(0);
    }];
    
    editingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [editingBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editingBtn setTitle:@"完成" forState:UIControlStateSelected];
    [editingBtn setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
    [editingBtn setTitleColor:RGB(153, 153, 153) forState:UIControlStateSelected];
    editingBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    editingBtn.titleLabel.font = kFont15;
    [editingBtn addTarget:self action:@selector(editingClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:editingBtn];
    
    [editingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-SIZEFIT(15));
        make.top.bottom.offset(0);
        make.width.equalTo(selectBtn.mas_height);
    }];
    
    titleLB = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"***" textColor:RGB(51,51,51) textAlignment:Left font:kFont15];
    [self.contentView addSubview:titleLB];
    
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(selectBtn.mas_right).offset(10);
        make.centerY.offset(0);
    }];
}

-(void)setModel:(LDShopCartModel *)model{
    _model = model;
    selectBtn.selected = _model.isselect;
    editingBtn.selected = _model.isEditing;
    
    titleLB.text = _model.storeName;
}

-(void)selectClick:(UIButton *)selectButton{
    
    if (self.selectItemClick) {
        self.selectItemClick(self);
    }
}

-(void)editingClick:(UIButton *)editingButton{
    
    if (self.editItemClick) {
        self.editItemClick(editingBtn.selected,self.sectionIndex);
    }
}


@end
