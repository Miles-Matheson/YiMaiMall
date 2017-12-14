//
//  SpecAddCountButtonCell.m
//  YIMaiMall
//
//  Created by Miles on 2017/12/12.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "SpecAddCountButtonCell.h"


@implementation SpecAddCountButtonCell 

- (void)awakeFromNib {
    [super awakeFromNib];
}


-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    _addNumberBtn = [PPNumberButton numberButtonWithFrame:CGRectMake(0, 0, 150, 30)];
    //设置边框颜色
//    _addNumberBtn.borderColor = [UIColor grayColor];
    _addNumberBtn.increaseTitle = @"＋";
    _addNumberBtn.decreaseTitle = @"－";
    _addNumberBtn.minValue = 1;
    _addNumberBtn.delegate = self;
    [self.contentView addSubview:_addNumberBtn];
    
    [_addNumberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
        make.top.offset(0);
        make.width.offset(SIZEFIT(150));//0.21428
        make.height.offset(SIZEFIT(150)*0.3);// 高/宽
    }];
    
    UILabel*countTitle = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"购买数量" textColor:RGB(51,51,51) textAlignment:Left font:kFont16];
    [self.contentView addSubview:countTitle];
    [countTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.centerY.equalTo(_addNumberBtn.mas_centerY);
    }];
}

- (void)pp_numberButton:(PPNumberButton *)numberButton number:(NSInteger)number increaseStatus:(BOOL)increaseStatus{
    
    if (self.changeCountClick) {
        self.changeCountClick(number);
    }
}

-(void)setMaxCount:(NSInteger)maxCount{
    _maxCount = maxCount;
    _addNumberBtn.maxValue = _maxCount;
}

@end
