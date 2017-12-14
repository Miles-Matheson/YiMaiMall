//
//  LDCommonSelectFilterView.h
//  YIMaiMall
//
//  Created by Miles on 2017/11/25.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LDCommonSelectFilterView;

@protocol LDCommonSelectFilterViewDelegate <NSObject>

- (void)LDCommonSelectFilterView:(LDCommonSelectFilterView *)view clickBtn:(UIButton *)btn;

@end

@interface LDCommonSelectFilterView : UIView

@property (nonatomic, assign) id <LDCommonSelectFilterViewDelegate> delegate;

@property (nonatomic, strong) UIButton *lastSelBtn;

- (id)initWithFrame:(CGRect)frame titles:(NSArray *)titles isShowImgs:(NSArray *)isShowImgs  interactions:(NSArray *)interactions imgTitleIntervals:(NSArray *)imgTitleIntervals titleIntervals:(NSArray *)titleIntervals;

- (void)rotateArrow:(UIButton *)btn;
- (void)rotateArrow;

@end
