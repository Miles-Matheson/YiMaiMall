//
//  StarView.h
//  StarScoreDemo
//
//  Created by StarLord on 15/7/28.
//  Copyright (c) 2015年 xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarView : UIView
@property (nonatomic, strong) UIImage *starHighLightImage;
@property (nonatomic, strong) UIImage *starNormalImage;
@property (nonatomic, assign) CGFloat percent; //进度0-1

@end
