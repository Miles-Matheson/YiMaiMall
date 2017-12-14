//
//  LDHomeBannerCell.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/15.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDCollectionBannerCell.h"
#import <SDCycleScrollView/SDCycleScrollView.h>

@interface LDCollectionBannerCell ()<SDCycleScrollViewDelegate>
{
    SDCycleScrollView *bannerView;
}
@end
@implementation LDCollectionBannerCell


-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
         [self initUI];
    }
    return self;
}

- (void)initUI
{
    bannerView =  [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100) delegate:self placeholderImage:[UIImage imageNamed:KplaceholderImage]];
    bannerView.autoScroll = YES;
    [self.contentView addSubview:bannerView];
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.offset(0);
    }];
}
#pragma mark --SDCycleScrollViewDelete

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    if (self.bannerClick) {
        self.bannerClick(self.models[index]);
    }
}

-(void)setModels:(NSArray *)models
{
    if (_models == models && models.count ) {
        return;
    }
    _models = models;
    NSMutableArray *arr = [NSMutableArray array];
    for (LDBannerModel *model in _models) {
        if (model.img) {
            [arr addObject:model.img];
        }
    }
    bannerView.imageURLStringsGroup = arr;
    bannerView.autoScroll = YES;
}

@end

