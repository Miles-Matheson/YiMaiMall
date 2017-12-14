//
//  UIView+Common.m
//  ylb
//
//  Created by gravel on 16/3/15.
//  Copyright © 2016年 gravel. All rights reserved.
//

#import "UIView+Common.h"
#import "UIBadgeView.h"
#define kTagBadgeView  1000
#define kTagBadgePointView  1001
#define kTagLineView 1007
#import <objc/runtime.h>
#import "MMPopupItem.h"
#import "MMAlertView.h"
#import "AmotButton.h"
#import <QuartzCore/QuartzCore.h>

static const void *HttpRequestHUDKey = &HttpRequestHUDKey;
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@implementation UIView(Common)
static char LoadingViewKey,LoadingBackViewKey, BlankPageViewKey;
@dynamic borderColor,borderWidth,cornerRadius, masksToBounds;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)showInfica{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
-(void)hideInfica{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(CAShapeLayer*)dotted{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:self.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    // 设置虚线颜色为black
    [shapeLayer setStrokeColor:[[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0f] CGColor]];
    // 3.0f设置虚线的宽度
    [shapeLayer setLineJoin:kCALineJoinRound];
    // 3=线的宽度 1=每条线的间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:4],[NSNumber numberWithInt:2],nil]];
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 1, 1);       //100 ,67 初始点 x,y
    CGPathAddLineToPoint(path, NULL, self.width,self.height);     //67终点x,y
    [shapeLayer setPath:path];
    CGPathRelease(path);
    return shapeLayer;
}
- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showHudInView:(UIView *)view hint:(NSString *)hint{
    [self showInfica];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.labelColor=[UIColor whiteColor];
    HUD.labelText = hint;
//
    HUD.labelFont=[UIFont systemFontOfSize:12.0];
    HUD.color=kAppThemeColor;
    [view addSubview:HUD];
    [HUD show:YES];
    [self setHUD:HUD];
}
- (void)showHint{
    UIView *view = [[UIApplication sharedApplication].delegate window];
    [self showHudInView:view hint:[@"loading" globalLanguage]];
}
- (void)showHintInView:(UIView*)v{
    [self showHudInView:v hint:[@"loading" globalLanguage]];
}

- (void)showHint:(NSString *)hint
{
    
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *HUD = (MBProgressHUD *)[MBProgressHUD showHUDAddedTo:view animated:YES];

    HUD.mode = MBProgressHUDModeText;
    HUD.userInteractionEnabled = NO;
    // Configure for text only and offset down

    HUD.label.text = hint;
    HUD.margin = 10.f;
    HUD.yOffset = IS_IPHONE_5?200.f:150.f;
    HUD.removeFromSuperViewOnHide = YES;
    [HUD hide:YES afterDelay:2];
}

- (void)showHint:(NSString *)hint yOffset:(float)yOffset {
    
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
    hud.margin = 10.f;
    
    hud.yOffset =IS_IPHONE_5?200.f:150.f;
    
    hud.yOffset += yOffset;

    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
}

- (void)hideHud   {
    [self hideInfica];
    [[self HUD] hideAnimated:YES];
}



-(void)setBorderColor:(UIColor *)borderColor{
    [self.layer setBorderColor:borderColor.CGColor];
}

-(void)setBorderWidth:(CGFloat)borderWidth{
    [self.layer setBorderWidth:borderWidth];
}

-(void)setCornerRadius:(CGFloat)cornerRadius{
    [self.layer setCornerRadius:cornerRadius];
}

- (void)setMasksToBounds:(BOOL)masksToBounds{
    [self.layer setMasksToBounds:masksToBounds];
}

-(void)alertView:(NSString*)title withBlock:(MMPopupItemHandler)handler{
    NSArray *items =
    @[MMItemMake([@"cancel" globalLanguage], MMItemTypeHighlight, handler),
      MMItemMake([@"ok" globalLanguage], MMItemTypeHighlight, handler)];
    [self alertView:title prompt:[@"prompt" globalLanguage] items:items];
    
}

-(void)callPhoneAlertView:(NSString*)title prompt:(NSString *)prompt  withBlock:(MMPopupItemHandler)handler{
    
    NSArray *items =
    @[MMItemMake(@"取消", MMItemTypeHighlight, handler),
      MMItemMake(@"拨号", MMItemTypeHighlight, handler)];
    [self alertView:title prompt:prompt items:items];
    
}


-(void)alertView:(NSString*)title prompt:(NSString *)prompt  withBlock:(MMPopupItemHandler)handler{
    NSArray *items =
    @[MMItemMake([@"取消" globalLanguage], MMItemTypeHighlight, handler),
      MMItemMake([@"确定" globalLanguage], MMItemTypeHighlight, handler)];
    [self alertView:title prompt:prompt items:items];
}

- (void)alertView:(NSString *)title contentArray:(NSArray *)array withBlock :(MMPopupItemHandler1)handler{
    NSArray *items =
    @[MMItemMake1([@"back" globalLanguage], MMItemTypeNormal, handler),
      MMItemMake1([@"pay now" globalLanguage], MMItemTypeHighlight, handler)];
    MMAlertView * alertView = [[MMAlertView alloc] initWithTitle:title contentArray:array items:items];
    [alertView show];
}

-(void)alertView:(NSString*)title  prompt:(NSString *)prompt  items:(NSArray*)items {
   
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:prompt
                                                         detail:title
                                                          items:items];
    [alertView show];
}

