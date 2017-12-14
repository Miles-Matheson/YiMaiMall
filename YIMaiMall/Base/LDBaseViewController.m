//
//  LDBaseViewController.m
//  StairOrder
//
//  Created by Miles on 2017/8/14.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDBaseViewController.h"
#import "LDBaseNavigationController.h"
#import "UIScrollView+EmptyDataSet.h"
#import "CustomPopView.h"
#import "PayOrderViewController.h"



@interface LDBaseViewController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

{
    BOOL shouldShowEmptyData;
}
@end

@implementation LDBaseViewController

-(void)setATableView:(UITableView *)aTableView
{
    _aTableView = aTableView;
    _aTableView.emptyDataSetSource = self;
    _aTableView.emptyDataSetDelegate = self;
//    _aTableView.tableFooterView = [UIView new];
    
    _aTableView.estimatedSectionHeaderHeight = 0;
    _aTableView.estimatedSectionFooterHeight = 0;
    
    if (@available(iOS 11.0, *)) {
//        _aTableView.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
    } else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

-(void)setACollectionView:(UICollectionView *)aCollectionView
{
    _aCollectionView = aCollectionView;
    _aCollectionView.emptyDataSetSource = self;
    _aCollectionView.emptyDataSetDelegate = self;
    if (@available(iOS 11.0, *)) {
//        _aCollectionView.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
    } else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

//Data Source 实现方法
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if (_NoMoreDataType == NoMoreDataTypeDefult ) {
        return [UIImage imageNamed:@"blankpage_image_Sleep"];
    }else if (_NoMoreDataType == NoMoreDataTypeNoLogin){
        return [UIImage imageNamed:@"blankpage_image_Hi"];
    }else if (_NoMoreDataType == NoMoreDataTypeNoShopCar){
        return [UIImage imageNamed:@"shopping"];
    }else if (_NoMoreDataType == NoMoreDataTypeNoSearch){
        return [UIImage imageNamed:@"no_pro"];
    }else if (_NoMoreDataType == NoMoreDataTypeNoMessage){
        
    }else if ( _NoMoreDataType == NoMoreDataTypeNoOrder){
        return [UIImage imageNamed:@"xiangguan"];
    }
    return nil;
}
//
//返回标题文字
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"";
    
    if (_NoMoreDataType == NoMoreDataTypeDefult ) {
        text = @"空空如也,什么也没有哦~";
    }else if (_NoMoreDataType == NoMoreDataTypeNoLogin){
//        text = @"亲登录后再来看看吧~";
    }else if (_NoMoreDataType == NoMoreDataTypeNoShopCar){
//        text = @"可以看看有哪些想买的";
    }else if (_NoMoreDataType == NoMoreDataTypeNoSearch){
//        text = @"抱歉!没有搜到相关产品";
    }else if (_NoMoreDataType == NoMoreDataTypeNoMessage){
        
    }else if (_NoMoreDataType == NoMoreDataTypeNoOrder){
         text = @"您还没有相关的订单";
    }

    NSDictionary *attributes = @{
                                 NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f],
                                 NSForegroundColorAttributeName: RGB(74, 74, 74),
                                 };
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
//
//返回文字详情
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSString *text =  @"";
    if (_NoMoreDataType == NoMoreDataTypeDefult ) {
        text = @"到别处看看吧";
    }else if (_NoMoreDataType == NoMoreDataTypeNoLogin){
        text = @"亲登录后再来看看吧~";
    }else if (_NoMoreDataType == NoMoreDataTypeNoShopCar){
        text = @"没有宝贝哦,不如去添加宝贝";
    }else if (_NoMoreDataType == NoMoreDataTypeNoSearch){
        text = @"抱歉!没有搜到相关产品";
    }else if (_NoMoreDataType == NoMoreDataTypeNoMessage){
         text = @"亲还没有消息哦";
    }else if (_NoMoreDataType == NoMoreDataTypeNoOrder){
        
    }
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{
                                 NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName:RGB(154, 164, 164),
                                 NSParagraphStyleAttributeName: paragraph
                                 };
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    
}

