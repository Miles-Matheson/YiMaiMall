//
//  LDCustomNavView.h
//  StairOrder
//
//  Created by Miles on 2017/8/15.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LFButton.h"

@protocol LDCustomNavViewDelegate <NSObject>

@optional

/**
 *  @handel : 点击的控件
 *  @param index 控件tag值 10 定位 20 搜索 30  二维码
 */
- (void)navClickHandel:(id)handel WithIndex:(NSInteger)index;

@end



@interface LDCustomNavView : UIView

@property (nonatomic, strong) VerticalBtn *scanCodeBtn;
@property (nonatomic, strong) LFButton *addTitleBtn;

@property (nonatomic,assign)NSInteger messageCount;

@property (nonatomic,assign)id<LDCustomNavViewDelegate>delegate;
@end