-(void)alertNoBackView:(NSString*)title  withBlock:(MMPopupItemHandler)handler{
    NSArray *items =
    @[
      MMItemMake([@"ok" globalLanguage], MMItemTypeHighlight, handler)];
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:[@"prompt" globalLanguage]
                                                         detail:title
                                                          items:items];
    
    [alertView show];
}

- (void)doCircleFrame{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.frame.size.width/2;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor clearColor].CGColor;
}
- (void)doNotCircleFrame{
    self.layer.cornerRadius = 0.0;
    self.layer.borderWidth = 0.0;
}

- (void)doBorderWidth:(CGFloat)width color:(UIColor *)color cornerRadius:(CGFloat)cornerRadius{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = width;
    if (!color) {
        self.layer.borderColor = [LLUtils colorWithHex:@"0xdddddd"].CGColor;
    }else{
        self.layer.borderColor = color.CGColor;
    }
}

- (UIViewController *)findViewController
{
    for (UIView* next = self; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (void)addBadgePoint:(NSInteger)pointRadius withPosition:(BadgePositionType)type {
    
    if(pointRadius < 1)
        return;
    
    [self removeBadgePoint];
    
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = kTagBadgePointView;
    badgeView.layer.cornerRadius = pointRadius;
    badgeView.backgroundColor = [UIColor redColor];
    
    switch (type) {
            
        case BadgePositionTypeMiddle:
            badgeView.frame = CGRectMake(0, self.frame.size.height / 2 - pointRadius, 2 * pointRadius, 2 * pointRadius);
            break;
            
        default:
            badgeView.frame = CGRectMake(self.frame.size.width - 2 * pointRadius, 0, 2 * pointRadius, 2 * pointRadius);
            break;
    }
    
    [self addSubview:badgeView];
}

- (void)addBadgePoint:(NSInteger)pointRadius withPointPosition:(CGPoint)point {
    
    if(pointRadius < 1)
        return;
    
    [self removeBadgePoint];
    
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = kTagBadgePointView;
    badgeView.layer.cornerRadius = pointRadius;
    badgeView.backgroundColor = [LLUtils colorWithHex:@"0xf75388"];
    badgeView.frame = CGRectMake(0, 0, 2 * pointRadius, 2 * pointRadius);
    badgeView.center = point;
    [self addSubview:badgeView];
}

- (void)removeBadgePoint {
    
    for (UIView *subView in self.subviews) {
        
        if(subView.tag == kTagBadgePointView)
            [subView removeFromSuperview];
    }
}

- (void)addBadgeTip:(NSString *)badgeValue withCenterPosition:(CGPoint)center{
    if (!badgeValue || !badgeValue.length) {
        [self removeBadgeTips];
    }else{
        UIView *badgeV = [self viewWithTag:kTagBadgeView];
        if (badgeV && [badgeV isKindOfClass:[UIBadgeView class]]) {
            [(UIBadgeView *)badgeV setBadgeValue:badgeValue];
            badgeV.hidden = NO;
        }else{
            badgeV = [UIBadgeView viewWithBadgeTip:badgeValue];
            badgeV.tag = kTagBadgeView;
            [self addSubview:badgeV];
        }
        [badgeV setCenter:center];
    }
}
- (void)addBadgeTip:(NSString *)badgeValue{
    if (!badgeValue || !badgeValue.length) {
        [self removeBadgeTips];
    }else{
        UIView *badgeV = [self viewWithTag:kTagBadgeView];
        if (badgeV && [badgeV isKindOfClass:[UIBadgeView class]]) {
            [(UIBadgeView *)badgeV setBadgeValue:badgeValue];
        }else{
            badgeV = [UIBadgeView viewWithBadgeTip:badgeValue];
            badgeV.tag = kTagBadgeView;
            [self addSubview:badgeV];
        }
        CGSize badgeSize = badgeV.frame.size;
        CGSize selfSize = self.frame.size;
        CGFloat offset = 2.0;
        [badgeV setCenter:CGPointMake(selfSize.width- (offset+badgeSize.width/2),
                                      (offset +badgeSize.height/2))];
    }
}
- (void)removeBadgeTips{
    NSArray *subViews =[self subviews];
    if (subViews && [subViews count] > 0) {
        for (UIView *aView in subViews) {
            if (aView.tag == kTagBadgeView && [aView isKindOfClass:[UIBadgeView class]]) {
                aView.hidden = YES;
            }
        }
    }
}
- (void)setSubScrollsToTop:(BOOL)scrollsToTop{
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)obj setScrollEnabled:scrollsToTop];
            *stop = YES;
        }
    }];
}

- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown{
    [self addLineUp:hasUp andDown:hasDown andColor:[LLUtils colorWithHex:@"0xc8c7cc"]];
}

- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color{
    [self removeViewWithTag:kTagLineView];
    if (hasUp) {
        UIView *upView = [UIView lineViewWithPointYY:0 andColor:color];
        upView.tag = kTagLineView;
        [self addSubview:upView];
    }
    if (hasDown) {
        UIView *downView = [UIView lineViewWithPointYY:CGRectGetMaxY(self.bounds)-0.5 andColor:color];
        downView.tag = kTagLineView;
        [self addSubview:downView];
    }
    return [self addLineUp:hasUp andDown:hasDown andColor:color andLeftSpace:0];
}
- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace{
    [self removeViewWithTag:kTagLineView];
    if (hasUp) {
        UIView *upView = [UIView lineViewWithPointYY:0 andColor:color andLeftSpace:leftSpace];
        upView.tag = kTagLineView;
        [self addSubview:upView];
    }
    if (hasDown) {
        UIView *downView = [UIView lineViewWithPointYY:CGRectGetMaxY(self.bounds)-0.5 andColor:color andLeftSpace:leftSpace];
        downView.tag = kTagLineView;
        [self addSubview:downView];
    }
}
- (void)removeViewWithTag:(NSInteger)tag{
    for (UIView *aView in [self subviews]) {
        if (aView.tag == tag) {
            [aView removeFromSuperview];
        }
    }
}

+ (CGRect)frameWithOutNav{
    CGRect frame = KeyWindow.bounds;
    frame.size.height -= (20+44);//减去状态栏、导航栏的高度
    return frame;
}

