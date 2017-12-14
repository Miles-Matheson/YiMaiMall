//
//  UIView+Common.h
//  ylb
//
//  Created by gravel on 16/3/15.
//  Copyright © 2016年 gravel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMPopupItem.h"
@class LoadingView,BlankPageView;

typedef NS_ENUM(NSInteger, EaseBlankPageType)
{
    BlankPageActivity = 0,
    BlankPageTreat,
    BlackPageOrderReport,
    BlackPageFeedback,
    BlackPageBounds,
    BlankPageBalanceDetail,
    BlankPageMyOrder,//订单
    BlankPageShopCar,
    BlankPageMyDesign,
    BlankPageMessage,//消息
    BlankPageFavorite,//收藏
    BlankPageCommdity,
    BlankPageCoupon,//优惠券
    BlankPageEvaluation,//我的评价
    BlankPageEva,//评价
    BlankPageType_NoButton,
    BlankPageComment,
    BlankPageReceiveAddress,
    BlankPageMessage1,
    NoDataShow
};
typedef NS_ENUM(NSInteger, BadgePositionType) {
    
    BadgePositionTypeDefault = 0,
    BadgePositionTypeMiddle
};
@interface UIView(Common)
@property (nonatomic) IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable BOOL masksToBounds;

-(void)showInfica;
-(void)hideInfica;

-(CAShapeLayer*)dotted;
//初次加载时使用
- (void)showHudInView:(UIView *)view hint:(NSString *)hint;

- (void)hideHud;
- (void)showHint;
- (void)showHintInView:(UIView*)v;
- (void)showHint:(NSString *)hint;

- (void)showHint:(NSString *)hint yOffset:(float)yOffset;
-(void)alertView:(NSString*)title prompt:(NSString *)prompt  withBlock:(MMPopupItemHandler)handler;
- (void)alertView:(NSString *)title contentArray:(NSArray *)array withBlock:(MMPopupItemHandler1)handler;

-(void)alertView:(NSString*)title  withBlock:(MMPopupItemHandler)handler;
-(void)alertView:(NSString*)title  prompt:(NSString *)prompt  items:(NSArray*)items;
-(void)alertNoBackView:(NSString*)title  withBlock:(MMPopupItemHandler)handler;

-(void)callPhoneAlertView:(NSString*)title prompt:(NSString *)prompt  withBlock:(MMPopupItemHandler)handler;

- (void)doCircleFrame;
- (void)doNotCircleFrame;
- (void)doBorderWidth:(CGFloat)width color:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;

- (UIViewController *)findViewController;
- (void)addBadgeTip:(NSString *)badgeValue withCenterPosition:(CGPoint)center;
- (void)addBadgeTip:(NSString *)badgeValue;
- (void)addBadgePoint:(NSInteger)pointRadius withPosition:(BadgePositionType)type;
- (void)addBadgePoint:(NSInteger)pointRadius withPointPosition:(CGPoint)point;
- (void)removeBadgePoint;
- (void)removeBadgeTips;

- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown;
- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color;
- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace;

- (void)setSubScrollsToTop:(BOOL)scrollsToTop;

+ (CGRect)frameWithOutNav;
+ (UIViewAnimationOptions)animationOptionsForCurve:(UIViewAnimationCurve)curve;
+ (UIView *)lineViewWithPointYY:(CGFloat)pointY;
+ (UIView *)lineViewWithPointYY:(CGFloat)pointY andColor:(UIColor *)color;
+ (UIView *)lineViewWithPointYY:(CGFloat)pointY andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace;
+ (void)outputTreeInView:(UIView *)view withSeparatorCount:(NSInteger)count;

#pragma  加载动画
@property (strong, nonatomic) LoadingView *loadingView;
@property(strong,nonatomic)UIView *loadingBackView;
- (void)beginLoading;
- (void)beginLoadingWithBack;
- (void)endLoading;

#pragma mark BlankPageView
@property (strong, nonatomic) BlankPageView *blankPageView;
- (void)configBlankPage:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block;
@end

@interface LoadingView : UIView
@property (strong, nonatomic) UIImageView *loopView, *monkeyView;
@property (assign, nonatomic, readonly) BOOL isLoading;
- (void)startAnimating;
- (void)stopAnimating;
@end

@interface BlankPageView : UIView
@property (strong, nonatomic) UIImageView *monkeyView;
@property (strong, nonatomic) UILabel *tipLabel;
@property (strong, nonatomic) UIButton *reloadButton;
@property (assign, nonatomic) EaseBlankPageType curType;
@property (copy, nonatomic) void(^reloadButtonBlock)(id sender);
@property (copy, nonatomic) void(^loadAndShowStatusBlock)();
@property (copy, nonatomic) void(^clickButtonBlock)(EaseBlankPageType curType);
- (void)configWithType:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block;
@end
