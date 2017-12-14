//
//  LDCommonFilterView.h
//  MerchantCenter
//
//  Created by kevin on 2017/2/24.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LFButton.h"
@class LDCommonFilterView;

@protocol LDCommonFilterViewDelegate <NSObject>

- (void)LDCommonFilterView:(LDCommonFilterView *)view clickBtn:(LFButton *)btn;

@end

@interface LDCommonFilterView : UIView

@property (nonatomic, assign) id <LDCommonFilterViewDelegate> delegate;

@property (nonatomic, strong) LFButton *lastSelBtn;
@property (nonatomic, strong) NSArray <LFButton*>*showBtns;

- (id)initWithFrame:(CGRect)frame titles:(NSArray *)titles isShowImgs:(NSArray *)isShowImgs interactions:(NSArray *)interactions imgTitleIntervals:(NSArray *)imgTitleIntervals titleIntervals:(NSArray *)titleIntervals normalImages:(NSArray<NSString*>*)normalImages selectImages:(NSArray<NSString *>*)selectImages;

- (void)rotateArrow:(UIButton *)btn;
- (void)rotateArrow;

@end
