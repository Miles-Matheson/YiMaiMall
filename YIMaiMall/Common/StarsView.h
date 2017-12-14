//
//  StarsView.h
//  StarScoreDemo
//
//  Created by StarLord on 15/7/28.
//  Copyright (c) 2015年 xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarsView : UIView

@property (nonatomic, assign) BOOL selectable;  //是否触摸选择分数(默认为YES)
@property (nonatomic, assign) CGFloat score;    //分数
@property (nonatomic, assign) BOOL supportDecimal; //是否支持触摸选择小数(默认为NO)
@property (nonatomic, strong) UIImage *starHighLightImage;
@property (nonatomic, strong) UIImage *starNormalImage;
//size是你的图片的size   space是Star间的间距  
- (instancetype)initWithStarSize:(CGSize)size space:(CGFloat)space numberOfStar:(NSInteger)number starNormalImage:(UIImage *)starNormalImage starHighLightImage:(UIImage *)starHighLightImage;
@property (nonatomic,copy)void (^starBlock)(NSInteger count);
@end
