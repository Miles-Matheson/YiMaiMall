//
//  ShopCartBottomView.h
//  BaseFrame
//
//  Created by 陈舟为 on 2017/6/27.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShopcartBotttomViewDelegate <NSObject>

/*
 ///0 :全不选,
 ///1 :全选,
 ///2 :删除,
/// 3 :支付,
 */
- (void)shopCartBotttomViewClickItemImdex:(NSInteger)index;

@end


@interface ShopCartBottomView : UIView

@property (nonatomic,assign)CGFloat price;
@property (nonatomic,assign)NSInteger count;

@property (nonatomic,assign)BOOL isVip;

@property (nonatomic,assign)CGFloat discountedmony;//可优惠/已经优惠价格

@property (nonatomic,weak)id <ShopcartBotttomViewDelegate> delegate;

- (void)configureShopcartBottomViewWithTotalPrice:(float)totalPrice selectCount:(NSInteger)selectCount isAllselected:(BOOL)isAllSelected ;

//- (void)changeShopcartBottomViewWithStatus:(BOOL)status;

@end