-(UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
{
    if (_NoMoreDataType == NoMoreDataTypeDefult ) {
        
    }else if (_NoMoreDataType == NoMoreDataTypeNoLogin){
       
    }else if (_NoMoreDataType == NoMoreDataTypeNoShopCar){
       
    }else if (_NoMoreDataType == NoMoreDataTypeNoSearch){
        
    }else if (_NoMoreDataType == NoMoreDataTypeNoMessage){
        
    }
    return nil;
}

//返回可以点击的按钮 上面带图片
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    
    if (_NoMoreDataType == NoMoreDataTypeDefult) {
        
    }else if (_NoMoreDataType == NoMoreDataTypeNoLogin){
        
    }else if (_NoMoreDataType == NoMoreDataTypeNoShopCar){
        
        return [UIImage imageNamed:@"btn_guang"];
        
    }else if (_NoMoreDataType == NoMoreDataTypeNoSearch){
        
    }else if (_NoMoreDataType == NoMoreDataTypeNoMessage){
        
    }else if (_NoMoreDataType == NoMoreDataTypeNoOrder){
        
    }
    return nil;
}

//返回空白区域的颜色 自定义
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIColor clearColor];
}

//    委托实现
//   要求知道空的状态应该渲染和显示 (Default is YES) :
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    if (!shouldShowEmptyData) {
        shouldShowEmptyData = YES;
        return NO;
    }else{
        return YES;
    }
}

// 是否允许点击 (默认是 YES) :
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView{
    
    return YES;
}

//是否允许滚动 (默认是 NO) :

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return NO;
}

//空白区域点击响应:
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView{ // Do something

}

//点击图片
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return 10.f;
}

/* Finally, you can separate components from each other (default separation is 11 pts): */
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    if (_NoMoreDataType == NoMoreDataTypeNoShopCar) {
        return 20;
    }
    return 0.1f;
}
// 点击button 响应

//刷新当前表格
- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView{ // Do something
    
    if (_NoMoreDataType == NoMoreDataTypeNoShopCar) {
        self.tabBarController.selectedIndex = 1;
    }else{
        if (scrollView == _aCollectionView) {
            [_aCollectionView reloadData];
        }else{
            [_aTableView reloadData];
        }
    }
}

-(UIImageView *)navBackgroundImageView
{
    if (!_navBackgroundImageView) {

        if (@available(iOS 11.0, *)) {
            _navBackgroundImageView = self.navigationController.navigationBar.subviews.firstObject.subviews.lastObject;
        }else{
           _navBackgroundImageView =  self.navigationController.navigationBar.subviews.firstObject;
        }
    }
    return _navBackgroundImageView;
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    NSLog(@"------------  %@   ------------",NSStringFromClass([self class]));
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    view.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:view];
    self.view.backgroundColor = RGB(239, 239, 239);
}

#pragma mark - 设置导航栏
- (void)setNavWithTitle:(NSString *)title isShowBack:(BOOL)isShowBack{
    if (isShowBack) {
        self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftBtn.frame = CGRectMake(0, 0, 15, 20);
        [self.leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [self.leftBtn addTarget:self action:@selector(clickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 2, 0, 2)];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftBtn];
    } else {
        self.navigationItem.leftBarButtonItem = nil;
    }
    self.title = title;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]};
}

-(void)setTitleTtextColor:(UIColor *)color
{
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:color==nil?[UIColor whiteColor]:color}];
}

- (void)setNavBgColor:(UIColor *)bgColor
{
    self.navigationController.navigationBar.barTintColor = bgColor;
    if (bgColor.CGColor == [UIColor whiteColor].CGColor) {
        [self setTitleTtextColor:[UIColor blackColor]];
//        self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    }else{
        [self setTitleTtextColor:[UIColor whiteColor]];
//        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    }
}

- (void)setTitleText:(NSString *)titleText textColor:(UIColor *)color
{
    if (_titleText != titleText) {
        _titleText = titleText;
        self.title = titleText;
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSForegroundColorAttributeName:color==nil?[UIColor whiteColor]:color}];
    }
}

