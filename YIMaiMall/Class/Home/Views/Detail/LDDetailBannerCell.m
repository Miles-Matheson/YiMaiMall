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
}
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
    bannerView =  [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100) delegate:self placeholderImage:[UIImage imageNamed:KplaceholderImage]];
    bannerView.autoScroll = YES;
    [self.contentView addSubview:bannerView];
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.offset(0);
    }];
    
    bannerView.imageURLStringsGroup = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1510917270870&di=2ba7faf38a911db17d9c24a03cf2a078&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F13%2F95%2F63%2F16q58PICdcu_1024.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1510917270869&di=c1da6a6ff459209b87fb849fd42fe270&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F13%2F03%2F92%2F16p58PICkPE.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1510917286403&di=848a16959c3bb7580073298fde458b31&imgtype=0&src=http%3A%2F%2Fpic40.nipic.com%2F20140428%2F8175703_125619055322_2.jpg"];
    bannerView.autoScroll = YES;
    bannerView.pageControlBottomOffset = 20;
    
    saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bannerView addSubview:saveBtn];
    [saveBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [saveBtn setTitle:@"已收藏" forState:UIControlStateSelected];
    [saveBtn setTitleColor:RedColor forState:0];
    [saveBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIButton * sender) {
        sender.selected =  !sender.selected;
    }];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.bottom.offset(-15);
    }];
    
}
#pragma mark --SDCycleScrollViewDelete

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    [self clickIndex:index];
}

-(void)setModels:(NSArray *)models
{
    bannerView.imageURLStringsGroup = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1510917270870&di=2ba7faf38a911db17d9c24a03cf2a078&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F13%2F95%2F63%2F16q58PICdcu_1024.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1510917270869&di=c1da6a6ff459209b87fb849fd42fe270&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F13%2F03%2F92%2F16p58PICkPE.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1510917286403&di=848a16959c3bb7580073298fde458b31&imgtype=0&src=http%3A%2F%2Fpic40.nipic.com%2F20140428%2F8175703_125619055322_2.jpg"];
    bannerView.autoScroll = YES;
}


#pragma mark - private actions

- (void)clickIndex:(NSInteger)index{
    
    NSArray *array = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1510917270870&di=2ba7faf38a911db17d9c24a03cf2a078&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F13%2F95%2F63%2F16q58PICdcu_1024.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1510917270869&di=c1da6a6ff459209b87fb849fd42fe270&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F13%2F03%2F92%2F16p58PICkPE.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1510917286403&di=848a16959c3bb7580073298fde458b31&imgtype=0&src=http%3A%2F%2Fpic40.nipic.com%2F20140428%2F8175703_125619055322_2.jpg"];
    
    NSMutableArray *photos = [NSMutableArray array];
    for (int i = 0 ; i < array.count; i++) {//传递数据给浏览器
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:array[i]];
        [photos addObject:photo];
    }
     self.photoBrowser.photos = photos;
    //3.设置默认显示的图片索引
    self.photoBrowser.currentPhotoIndex = index;
    //4.显示浏览器
    [self.photoBrowser show];
}

@end