+ (UIViewAnimationOptions)animationOptionsForCurve:(UIViewAnimationCurve)curve
{
    switch (curve) {
        case UIViewAnimationCurveEaseInOut:
            return UIViewAnimationOptionCurveEaseInOut;
            break;
        case UIViewAnimationCurveEaseIn:
            return UIViewAnimationOptionCurveEaseIn;
            break;
        case UIViewAnimationCurveEaseOut:
            return UIViewAnimationOptionCurveEaseOut;
            break;
        case UIViewAnimationCurveLinear:
            return UIViewAnimationOptionCurveLinear;
            break;
    }
    
    return kNilOptions;
}

+ (UIView *)lineViewWithPointYY:(CGFloat)pointY{
    return [self lineViewWithPointYY:pointY andColor: [LLUtils colorWithHex:@"0xc8c7cc"]];
}

+ (UIView *)lineViewWithPointYY:(CGFloat)pointY andColor:(UIColor *)color{
    return [self lineViewWithPointYY:pointY andColor:color andLeftSpace:0];
}

+ (UIView *)lineViewWithPointYY:(CGFloat)pointY andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(leftSpace, pointY, SCREEN_WIDTH - leftSpace, 0.5)];
    lineView.backgroundColor = color;
    return lineView;
}

+ (void)outputTreeInView:(UIView *)view withSeparatorCount:(NSInteger)count{
    NSString *outputStr = @"";
    outputStr = [outputStr stringByReplacingCharactersInRange:NSMakeRange(0, count) withString:@"-"];
    outputStr = [outputStr stringByAppendingString:view.description];
    printf("%s\n", outputStr.UTF8String);
    
    if (view.subviews.count == 0) {
        return;
    }else{
        count++;
        for (UIView *subV in view.subviews) {
            [self outputTreeInView:subV withSeparatorCount:count];
        }
    }
}


#pragma mark LoadingView
- (void)setLoadingView:(LoadingView *)loadingView{
    [self willChangeValueForKey:@"LoadingViewKey"];
    objc_setAssociatedObject(self, &LoadingViewKey,
                             loadingView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"LoadingViewKey"];
}
- (LoadingView *)loadingView{
    return objc_getAssociatedObject(self, &LoadingViewKey);
}
-(UIView*)loadingBackView{
    return objc_getAssociatedObject(self, &LoadingBackViewKey);
}
- (void)setLoadingBackView:(UIView *)loadingBackView{
    [self willChangeValueForKey:@"LoadingBackViewKey"];
    objc_setAssociatedObject(self, &LoadingBackViewKey,
                             loadingBackView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"LoadingViewKey"];
}
-(void)beginLoadingWithBack{
    
    for (UIView *aView in [self.blankPageContainer subviews]) {
        if ([aView isKindOfClass:[BlankPageView class]] && !aView.hidden) {
            return;
        }
    }
    if (!self.loadingBackView) { //初始化LoadingView
        self.loadingBackView = [[UIView alloc] initWithFrame:self.bounds];
        self.loadingBackView.backgroundColor=[UIColor colorWithWhite:0.000 alpha:0.295];
    }
    
    self.loadingBackView.hidden=NO;
    [self addSubview:self.loadingBackView];
    [self.loadingBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.self.edges.equalTo(self);
    }];
    if (!self.loadingView) { //初始化LoadingView
        self.loadingView = [[LoadingView alloc] initWithFrame:self.bounds];
    }
    [self addSubview:self.loadingView];
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.self.edges.equalTo(self);
    }];
    [self.loadingView startAnimating];
}

- (void)beginLoading{
    for (UIView *aView in [self.blankPageContainer subviews]) {
        if ([aView isKindOfClass:[BlankPageView class]] && !aView.hidden) {
            return;
        }
    }
    
    if (!self.loadingView) { //初始化LoadingView
        self.loadingView = [[LoadingView alloc] initWithFrame:self.bounds];
    }
    [self addSubview:self.loadingView];
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.self.edges.equalTo(self);
    }];
    [self.loadingView startAnimating];
}

- (void)endLoading{
    if (self.loadingView) {
        [self.loadingView stopAnimating];
    }
    if(self.loadingBackView){
        self.loadingBackView.hidden=YES;
    }
}

