//
//  LDCommentShowCell.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/17.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDCommentShowCell.h"

@interface LDCommentShowCell ()
@property (nonatomic,strong)  LDGoodsEvaluateDtoModel *evaluateModel;

@property (nonatomic,strong)  UILabel *commentShowLB;
@property (nonatomic,strong)  UILabel *contentLB;

@end
@implementation LDCommentShowCell

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self initUI];
        self.contentView.backgroundColor = WhiteColor;
    }
    return self;
}

-(void)initUI{
    
    UILabel *commentLB = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"商品评价" textColor:RGB(102, 102, 102) textAlignment:Left font:kFont14];
    [self.contentView addSubview:commentLB];
    [commentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.centerY.offset(0);
    }];
    
    _commentShowLB = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"**" textColor:kAppSubThemeColor textAlignment:Left font:kFont14];
    [self.contentView addSubview:_commentShowLB];
    [_commentShowLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.centerY.offset(0);
    }];
    
    UIImageView *imgView = [UIImageView new];
    imgView.image = [UIImage imageNamed:@""];
    [self.contentView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.offset(-12);
    }];
    
    _contentLB = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"*人评价" textColor:kAppSubThemeColor textAlignment:Left font:kFont15];
    [self.contentView addSubview:_contentLB];
    [_contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(imgView.mas_left).offset(-10);
        make.centerY.offset(0);
    }];
}

-(void)setModel:(LDGoodsDetailModel *)model{
    _model = model;

    self.evaluateModel = _model.goodsEvaluateDto;
    
   
}

-(void)setEvaluateModel:(LDGoodsEvaluateDtoModel *)evaluateModel{
    
    _evaluateModel = evaluateModel;
    
     _commentShowLB.text = [NSString stringWithFormat:@"好评率 %@%%",_evaluateModel.praiseRate];
    _contentLB.text  = [NSString stringWithFormat:@"%ld人评价",_evaluateModel.count];
}

@end
