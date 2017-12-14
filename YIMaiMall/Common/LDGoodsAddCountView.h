//
//  LDGoodsAddCountView.h
//  FullAndFresh
//
//  Created by Miles on 2017/9/18.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LDGoodsAddCountViewDelegate <NSObject>

-(void)LDGoodsAddCountViewClickView:(id)LDGoodsAddCountView currentCount:(NSInteger )currentCount AddCount:(NSInteger)AddCount;

@end

@interface LDGoodsAddCountView : UIView

@property (nonatomic,copy)void(^itemSelectCallBack)(void);

@property (nonatomic,weak)id <LDGoodsAddCountViewDelegate> delegate;

@property (nonatomic,assign)NSInteger count;

@property (nonatomic,assign)BOOL canBeZero;//是否可以减到0

@end
