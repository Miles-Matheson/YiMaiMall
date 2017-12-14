//
//  AddCommentCell.m
//  StairOrder
//
//  Created by Miles on 2017/9/13.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "AddCommentCell.h"
#import "StarsView.h"

@interface AddCommentCell ()
{
    UIImageView *imgView;
    UILabel *countentLB;
    UILabel *timeLB;
}
@property(nonatomic,strong)StarsView *starsView;

@end

@implementation AddCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = 0;
        [self initUI];
        
    }
    return self;
}
- (void)initUI
{
    ws(bself);
    imgView = [UIImageView new];
    imgView.layer.cornerRadius = 40;
    imgView.layer.masksToBounds = YES;
    [self.contentView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(10);
        make.width.height.offset(80);
    }];
    
    
    countentLB = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"" textColor:BlackColor textAlignment:Left font:kFont16];
    [self.contentView addSubview:countentLB];
    
    [countentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgView.mas_right).offset(10);
        make.bottom.equalTo(imgView.mas_centerY).offset(-5);
    }];
    
    
    timeLB = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"" textColor:BlackColor textAlignment:Left font:kFont16];
    [self.contentView addSubview:timeLB];
    
    [timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgView.mas_right).offset(10);
        make.top.equalTo(imgView.mas_centerY).offset(5);
    }];
    
    
    UIView *bottomHLine = [ViewCreate createLineFrame:CGRectMake(0, 0, 20, 0) backgroundColor:RGB(236, 236, 236)];
    [self.contentView addSubview:bottomHLine];
    
    [bottomHLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(0.5);
        make.top.equalTo(bself.contentView.mas_top).offset(100);
    }];

    UILabel *lab = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"总体评价:" textColor:BlackColor textAlignment:Left font:kFont16];
    [self.contentView addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(bottomHLine.mas_bottom).offset(20);
    }];
//
    _starsView = [[StarsView alloc]initWithStarSize:CGSizeMake(20, 20) space:5 numberOfStar:5 starNormalImage:[UIImage imageNamed:@"xing1"] starHighLightImage:[UIImage imageNamed:@"xing2"]];
    [self.contentView addSubview:_starsView];
    [_starsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lab.mas_right).offset(10);
        make.centerY.equalTo(lab.mas_centerY);
        make.height.offset(25);
        make.width.offset(200);
    }];

    [_starsView setStarBlock:^(NSInteger count){
        if (bself.startTouckClick) {
            bself.startTouckClick(count);
        }
    }];

}


-(void)setModel:(OrdersDetailModel *)model
{
    [imgView sd_setImageWithURL:[NSURL URLWithString:model.CommodityPic] placeholderImage:[UIImage imageNamed:KplaceholderImage]];
    countentLB.text = model.CommodityName;
    timeLB.text = model.CommodityName;
}

@end
