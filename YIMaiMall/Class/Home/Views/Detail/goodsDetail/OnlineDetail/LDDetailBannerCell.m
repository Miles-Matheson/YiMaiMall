//
//  LDDetailBannerCell.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/17.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDDetailBannerCell.h"
#import <SDCycleScrollView/SDCycleScrollView.h>

@interface LDDetailBannerCell ()<SDCycleScrollViewDelegate>
{
    SDCycleScrollView *bannerView;
    UIButton *saveBtn;
    NSMutableArray *imageUrlArray;
}
@property (nonatomic,copy)NSArray <LDGoodsDetailBannerModel*>*models;

@property(nonatomic,strong)MJPhotoBrowser * photoBrowser;
@end

@implementation LDDetailBannerCell

-(MJPhotoBrowser *)photoBrowser{
    if (!_photoBrowser) {
        _photoBrowser = [[MJPhotoBrowser alloc]init];
    }
    return _photoBrowser;
}

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    ws(bself);
    bannerView =  [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100) delegate:self placeholderImage:[UIImage imageNamed:KplaceholderImage]];
    bannerView.autoScroll = YES;
    [self.contentView addSubview:bannerView];
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.offset(0);
    }];
    bannerView.autoScroll = YES;
    bannerView.pageControlBottomOffset = 20;

    saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bannerView addSubview:saveBtn];
    [bannerView bringSubviewToFront:saveBtn];
    
    [saveBtn setImage:[UIImage imageNamed:@"love_2"] forState:UIControlStateNormal];
    [saveBtn setImage:[UIImage imageNamed:@"love_1"] forState:UIControlStateSelected];
    [saveBtn setTitleColor:RedColor forState:0];
    [saveBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIButton * sender) {
        if (bself.foucsClick) {
            bself.foucsClick(bself.model);
        }
    }];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.bottom.offset(-15);
        make.height.with.offset(50);
    }];
    
}
#pragma mark --SDCycleScrollViewDelete

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    [self clickIndex:index];
}

-(void)setModel:(LDGoodsDetailModel *)model{
    _model = model;
    self.models = _model.bannerList;
    saveBtn.selected = _model.isCollect;
}

-(void)setModels:(NSArray<LDGoodsDetailBannerModel *> *)models{
    
    _models = models;

    imageUrlArray = [NSMutableArray array];
    for (LDGoodsDetailBannerModel *model in _models) {
        [imageUrlArray addObject:model.url];
    }
    bannerView.imageURLStringsGroup = imageUrlArray;
    bannerView.autoScroll = YES;
}


#pragma mark - private actions

- (void)clickIndex:(NSInteger)index{
    
    NSMutableArray *photos = [NSMutableArray array];
    for (int i = 0 ; i < imageUrlArray.count; i++) {//传递数据给浏览器
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:imageUrlArray[i]];
        [photos addObject:photo];
    }
     self.photoBrowser.photos = photos;
    //3.设置默认显示的图片索引
    self.photoBrowser.currentPhotoIndex = index;
    //4.显示浏览器
    [self.photoBrowser show];
}

@end

