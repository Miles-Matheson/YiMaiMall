//
//  LDGoodsListCell.m
//  FullAndFresh
//
//  Created by Miles on 2017/9/7.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDGoodsLisCell.h"
#import "LDGoodsAddCountView.h"

@interface LDGoodsLisCell ()<LDGoodsAddCountViewDelegate>

@property (nonatomic,strong)LDGoodsAddCountView *countView;

@end

@implementation LDGoodsLisCell
{
    UILabel *counentLab;
    UILabel *countLB;
    UILabel *desLab;
    UILabel *priceLab;
    UILabel *backGDALB;
    UIImageView *GDAImage;
}

-(LDGoodsAddCountView*)countView
{
    if (!_countView) {
        _countView = [[LDGoodsAddCountView alloc]init];
        [self.contentView addSubview:_countView];
        _countView.delegate = self;
        [_countView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(0);
            make.centerY.equalTo(backGDALB.mas_centerY);
            make.width.offset(120);
            make.height.offset(40);
        }];
    }
    return _countView;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = WhiteColor;
        [self initUI];
    }
    return self;
}
- (void)initUI
{
    WS(bself);
    
    _topImageView = [UIImageView new];
    [self.contentView addSubview:_topImageView];
    
    counentLab = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"5斤现摘 自然熟新鲜番茄西红柿蔬菜水果傻飘上就睡觉吧" textColor:RGB(51,51,51) textAlignment:Left font:kFont13];
    counentLab.numberOfLines = 2;
    [self.contentView addSubview:counentLab];
    
    
    GDAImage = [UIImageView new];
    GDAImage.image = [UIImage imageNamed:@"rebate"];
    [self.contentView addSubview:GDAImage];
    
    
    backGDALB = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"16" textColor:kAppThemeColor textAlignment:Left font:kFont11];
    [self.contentView addSubview:backGDALB];
    
    desLab = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"靶场路1号星光天地大厦12-15层复位" textColor:RGB(153,153,153) textAlignment:Left font:kFont12];
    desLab.numberOfLines = 2;
    desLab.hidden = YES;
    [self.contentView addSubview:desLab];
    
    
    priceLab = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"**" textColor:kAppThemeColor textAlignment:Left font:kFont15];
    [self.contentView addSubview:priceLab];
    
    
    countLB = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"" textColor:RGB(153,153,153) textAlignment:Right font:kFont11];
    [self.contentView addSubview:countLB];
   
    
    [_topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.equalTo(_topImageView.mas_width);
    }];
    
    [counentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(_topImageView.mas_bottom).offset(SIZEFIT(5));
    }];
    
    
    [GDAImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.bottom.offset(-10);
    }];
    
    [backGDALB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(GDAImage.mas_right).offset(5);
        make.centerY.equalTo(GDAImage.mas_centerY);
    }];
    
    [desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topImageView.mas_right).offset(10);
        make.top.equalTo(counentLab.mas_bottom).offset(SIZEFIT(5));
        make.right.equalTo(counentLab.mas_right);
    }];
    
    [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(GDAImage.mas_left);
        make.bottom.equalTo(GDAImage.mas_top).offset(SIZEFIT(-7));
    }];
    
    
    [countLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.centerY.equalTo(priceLab.mas_centerY);
    }];
}

#pragma mark LDGoodsAddCountViewDelegate
-(void)LDGoodsAddCountViewClickView:(id)LDGoodsAddCountView currentCount:(NSInteger)currentCount AddCount:(NSInteger)AddCount{
    
    if (currentCount == 0) {
        
        GDAImage.hidden = NO;
        self.countView.hidden = YES;
        
    }else if (self.addItemClick){
        
        self.addItemClick(AddCount, currentCount,self);
    }
}

