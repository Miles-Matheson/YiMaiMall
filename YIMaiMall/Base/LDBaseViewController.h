//
//  LDBaseViewController.h
//  StairOrder
//
//  Created by Miles on 2017/8/14.
//  Copyright © 2017年 Miles. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "LDOrderModel.h"

typedef enum : NSUInteger {
    
    NoMoreDataTypeDefult = 0,
    NoMoreDataTypeNoLogin,
    NoMoreDataTypeNoShopCar,
    NoMoreDataTypeNoSearch,
    NoMoreDataTypeNoMessage,
    NoMoreDataTypeNoOrder,
    
} NoMoreDataType;

#import <UIKit/UIKit.h>

@interface LDBaseViewController : UIViewController

@property (nonatomic,assign)NoMoreDataType NoMoreDataType;
@property (nonatomic,strong)UITableView *aTableView;
@property (nonatomic,strong)UICollectionView *aCollectionView;

@property (nonatomic,strong)UIImageView *navBackgroundImageView;

@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *rightBtn;
@property(nonatomic,strong)NSString *titleText;

- (void)setNavWithTitle:(NSString *)title isShowBack:(BOOL)isShowBack;

- (void)setTitleText:(NSString *)titleText textColor:(UIColor *)color;

-(void)setTitleTtextColor:(UIColor *)color;

- (void)setLeftText:(NSString *)leftText textColor:(UIColor *)color
            ImgPath:(NSString *)imgPath;
- (void)setRightText:(NSString *)rightText textColor:(UIColor *)color
             ImgPath:(NSString *)imgPath;

- (void)setLeftBtnLeftInset:(CGFloat)offset;
- (void)setRightBtnLeftInset:(CGFloat)offset;

- (void)clickLeftBtn:(UIButton *)leftBtn;
- (void)clickRightBtn:(UIButton*)rightBtn;

- (void)setNavBgColor:(UIColor *)bgColor;

#pragma 弹出更多选择框
/// 弹出更多选择框
-(void)showMoreViewWithHandl:(UIView*)clickView InfoData:(NSArray <NSDictionary*>*)dataArray CallBack:(void(^)(NSInteger selectIndex))callBack;

- (BOOL)isLogin;

-(void)login;

-(void)logOutAccountCallBack:(void(^)(BOOL success))logoutAccountCallBack;


/**
 *  获取手机号
 * @mobile 手机号码
 * @ callBack 回调
 */
-(void)getMessageWithMobile:(NSString *)mobile CallBack:(void(^)(BOOL success))callBack;

/**
 *  添加商品到购物车
 * @skuIds 添加购物车的商品规格ids 按照id1_id2_的顺序  可为空
 * @goodsId 添加购物车的商品id 不可为空
 * @count 添加购物车商品数量 不可为空
 * @sizeInfo 商品规格信息 按照 “尺码：M 颜色：白色”的形式 方便存储
 */

-(void)addGoodsToShopCartWithSkuIds:(NSString *)skuIds goodsIds:(NSString *)goodsId count:(NSInteger)count sizeInfo:(NSString *)sizeInfo CallBack:(void(^)(BOOL success,NSDictionary*data))callBack;


/**
 *  订单操作
 * @selectIndexTag @[@"取消订单",@"删除订单",@"付款",@"提醒发货",@"确认收货",@"查看物流",@"取消退货",@"再次退货",@"去评价"]
 */
-(void)changeOrderStatusWithSelectIndexTag:(NSInteger)selectIndexTag model:(LDOrderModel *)model;

@end
