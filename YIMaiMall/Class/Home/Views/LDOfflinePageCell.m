//
//  LDSpecialOfferCellCollectionViewCell.m
//  FullAndFresh
//
//  Created by Miles on 2017/10/17.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDOfflinePageCell.h"
#import "LDGoodsListView.h"


#define  indexViewWidth  SIZEFIT(95)

@implementation LDOfflinePageCell

{
    UIScrollView *scrollView;
    NSMutableArray *homeIndexViewArray;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
        self.contentView.backgroundColor = WhiteColor;
    }
    return self;
}

- (void)initUI
{
    scrollView= [UIScrollView new];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.backgroundColor = WhiteColor;
    [self.contentView addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(SIZEFIT(15));
        make.height.offset(SIZEFIT(85));
        make.centerY.offset(0);
    }];
    
    homeIndexViewArray = [NSMutableArray array];

    for (int i = 0; i < 10; i ++) {
        LDGoodsListView *indexView = [[LDGoodsListView alloc]init];
        indexView.hidden = YES;
        [homeIndexViewArray addObject:indexView];
    }
}

-(void)setModels:(NSArray<LDGoodsListModel *> *)models
{
    _models = models;
//itemClickCallBack
    for (int i = 0; i < _models.count; i ++) {
        
        LDGoodsListModel *model = _models[i];
        LDGoodsListView *indexView  = homeIndexViewArray[i];
        indexView.tag = i;
        indexView.hidden = NO;
        indexView.model = model;
        
        UIView *view =  [scrollView viewWithTag:i];
        if ([view isKindOfClass:[LDGoodsListView class]]) {
            return;
        }else{
            [scrollView addSubview:indexView];
            [indexView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(10+(i * (indexViewWidth +10)));
                make.width.offset(indexViewWidth);
                make.top.offset(0);
                make.height.offset(SIZEFIT(85));
            }];
            if (self.itemClickCallBack) {
                indexView.itemClickCallBack = ^(LDGoodsListModel *model) {
                    self.itemClickCallBack(model);
                };
            }
        }
    }
    scrollView.contentSize = CGSizeMake(_models.count *(indexViewWidth+10) +10 ,SIZEFIT(85));
}


@end
