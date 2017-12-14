//
//  LDDetailBottomView.h
//  StairOrder
//
//  Created by Miles on 2017/8/17.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolBtn.h"

@protocol LDDetailBottomViewDelegate <NSObject>

@optional

/*
 button.tag
 0  客服
 1  店铺
 2  购物车
 3  加入购物车
 4 立即购买
 */
- (void)LDDetailBottomView:(id )bottomView ClickItem:(UIButton *)button;

@end

@interface LDDetailBottomView : UIView

@property (nonatomic,assign)id<LDDetailBottomViewDelegate> delegate;

@property (nonatomic,strong)ToolBtn *shopCartBtn;

@end
