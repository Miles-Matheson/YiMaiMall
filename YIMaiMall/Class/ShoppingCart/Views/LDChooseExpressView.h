//
//  LDChooseExpressView.h
//  YIMaiMall
//
//  Created by Miles on 2017/11/21.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LDChooseExpressView;

@protocol LDChooseExpressViewDelegate<NSObject>

-(void)expressViewShow:(LDChooseExpressView *)expressViewShow SelectIndex:(NSInteger)index;

@end

@interface LDChooseExpressView : UIView
@property (nonatomic,copy)NSArray *dataSource;
@property (nonatomic,strong)UILabel *titleLB;
@property (nonatomic,assign)NSInteger selectIndex;

@property (nonatomic,weak)id <LDChooseExpressViewDelegate> delegate;

+(LDChooseExpressView*)showInSubView:(UIViewController *)controller Frame:(CGRect)rect dataSource:(NSArray*)dataSource;

@end