#pragma mark BlankPageView
- (void)setBlankPageView:(BlankPageView *)blankPageView{
    [self willChangeValueForKey:@"BlankPageViewKey"];
    objc_setAssociatedObject(self, &BlankPageViewKey,
                             blankPageView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"BlankPageViewKey"];
}

- (BlankPageView *)blankPageView{
    return objc_getAssociatedObject(self, &BlankPageViewKey);
}

- (void)configBlankPage:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void (^)(id))block{
    if (hasData) {
        if (self.blankPageView) {
            self.blankPageView.hidden = YES;
            [self.blankPageView removeFromSuperview];
        }
    }else{
        if (!self.blankPageView) {
            self.blankPageView = [[BlankPageView alloc] initWithFrame:self.bounds];
        }
        self.blankPageView.hidden = NO;
        [self.blankPageContainer addSubview:self.blankPageView];
        
        //        [self.blankPageContainer insertSubview:self.blankPageView atIndex:0];
        //        [self.blankPageView mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.size.equalTo(self);
        //            make.top.left.equalTo(self.blankPageContainer);
        //        }];
        [self.blankPageView configWithType:blankPageType hasData:hasData hasError:hasError reloadButtonBlock:block];
    }
}
- (UIView *)blankPageContainer{
    UIView *blankPageContainer = self;
    for (UIView *aView in [self subviews]) {
        if ([aView isKindOfClass:[UITableView class]]) {
            blankPageContainer = aView;
        }
    }
    return blankPageContainer;
}

@end

@interface LoadingView ()
@property (nonatomic, assign) CGFloat loopAngle, monkeyAlpha, angleStep, alphaStep;
@end

@implementation LoadingView

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //self.backgroundColor = kAppThemeColor;
        _loopView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_loop"]];
        _monkeyView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_logo"]];
        [_loopView setCenter:self.center];
        [_monkeyView setCenter:self.center];
        [self addSubview:_loopView];
        [self addSubview:_monkeyView];
        [_loopView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        [_monkeyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        
        _loopAngle = 0.0;
        _monkeyAlpha = 1.0;
        _angleStep = 360/3;
        _alphaStep = 1.0/3.0;
    }
    return self;
}

- (void)startAnimating{
    self.hidden = NO;
    if (_isLoading) {
        return;
    }
    _isLoading = YES;
    [self loadingAnimation];
}

- (void)stopAnimating{
    self.hidden = YES;
    _isLoading = NO;
}

- (void)loadingAnimation{
    static CGFloat duration = 0.25f;
    _loopAngle += _angleStep;
    if (_monkeyAlpha >= 1.0 || _monkeyAlpha <= 0.0) {
        _alphaStep = -_alphaStep;
    }
    _monkeyAlpha += _alphaStep;
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        CGAffineTransform loopAngleTransform = CGAffineTransformMakeRotation(_loopAngle * (M_PI / 180.0f));
        _loopView.transform = loopAngleTransform;
        _monkeyView.alpha = _monkeyAlpha;
    } completion:^(BOOL finished) {
        if (_isLoading && [self superview] != nil) {
            [self loadingAnimation];
        }else{
            [self removeFromSuperview];
            
            _loopAngle = 0.0;
            _monkeyAlpha = 1,0;
            _alphaStep = ABS(_alphaStep);
            CGAffineTransform loopAngleTransform = CGAffineTransformMakeRotation(_loopAngle * (M_PI / 180.0f));
            _loopView.transform = loopAngleTransform;
            _monkeyView.alpha = _monkeyAlpha;
        }
    }];
}

@end

