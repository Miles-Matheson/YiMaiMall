//
//  LDSubbranchSelView.h
//  MerchantCenter
//
//  Created by kevin on 2017/2/22.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//





#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SubbranchStatusDefulat = 0,
    SubbranchStatusImageAndLeft,
    
} SubbranchStatus;

@class LDSubbranchSelView;

@protocol LDSubbranchSelViewDelegate <NSObject>


- (void)LDSubbranchSelView:(LDSubbranchSelView *)view selectedIndex:(NSInteger)selectedIndex;
- (void)LDSubbranchSelViewDismiss:(LDSubbranchSelView *)view;

@end


//@interface classModel : NSObject
//
////@property(nonatomic,strong)NSNumber *ID;
////@property(nonatomic,copy)NSString * Name;
////@property(nonatomic,copy)NSString * ICON;
//
//@end

@interface LDSubbranchSelView : UIView

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic,assign)SubbranchStatus subbranchStatus;

@property (nonatomic, strong) id object;

@property (nonatomic, assign) id <LDSubbranchSelViewDelegate> delegate;

@property (nonatomic, assign) NSInteger lastSelIndex; //上次选择index

+ (void)showInView:(UIView *)superView frame:(CGRect)frame SubbranchStatus:(SubbranchStatus)satus delegate:(id)delegate dataSource:(NSArray <NSDictionary *> *)dataSource object:(id)object lastSelIndex:(NSInteger)lastSelIndex;

+ (void)dismissFromView:(UIView *)superView;

@end

