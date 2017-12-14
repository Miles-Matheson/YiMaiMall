//
//  ShopCartBottomView.h
//  BaseFrame
//
//  Created by 陈舟为 on 2017/6/27.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LDStatmentBottomView : UIView

-(void)setPrice:(CGFloat)price count:(NSInteger)count;

@property (nonatomic,assign,readonly)CGFloat price;
@property (nonatomic,assign,readonly)NSInteger count;

@property (nonatomic,copy)void(^statmentClick)(void);


@end
