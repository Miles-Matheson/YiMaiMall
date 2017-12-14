//
//  LDNoticCollectionCell.m
//  FullAndFresh
//
//  Created by Miles on 2017/9/7.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDNoticCollectionCell.h"

@interface LDNoticCollectionCell ()<SDCycleScrollViewDelegate>

@property (nonatomic,strong)NSMutableArray *noticLBsArray;
@property (nonatomic,strong)NSMutableArray *showLBsArray;
@property (nonatomic,strong)SDCycleScrollView * adTextCycleScrollView;
@property (nonatomic,strong)UIView *baseView;


@end

@implementation LDNoticCollectionCell
{
    UIImageView *titleImageView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
        self.contentView.backgroundColor = RGB(240, 240, 240);
    }
    return self;
}

- (void)initUI{
    
    _baseView = [UIView new];
    _baseView.layer.masksToBounds = YES;
    _baseView.backgroundColor = WhiteColor;
    [self.contentView addSubview:_baseView];
    [_baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.offset(8);
        make.bottom.offset(-8);
    }];
    [self layoutIfNeeded];
     _baseView.layer.cornerRadius = _baseView.bounds.size.height/2.;
    

    titleImageView =  [UIImageView new];
    titleImageView.image = [UIImage imageNamed:@"new_1"];
    [_baseView addSubview:titleImageView];
    [titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.offset(0);
    }];
}

- (void)setNewsModels:(NSArray<LDNoticModel *> *)newsModels
{
    _newsModels = newsModels;
    NSMutableArray *array = [NSMutableArray array];
    
    for (LDNoticModel *model in _newsModels) {
        [array addObject:model.title];
    }
    self.adTextCycleScrollView.titlesGroup = array;
    self.adTextCycleScrollView.autoScroll = YES;
}

-(SDCycleScrollView *)adTextCycleScrollView{
    
    if (_adTextCycleScrollView == nil) {
        ws(bself);
        _adTextCycleScrollView = [[SDCycleScrollView alloc]init];
        _adTextCycleScrollView.delegate = self;
        [_baseView addSubview:_adTextCycleScrollView];
        _adTextCycleScrollView.clickItemOperationBlock = ^(NSInteger currentIndex) {
            if (bself.itemClick) {
                @try {
                    bself.itemClick(bself.newsModels[currentIndex]);
                } @catch (NSException *exception) {}
            }
        };
        [_adTextCycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(80);
            make.centerY.offset(0);
            make.top.bottom.offset(0);
            make.right.offset(-10);
        }];

        _adTextCycleScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
        _adTextCycleScrollView.onlyDisplayText = YES;
        _adTextCycleScrollView.autoScrollTimeInterval = 3.0;
        _adTextCycleScrollView.titleLabelBackgroundColor = [UIColor whiteColor];
        _adTextCycleScrollView.titleLabelTextFont = [UIFont systemFontOfSize:15];
        _adTextCycleScrollView.titleLabelTextColor = [UIColor blackColor];
        [_adTextCycleScrollView disableScrollGesture];
    }
    return _adTextCycleScrollView;
}


@end
