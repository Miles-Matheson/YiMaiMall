//
//  LDCommentImageView.m
//  BaseFrame
//
//  Created by Miles on 2017/7/3.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import "LDCommentImageView.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
@interface LDCommentImageView ()

@property (nonatomic,copy)NSString *imageURL;
@property (nonatomic, strong) NSMutableArray *imageViewsArray;
@property(nonatomic,strong)MJPhotoBrowser * photoBrowser;
@end

@implementation LDCommentImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
        self.backgroundColor = ClearColor;
    }
    return self;
}

-(MJPhotoBrowser *)photoBrowser
{
    if (!_photoBrowser) {
        _photoBrowser = [[MJPhotoBrowser alloc]init];
    }
    return _photoBrowser;
}

- (void)setup
{
    NSMutableArray *temp = [NSMutableArray array];
    
    for (int i = 0; i < 15; i++) {
        
        UIImageView *imageView = [[UIImageView alloc]init];
        [self addSubview:imageView];
        
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        [temp addObject:imageView];
    }
    
    self.imageViewsArray = [[NSMutableArray alloc]initWithArray:temp];
}


- (void)setContentImgs:(NSArray *)contentImgs{
    
    _contentImgs = contentImgs;
    
    for (long i = _contentImgs.count; i < self.imageViewsArray.count; i++) {
        UIImageView *imageView = [self.imageViewsArray objectAtIndex:i];
        imageView.hidden = YES;
    }
    
    if (_contentImgs.count == 0) {
        self.height = 0;
        return;
    }
    
    CGFloat itemW = [self itemWidthForPicPathArray:_contentImgs];
    
    CGFloat itemH = 0;
    if (_contentImgs.count == 1) {
        
        itemH =  SCREEN_WIDTH/2.;
        
    } else {
        itemH = itemW;
    }
    
    CGFloat margin = 5;
    
    
    for (int i = 0; i < _contentImgs.count; i ++) {
        
        long columnIndex = i % 3;
        
        long rowIndex = i / 3;
        
        UIImageView *imageView = [_imageViewsArray objectAtIndex:i];
        
        imageView.hidden = NO;
        
        NSString *str  =  _contentImgs[i];
        
        imageView.frame = CGRectMake(columnIndex * (itemW + margin) +10, rowIndex * (itemH + margin), itemW, itemH);
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:KplaceholderImage]];
        
        CGRect rect;
        
        if (i == _contentImgs.count-1)
        {
            rect = CGRectMake(0, 0, SCREEN_WIDTH -20, imageView.bottom);
            self.frame = rect;
            
            [self setNeedsDisplay];
        }
    }
}


#pragma mark - private actions

- (void)tapImageView:(UITapGestureRecognizer *)tap
{
    
    NSMutableArray *photos = [NSMutableArray array];
    
    for (int i = 0 ; i < self.contentImgs.count; i++) {
        //传递数据给浏览器
        MJPhoto *photo = [[MJPhoto alloc] init];
        
        photo.url = [NSURL URLWithString:self.contentImgs[i]];
        
        [photos addObject:photo];
    }
    self.photoBrowser.photos = photos;
    
    UIView *view = tap.view;
    
    //3.设置默认显示的图片索引
    self.photoBrowser.currentPhotoIndex = view.tag;
    //4.显示浏览器
    [self.photoBrowser show];
}

- (CGFloat)itemWidthForPicPathArray:(NSArray *)array
{
    if (array.count == 1) {
        return (SCREEN_WIDTH-68)/2.;
    } else {
        CGFloat w = (SCREEN_WIDTH-68)/3.;
        return w;
    }
}

- (NSInteger)perRowItemCountForPicPathArray:(NSArray *)array
{
    if (array.count <= 3) {
        return array.count;
    } else if (array.count <= 4) {
        return 2;
    } else {
        return 3;
    }
}

@end

