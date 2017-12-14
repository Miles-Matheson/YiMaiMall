//
//  APIManager.h
//  BaseFrame
//
//  Created by Zxs on 16/9/19.
//  Copyright © 2016年 Zxs. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface APIManager : NSObject

@property (nonatomic,copy)NSString *device_token;

+ (instancetype)sharedManager;

#pragma mark --- 获得验证码
- (void)getMsgCodeWithMobile:(NSString *)mobile CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark --- 手机号登陆
- (void)userMobileLoginWithData:(NSDictionary *)data CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark --- 修改密码
-(void)resetPswWithData:(NSDictionary *)data CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark --- 获得首页banner数据
-(void)getHomeBannerListDataCallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark --- 获得首页分类数据
-(void)getHomeClassListCallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark --- 获得首页商城快报数据
-(void)getHomeMallMesssageListCallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark --- 获得首页热销市场数据
-(void)getHomeHotmarketListCallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark --- 获得首页人气爆款列表
-(void)getHomeGoodsPopularListWithData:(NSDictionary *)data CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark --- 获得商品详情基本信息
-(void)getGoodsBaseInfoWithGoodsID:(NSString*)goodsID CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark --- 获得商品详情下的商品推荐
-(void)getGoodsReferralsWithGoodsID:(NSString*)goodsID CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark --- 收藏商品/取消收藏
-(void)foucsOrCancelGoodsWithGoodsID:(NSString*)goodsID isFoucs:(BOOL)isFoucs CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark --- 获取商品详情H5页面
-(void)getGoodsH5InfoWithGoodsID:(NSString*)goodsID CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark --- 获取商品详情评价列表
-(void)getGoodsCommentListWithGoodsData:(NSDictionary*)param CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark --- 获取商品sku信息
-(void)getGoodsSKUInfoWithGoodsID:(NSString *)goodsID CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark --- 获取线上店铺介绍
-(void)getOnlineStoreIdInfoWithStoreId:(NSString *)storeId CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark --- 线上收藏店铺/取消收藏
-(void)onlineStoreFoucsOrCancelGoodsWithStoreId:(NSString*)storeId isFoucs:(BOOL)isFoucs CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark --- 线上店铺推荐
-(void)onlineStoreReferralsWithData:(NSDictionary *)data CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark --- 线上店全部商品
-(void)onlineStoreGoodsAllWithData:(NSDictionary *)data CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark --- 线上热销商品
-(void)onlineGoodsHotWithData:(NSDictionary *)data CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark --- 线上 线上上新
-(void)onlineGoodsLatestWithData:(NSDictionary *)data CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark --- 线上商品全部分类
-(void)onlineGoodsCatClassListWithData:(NSDictionary *)data CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark --- 基础信息-省市县级联
-(void)getAreaDataCallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark --- 添加到购物车
-(void)addGoodsToShopCartWithData:(NSDictionary *)data CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark --- 获取购物车列表
-(void)getShopCatrListWithUserID:(NSString *)userID CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark --- 删除购物车商品
-(void)deleteGoodeWithGoodsCartId:(NSString *)goodsCartId CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark --- 修改购物车商品数量
-(void)changeGoodsCountWithData:(NSDictionary *)dataDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark --- 购物车-结算
-(void)goodsModifyWithIdlist:(NSArray *)ids CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;


#pragma mark --- 商品-运费计算
-(void)getTransfeeWithData:(NSDictionary *)data  CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark --- 确认订单-提交订单
-(void)commitOrderWithData:(NSDictionary *)data  CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark --- 线上商品搜索
-(void)onlineGoodsSearchWithData:(NSDictionary *)data  CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark --- 线上店铺搜索
-(void)onlineStoreSearchWithData:(NSDictionary *)data  CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark --- 分类类目请求
-(void)getClassTabDataCallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark --- 获取用户地址列表
-(void)getUserAddressListWithData:(NSDictionary *)dataDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark ---设置默认地址
-(void)setDefultAddressAddreddID:(NSString *)addressID CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark ---删除地址
-(void)deleateAddressAddreddID:(NSString *)addressID CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark ---新增地址
-(void)addUserAddressWithData:(NSDictionary *)addData CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark ---修改用户收货地址
-(void)reSetUserAddressWithData:(NSDictionary *)addData CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark ---获取订单详情
-(void)getOrderDetailWithOrderId:(NSString *)orderId CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark ---确认收货
-(void)confirmationOrderWithOrderId:(NSString *)orderId CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark ---提醒发货
-(void)remindingShipmentsWithOrderId:(NSString *)orderId CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark ---删除订单
-(void)deleteOrderWithOrderId:(NSString *)orderId CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark ---确认收货后商品推荐
-(void)getInterestListOrderWithOrderId:(NSString *)orderId CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark ---评价订单
-(void)evaluateOrderWithOrderId:(NSDictionary *)data CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark ---订单列表
-(void)getOnlineOrderListWithData:(NSDictionary *)data CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark ---取消订单
-(void)cancelOnlineOrderWithOrderID:(NSString *)orderId CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark ---微信订单提交
-(void)weiChatPayWithData:(NSDictionary *)dataDic  CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark ---微信订单支付结果查询
-(void)weiChatPayCheckWithData:(NSDictionary *)dataDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

#pragma mark ---商品立即购买
-(void)goodsBuyNowWithData:(NSDictionary *)dataDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail;

@end