@implementation BlankPageView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)configWithType:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void (^)(id))block{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_loadAndShowStatusBlock) {
            _loadAndShowStatusBlock();
        }
    });
    
    
    if (hasData) {
        [self removeFromSuperview];
        return;
    }
    self.alpha = 1.0;
    //    图片
    if (!_monkeyView) {
        _monkeyView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_monkeyView];
    }
    //    文字
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.numberOfLines = 0;
        _tipLabel.font = [UIFont systemFontOfSize:15];
        _tipLabel.textColor = [UIColor lightGrayColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_tipLabel];
    }
    
    //    布局
    [_monkeyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_centerY);
    }];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.centerX.equalTo(self);
        make.top.equalTo(_monkeyView.mas_bottom);
        make.height.mas_equalTo(50);
    }];
    
    _reloadButtonBlock = nil;
    if (hasError) {
        //        加载失败
        if (!_reloadButton) {
            _reloadButton = [[UIButton alloc] initWithFrame:CGRectZero];
            [_reloadButton setImage:[UIImage imageNamed:@"blankpage_button_reload"] forState:UIControlStateNormal];
            _reloadButton.adjustsImageWhenHighlighted = YES;
            [_reloadButton addTarget:self action:@selector(reloadButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_reloadButton];
            [_reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.top.equalTo(_tipLabel.mas_bottom);
                make.size.mas_equalTo(CGSizeMake(160, 60));
            }];
        }
        _reloadButton.hidden = NO;
        _reloadButtonBlock = block;
        [_monkeyView setImage:[UIImage imageNamed:@"blankpage_image_loadFail"]];
        _tipLabel.text = @"貌似出了点差错\n真忧伤呢";
    }else{
        //        空白数据
        if (_reloadButton) {
            _reloadButton.hidden = YES;
        }
        
        NSString *imageName, *tipStr;
        _curType=blankPageType;
        switch (blankPageType) {
            case BlankPageBalanceDetail:
            {
                imageName = @"blankpage_image_Sleep";
                tipStr = @"暂无商品数据~";
            }
                break;
                
//            case NoDataShow:
//            {
//                imageName = @"blankpage_image_Sleep";
//                tipStr = @"您还没有余额详情哦~";
//            }
//                break;
                
                case BlankPageEvaluation:
            {
                imageName = @"blankpage_image_Sleep";
                tipStr = @"您还没有评价哦~";
            }
                break;
            case BlankPageEva:
            {
                imageName = @"blankpage_image_Sleep";
                tipStr = @"还没有评价哦~";
            }
                break;
                case BlankPageFavorite:
            {
                imageName = @"blankpage_image_Sleep";
                tipStr = @"您还没有收藏哦~";
            }
                break;
            case BlankPageMyDesign:
            {
                imageName = @"blankpage_image_Sleep";
                tipStr = @"您还没有设计";
            }
                break;
            case BlankPageCoupon:
            {
                imageName = @"blankpage_image_Sleep";
                tipStr = @"您还没有优惠劵哦~";
            }
                break;
                case BlankPageShopCar:
            {
                imageName = @"blankpage_image_Sleep";
                tipStr = @"购物车没有商品哦~";
            }
                break;
            case BlankPageMessage1:
            {
                imageName = @"blankpage_image_Sleep";
                tipStr = @"您还没有消息哦!";
            }
                break;
           
            case BlankPageReceiveAddress:{
                imageName = @"blankpage_image_address";
                tipStr = @"暂无收获地址";
            }
                break;
            case BlankPageActivity://
            {
                imageName = @"blankpage_image_Sleep";
                tipStr = @"管理员很懒\n一条数据都没有";
            }
                break;
            case BlankPageTreat://
            {
                imageName = @"blankpage_image_Sleep";
                tipStr = @"管理员很懒\n一篇规范诊疗都没有";
                break;
            }case BlankPageComment:{
                imageName=@"blankpage_image_Sleep";
                tipStr = @"还没有评论,快来添加评论吧";
                break;
            }case BlackPageOrderReport:{
                imageName=@"blankpage_image_Sleep";
                tipStr = @"该分类暂无药品,快试试其它分类吧";
                break;
            }case BlankPageMyOrder:{
                imageName=@"blankpage_image_Sleep";
                tipStr = @"您还没有订单哦";
                break;
            }case BlankPageMessage:
            {
                imageName=@"blankpage_image_Sleep";
                tipStr = @"您还没有消息哦";
                break;
            }case BlackPageFeedback:{
                imageName=@"blankpage_image_Sleep";
                tipStr = @"您还没有反馈哦！";
                break;
            }case BlackPageBounds:{
                imageName=@"blankpage_image_Sleep";
                tipStr = @"您还没有医米记录哦！";
                break;
            }case BlankPageCommdity:{
              //  imageName=@"blankpage_image_Sleep";
                tipStr = @"管理员很懒\n一个商品都没有！";
                break;
            }
                
                
                
                break;
//                break;
//            case EaseBlankPageTypeTopic://讨论列表
//            {
//                imageName = @"blankpage_image_Sleep";
//                tipStr = @"这里怎么空空的\n发个讨论让它热闹点吧";
//            }
//                break;
//            case EaseBlankPageTypeTweet://冒泡列表（自己的）
//            {
//                imageName = @"blankpage_image_Hi";
//                tipStr = @"来，冒个泡吧～";
//            }
//                break;
//            case EaseBlankPageTypeTweetOther://冒泡列表（别人的）
//            {
//                imageName = @"blankpage_image_Sleep";
//                tipStr = @"这个人很懒\n一个冒泡都木有～";
//            }
//                break;
//            case EaseBlankPageTypeProject://项目列表（自己的）
//            {
//                imageName = @"blankpage_image_Sleep";
//                tipStr = @"您还木有项目呢，赶快起来创建吧～";
//            }
//                break;
//            case EaseBlankPageTypeProjectOther://项目列表（别人的）
//            {
//                imageName = @"blankpage_image_Sleep";
//                tipStr = @"这个人很懒，一个项目都木有～";
//            }
//                break;
//            case EaseBlankPageTypeFileDleted://去了文件页面，发现文件已经被删除了
//            {
//                imageName = @"blankpage_image_loadFail";
//                tipStr = @"晚了一步\n文件刚刚被人删除了～";
//            }
//                break;
//            case EaseBlankPageTypeFolderDleted://文件夹
//            {
//                imageName = @"blankpage_image_loadFail";
//                tipStr = @"晚了一步\n文件夹貌似被人删除了～";
//            }
//                break;
//            case EaseBlankPageTypePrivateMsg://私信列表
//            {
//                imageName = @"blankpage_image_Hi";
//                tipStr = @"打个招呼吧～";
//            }
//                break;
//            case EaseBlankPageTypeMyJoinedTopic://我参与的话题
//            case EaseBlankPageTypeMyWatchedTopic://我关注的话题
//            {
//                imageName = @"blankpage_image_Sleep";
//                tipStr = @"您还没有话题呢～";
//            }
//                break;
//            case EaseBlankPageTypeOthersJoinedTopic://ta参与的话题
//            case EaseBlankPageTypeOthersWatchedTopic://ta关注的话题
//            {
//                imageName = @"blankpage_image_Sleep";
//                tipStr = @"这个人很懒，一个话题都木有～";
//            }
//                break;
//            case EaseBlankPageTypeFileTypeCannotSupport:
//            {
//                imageName = @"blankpage_image_loadFail";
//                tipStr = @"不支持这种类型的文件\n试试右上角的按钮，用其他应用打开吧";
//            }
//                break;
//            case EaseBlankPageTypeViewTips:
//            {
//                imageName = @"blankpage_image_Sleep";
//                tipStr = @"这里没有未读的消息";
//            }
//                break;
//            case EaseBlankPageTypeShopOrders:
//            {
//                imageName = @"blankpage_image_Sleep";
//                tipStr = @"您还木有订单呢\n努力推代码，把洋葱猴带回家～";
//            }
//                break;
//            case EaseBlankPageTypeShopSendOrders:
//            {
//                imageName = @"blankpage_image_Sleep";
//                tipStr = @"您还木有已发货的订单呢～";
//            }
//                break;
//            case EaseBlankPageTypeShopUnSendOrders:
//            {
//                imageName = @"blankpage_image_Sleep";
//                tipStr = @"您还木有未发货的订单呢～";
//            }
//                break;
//            case EaseBlankPageTypeNoExchangeGoods:{
//                imageName = @"blankpage_image_Sleep";
//                tipStr = @"还木有可兑换的商品呢\n努力推代码，把洋葱猴带回家～";
//            }
//                break;
//            case EaseBlankPageTypeProject_ALL:{
//                imageName = @"blankpage_image_Sleep";
//                tipStr = @"您还木有项目呢，赶快起来创建吧～";
//            }
//                break;
//            case EaseBlankPageTypeProject_CREATE:{
//                imageName = @"blankpage_image_Sleep";
//                tipStr = @"您还木有项目呢，赶快起来创建吧～";
//            }
//                break;
//            case EaseBlankPageTypeProject_JOIN:{
//                imageName = @"blankpage_image_Sleep";
//                tipStr = @"您还木有项目呢，赶快起来创建吧～";
//            }
//                break;
//            case EaseBlankPageTypeProject_WATCHED:{
//                imageName = @"blankpage_image_Sleep";
//                tipStr = @"您还木有项目呢，赶快起来创建吧～";
//            }
//                break;
//            case EaseBlankPageTypeProject_STARED:{
//                imageName = @"blankpage_image_Sleep";
//                tipStr = @"您还木有项目呢，赶快起来创建吧～";
//            }
//                break;
//            case EaseBlankPageTypeProject_SEARCH:{
//                imageName = @"blankpage_image_Sleep";
//                tipStr = @"什么都木有搜到，换个词再试试？";
//            }
//                break;
//            default://其它页面（这里没有提到的页面，都属于其它）
//            {
//                imageName = @"blankpage_image_Sleep";
//                tipStr = @"这里还什么都没有\n赶快起来弄出一点动静吧";
//            }
                break;
        }
        [_monkeyView setImage:[UIImage imageNamed:imageName]];
        _tipLabel.text = tipStr;
        
        if ((blankPageType>BlankPageType_NoButton)) {
            [_monkeyView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.bottom.equalTo(self.mas_centerY).offset(-35);
            }];
            
            //新增按钮
            AmotButton *actionBtn=({
                AmotButton *button=[AmotButton new];
                button.backgroundColor=kAppThemeColor;
                button.titleLabel.font=[UIFont systemFontOfSize:15];
                
                [button addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
                button.layer.cornerRadius=18;
                button.layer.masksToBounds=TRUE;
                button;
                
            });
            [self addSubview:actionBtn];
            
            [actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(125 , 36));
                make.top.equalTo(_tipLabel.mas_bottom).offset(15);
                make.centerX.equalTo(self);
            }];
            
            NSString *titleStr;
            switch (blankPageType) {
                case BlankPageComment:
                    titleStr=@"+ 评论";
                    //                    [actionBtn setTitle:@"+ 创建项目" forState:UIControlStateNormal];
                    break;
                case BlankPageReceiveAddress:
                    titleStr = @"＋添加收货地址";
                    break;
                case BlankPageMessage1:
                    titleStr = @"刷新";
                    break;
                    
                default:
                    break;
            }
            //            NSMutableAttributedString *titleFontStr=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"+ %@",titleStr]];
            //            NSRange range;
            //            range.location=0;
            //            range.length=1;
            //            [titleFontStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:range];
            //            [actionBtn setAttributedTitle:titleFontStr forState:UIControlStateNormal];
            
            [actionBtn setTitle:titleStr forState:UIControlStateNormal];
            
        }
    }
}

- (void)reloadButtonClicked:(id)sender{
    self.hidden = YES;
    [self removeFromSuperview];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_reloadButtonBlock) {
            _reloadButtonBlock(sender);
        }
    });
}

-(void)btnAction{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_clickButtonBlock) {
            _clickButtonBlock(_curType);
        }
    });
}

@end