- (void)setLeftText:(NSString *)leftText textColor:(UIColor *)color
            ImgPath:(NSString *)imgPath
{
    if (!leftText && !imgPath) {
        return;
    }
    
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtn.frame = CGRectMake(0, 0, 70, 30);
    _leftBtn.tag = 666;
    if (imgPath) {
        [_leftBtn setImage:[UIImage imageNamed:imgPath] forState:UIControlStateNormal];
    }
    if (leftText) {
        [_leftBtn setTitle:leftText forState:UIControlStateNormal];
        [_leftBtn setTitleColor:color==nil?[UIColor whiteColor]:color forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    if (leftText && imgPath) {
        UIImage *leftBtnImg = [UIImage imageNamed:imgPath];
        [_leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -leftBtnImg.size.width, 0, leftBtnImg.size.width)];
        [_leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 35, 0, -35)];
    }
    [_leftBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_leftBtn setContentEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
    
    [_leftBtn addTarget:self action:@selector(clickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

- (void)setRightText:(NSString *)rightText textColor:(UIColor *)color
             ImgPath:(NSString *)imgPath
{
    if (!rightText && !imgPath) {
        return;
    }
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = CGRectMake(0, 0, 70, 30);
    _rightBtn.tag = 888;
    if (imgPath) {
        [_rightBtn setImage:[UIImage imageNamed:imgPath] forState:UIControlStateNormal];
    }
    if (rightText) {
        [_rightBtn setTitle:rightText forState:UIControlStateNormal];
        [_rightBtn setTitleColor:color==nil?[UIColor whiteColor]:color forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    
    [_rightBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [_rightBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
    
    [_rightBtn addTarget:self action:@selector(clickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}
- (void)setLeftBtnLeftInset:(CGFloat)offset
{
    [_leftBtn setContentEdgeInsets:UIEdgeInsetsMake(0, -offset, 0, offset)];
    [_leftBtn setNeedsDisplay];
    [_leftBtn.layer displayIfNeeded];
}

- (void)setRightBtnLeftInset:(CGFloat)offset
{
    [_rightBtn setContentEdgeInsets:UIEdgeInsetsMake(0, -offset, 0, offset)];
    [_rightBtn setNeedsDisplay];
    [_rightBtn.layer displayIfNeeded];
}

#pragma mark - 导航栏点击方法
- (void)clickLeftBtn:(UIButton *)leftBtn;
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickRightBtn:(UIButton*)rightBtn;
{
}
-(void)clickSecondRightBtu:(UIButton* )secondRightBtu
{
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    // 如果app绝大多数页面要设置黑色样式，可以不写此方法，因为默认样式就是黑色的。
//     return UIStatusBarStyleDefault;
    // 白色样式
     return UIStatusBarStyleLightContent;
}


- (BOOL)isLogin
{
    NSString *token = [kUserDefault objectForKey:TOKEN];
    if (token.length >= 1) {
        return YES;
    }else{
        self.NoMoreDataType = NoMoreDataTypeNoLogin;
        return NO;
    }
}
- (void)login
{
//    if ([self isLogin]) {
//        return;
//    }

    LDBaseNavigationController *nav = [[LDBaseNavigationController alloc]initWithRootViewController:[[NSClassFromString(@"LDLoginRegisterController") alloc] init]];
    [self  presentViewController:nav animated:YES completion:nil];
}

-(void)logOutAccountCallBack:(void(^)(BOOL success))logoutAccountCallBack{
    ws(bself);
    if ( ![self isLogin]) {
        [self.view showCenterToast:@"亲还没有登录哦~"];
        return;
    }
    [LLUtils showAlterView:self title:@"提示" message:@"确定退出账号?" yesBtnTitle:@"确定" noBtnTitle:@"取消" yesBlock:^{
        
        [kUserDefault removeObjectForKey:TOKEN];
        
        [NSNotic_Center postNotificationName:LOGOUTSUCCESS object:nil];
        
        
        if ([kUserDefault synchronize]) {
            [bself.view showCenterToast:@"退出成功"];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            logoutAccountCallBack(YES);
        });
        
    } noBlock:^{
        logoutAccountCallBack(NO);
    }];
}

#pragma 弹出更多选择框
-(void)showMoreViewWithHandl:(UIView*)clickView InfoData:(NSArray <NSDictionary*>*)dataArray CallBack:(void(^)(NSInteger selectIndex))callBack{
    
    CustomPopView *popoverView = [[CustomPopView alloc]init];;
    popoverView.style = PopoverViewStyleDefault;
    popoverView.hideAfterTouchOutside = YES; // 点击外部时不允许隐藏
    NSMutableArray *actions = [NSMutableArray array];

    for (int i = 0; i < dataArray.count; i ++) {
        
        UIImage *image = [UIImage imageNamed:dataArray[i][@"image"]];
        NSString *title = dataArray[i][@"title"];
        CustomPopAction *action = [CustomPopAction actionWithImage:image?image:nil title:title?title:@"" handler:^(CustomPopAction *action) {
            callBack(i);
        }];
        [actions addObject:action];
    }
    [popoverView showToView:clickView withActions:actions];
}

-(void)getMessageWithMobile:(NSString *)mobile CallBack:(void(^)(BOOL success))callBack{
    ws(bself);
    [[APIManager sharedManager] getMsgCodeWithMobile:mobile CallBack:^(id data) {
        [bself.view showCenterToast:data[@"msg"]];
        if ([data[@"state"] integerValue] == 1) {
              callBack(YES);
        }else{
            callBack(NO);
        }
    } fail:^(NSString *errorString) {
    }];
}

-(void)dealloc
{
    NSLog(@"%@ 内存释放 -->%@",self.navigationItem.title ,NSStringFromClass([self class]));
    [NSNotic_Center removeObserver:self name:ADDGOODSCOUNT object:nil];
    [NSNotic_Center removeObserver:self name:ADDGOODS object:nil];
}

-(void)addGoodsToShopCartWithSkuIds:(NSString *)skuIds goodsIds:(NSString *)goodsId count:(NSInteger)count sizeInfo:(NSString *)sizeInfo CallBack:(void(^)(BOOL success,NSDictionary*data))callBack{

    NSDictionary *param = @{
                            @"goods_spec_ids":skuIds?skuIds:@"",//商品规格ids 按照id1_id2_的顺序  可为空
                            @"goods_id":goodsId?goodsId:@"",//添加购物车的商品id 不可为空
                            @"count":@(count),//添加购物车商品数量 不可为空
                            @"spec_info":sizeInfo?sizeInfo:@"",//  @"尺码:m,"
                            };
    [[APIManager sharedManager] addGoodsToShopCartWithData:param CallBack:^(id data) {
        BOOL  state = [data[@"state"] boolValue];
        callBack(state,data);
        if (state) {
            [[NSNotificationCenter defaultCenter] postNotificationName:ADDGOODS object:nil];
        }
    } fail:^(NSString *errorString) {
    }];
}

//@[@"取消订单",@"删除订单",@"付款",@"提醒发货",@"确认收货",@"查看物流",@"取消退货",@"再次退货",@"去评价"];
-(void)changeOrderStatusWithSelectIndexTag:(NSInteger)selectIndexTag model:(LDOrderModel *)model{
    ws(bself);
    if (selectIndexTag == 0) {//取消订单
        [LDAlterView alterViewWithTitle:@"提示" content:@"确定取消订单?" cancel:@"取消" sure:@"确定" cancelBtClcik:nil sureBtClcik:^{
            
            [[APIManager sharedManager] cancelOnlineOrderWithOrderID:model.ID CallBack:^(id data) {
                RC001;
                [bself silenceRefresh];
            } fail:^(NSString *errorString) {
                
            }];
            
        }];
    }else if (selectIndexTag == 1){//删除订单
        [LDAlterView alterViewWithTitle:@"提示" content:@"确定删除该订单?" cancel:@"取消" sure:@"确定" cancelBtClcik:nil sureBtClcik:^{
            
            [[APIManager sharedManager] deleteOrderWithOrderId:model.ID CallBack:^(id data) {
                
                RC001;
                [bself silenceRefresh];
                
            } fail:^(NSString *errorString) {
            }];
            
        }];
    }else if (selectIndexTag == 2){//付款
        
        PayOrderViewController *orderVC = [[PayOrderViewController alloc]init];
        orderVC.orderID = model.ID;
        orderVC.orderName = model.storeName;
        orderVC.orderAmount = model.totalPrice;
        [self.navigationController pushViewController:orderVC animated:YES];
        
    }else if (selectIndexTag == 3){//提醒发货
        
        [[APIManager sharedManager] remindingShipmentsWithOrderId:model.ID CallBack:^(id data) {
            RC001;
            [bself.view showCenterToast:@"已经提醒订单"];
            
        } fail:^(NSString *errorString) {
        }];
        
    }else if (selectIndexTag == 4){//确认收货
        
        [LDAlterView alterViewWithTitle:@"提示" content:@"确定收货?" cancel:@"取消" sure:@"确定" cancelBtClcik:nil sureBtClcik:^{
            
            [[APIManager sharedManager] confirmationOrderWithOrderId:model.ID CallBack:^(id data) {
                
                RC001;
                [bself silenceRefresh];
                
            } fail:^(NSString *errorString) {
                
            }];
        }];
        
    }else if (selectIndexTag == 5){//查看物流
        
    }else if (selectIndexTag == 6){//取消退货
        
    }else if (selectIndexTag == 7){//再次退货
        
    }else if (selectIndexTag == 8){//去评价
        
    }
}


@end