-(void)setIsGrid:(BOOL)isGrid
{
    GDAImage.userInteractionEnabled = isGrid;
    
    if (_isGrid == isGrid) {
        return;
    }
    _isGrid = isGrid;

    if (_isGrid) {

        [_topImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.offset(0);
            make.left.offset(10);
            make.width.equalTo(_topImageView.mas_height);
        }];
        
        [counentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_topImageView.mas_right).offset(19);
            make.top.offset(20);
            make.right.offset(-20);
        }];
        
        [priceLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_topImageView.mas_right).offset(19);
            make.bottom.offset(-20);
        }];
        
        [GDAImage mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(priceLab.mas_right).offset(10);
            make.bottom.offset(-20);
        }];
        
        [backGDALB mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(GDAImage.mas_right).offset(5);
            make.centerY.equalTo(GDAImage.mas_centerY);
        }];
        
        [desLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_topImageView.mas_right).offset(19);
            make.centerY.offset(0);
            make.right.equalTo(counentLab.mas_right);
        }];
        
        [countLB mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-10);
            make.centerY.equalTo(priceLab.mas_centerY);
        }];
        
        desLab.hidden = NO;

    }else{
        
         desLab.hidden = YES;
        [_topImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.offset(0);
            make.height.equalTo(_topImageView.mas_width);
        }];
        
        [counentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.right.offset(-10);
            make.top.equalTo(_topImageView.mas_bottom).offset(SIZEFIT(5));
        }];
        
        [GDAImage mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.bottom.offset(-10);
        }];
        
        [backGDALB mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(GDAImage.mas_right).offset(5);
            make.centerY.equalTo(GDAImage.mas_centerY);
        }];
        
        [desLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_topImageView.mas_right).offset(10);
            make.top.equalTo(counentLab.mas_bottom).offset(SIZEFIT(5));
            make.right.equalTo(counentLab.mas_right);
        }];
        
        [priceLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(GDAImage.mas_left);
            make.bottom.equalTo(GDAImage.mas_top).offset(SIZEFIT(-7));
        }];
        
        [countLB mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-10);
            make.centerY.equalTo(priceLab.mas_centerY);
        }];
    }
}

-(void)showAddView
{
    GDAImage.hidden = YES;
    self.countView.hidden = NO;
    self.countView.count = 1;
    if(self.addItemClick){
        self.addItemClick(1, 1,self);
    }
}

-(void)setModel:(LDGoodsListModel *)model
{
    _model = model;
    [_topImageView sd_setImageWithURL:[NSURL URLWithString:_model.img] placeholderImage:[UIImage imageNamed:KplaceholderImage]];
    counentLab.text = _model.gName;

    NSString *string = [NSString stringWithFormat:@"%.2f",_model.price];
    NSArray *array = [string componentsSeparatedByString:@"."]; //从字符A中分隔成2个元素的数组
    NSString *price = array.firstObject;
    
    NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:string];
    
    [att addAttribute:NSFontAttributeName
                value:[UIFont systemFontOfSize:20.0f]
                range:NSMakeRange(0,price.length+1)];
    
    [att addAttribute:NSForegroundColorAttributeName
                    value:kAppSubThemeColor
                    range:NSMakeRange(0,string.length)];
    [att addAttribute:NSFontAttributeName
                value:[UIFont systemFontOfSize:15.0f]
                range:NSMakeRange(price.length+1,string.length-price.length-1)];
    
    priceLab.attributedText = att;
    
    NSString *countString = @"";
    if (_model.count>=10000) {
        countString = [NSString  stringWithFormat:@"销量 %ld万",_model.count/10000];
    }else if (_model.count){
         countString = [NSString  stringWithFormat:@"销量 %ld",_model.count];
    }
    countLB.text = countString;
    
    if (_model.gda) {
        GDAImage.hidden = NO;
        backGDALB.text = [NSString stringWithFormat:@"%ldGDA",model.gda];
    }else{
        backGDALB.text = @"";
        GDAImage.hidden = YES;
    }
}

@end
