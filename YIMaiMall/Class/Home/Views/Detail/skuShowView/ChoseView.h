//
//  ChoseView.h
//  AddShoppingCart
//
//  Created by 主用户 on 16/3/23.
//  Copyright © 2016年 江萧. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeView.h"
#import "BuyCountView.h"
#import "SpecWindowView.h"

@class ChoseView;

@protocol ChoseViewSeleteDelegete <NSObject>

-(void)chooseView:(ChoseView *)chooseView SelectFloorIndex:(NSInteger *)index itemClickIndex:(NSInteger *)itemClickIndex;

@end



@interface ChoseView : UIView<UITextFieldDelegate,UIAlertViewDelegate>

@property(nonatomic, strong)SpecWindowView * specView;

@property(nonatomic, retain)UIView *alphaiView;
@property(nonatomic, retain)UIView *whiteView;

@property(nonatomic, retain)UIImageView *img;

@property(nonatomic, retain)UILabel *lb_price;
@property(nonatomic, retain)UILabel *lb_stock;
@property(nonatomic, retain)UILabel *lb_detail;
@property(nonatomic, retain)UILabel *lb_line;

@property(nonatomic, retain)UIScrollView *mainscrollview;

@property(nonatomic, retain)NSMutableArray *chooseViews;

@property(nonatomic, retain)BuyCountView *countView;

@property(nonatomic, retain)UIButton *bt_sure;
@property(nonatomic, retain)UIButton *bt_cancle;

@property(nonatomic) int stock;

@property(nonatomic,weak) id <ChoseViewSeleteDelegete> delegate;

@end
