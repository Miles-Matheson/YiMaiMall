//
//  APIManager.m
//  BaseFrame
//
//  Created by Zxs on 16/9/19.
//  Copyright © 2016年 Zxs. All rights reserved.
//

#define getPathWithFileName(filename) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:filename]
#define DetailModelFileName getPathWithFileName(@"LDMapStoreDetailModel.plist")

#import "APIManager.h"
#import "YMUrl.h"
static APIManager * shared_manager = nil;
static dispatch_once_t pred;
@implementation APIManager

+ (instancetype)sharedManager{
    dispatch_once(&pred, ^{
        shared_manager = [[APIManager alloc] init];
    });
    return shared_manager;
}

+ (instancetype)changeManager{
    shared_manager = [[APIManager alloc] init];
    //    [XBUrl changeJsonClient];
    return shared_manager;
}

//user/login
#pragma mark --- 获得验证码
- (void)getMsgCodeWithMobile:(NSString *)mobile CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    NSDictionary *param = @{
                            @"mobile":mobile?mobile:@"",
                            };
    [YMUrl postWithUrl:@"pin/get" paraDic:param showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

#pragma mark --- 手机号登陆
- (void)userMobileLoginWithData:(NSDictionary *)param CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    [YMUrl postWithUrl:@"user/login" paraDic:param showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

#pragma mark --- 获得首页banner数据
-(void)getHomeBannerListDataCallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    [YMUrl postWithUrl:@"base/online/banner/list" paraDic:@{@"1":@"1"} showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

#pragma mark --- 获得首页分类数据
-(void)getHomeClassListCallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    [YMUrl postWithUrl:@"base/online/cat/list" paraDic:@{@"1":@"1"} showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

#pragma mark --- 获得首页商城快报数据
-(void)getHomeMallMesssageListCallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    [YMUrl postWithUrl:@"base/notice/list" paraDic:@{@"1":@"1"} showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

#pragma mark --- 获得首页热销市场数据
-(void)getHomeHotmarketListCallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    [YMUrl postWithUrl:@"base/hotmarket" paraDic:@{@"1":@"1"} showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

#pragma mark --- 获得首页人气爆款列表
-(void)getHomeGoodsPopularListWithData:(NSDictionary *)data CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{

    [YMUrl postWithUrl:@"online/goods/popular" paraDic:data showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

#pragma mark --- 获得商品详情基本信息
-(void)getGoodsBaseInfoWithGoodsID:(NSString*)goodsID CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    NSDictionary *param = @{@"goodsId":goodsID?goodsID:@""};
    
    [YMUrl postWithUrl:@"online/goods/basis" paraDic:param showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

#pragma mark --- 获得商品详情下的商品推荐
-(void)getGoodsReferralsWithGoodsID:(NSString*)goodsID CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    NSDictionary *param = @{@"goodsId":goodsID?goodsID:@""};
    
    [YMUrl postWithUrl:@"online/goods/referrals" paraDic:param showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

#pragma mark --- 收藏商品/取消收藏
-(void)foucsOrCancelGoodsWithGoodsID:(NSString*)goodsID isFoucs:(BOOL)isFoucs CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    NSString *url = isFoucs?@"online/goods/collect":@"online/goods/cancelCollect";
    NSDictionary *param = @{@"goodsId":goodsID?goodsID:@""};
    [YMUrl postWithUrl:url paraDic:param showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

#pragma mark --- 获取商品详情H5页面
-(void)getGoodsH5InfoWithGoodsID:(NSString*)goodsID CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    NSDictionary *param = @{
                            @"goodsId":goodsID?goodsID:@"",
                            };
    [YMUrl postWithUrl:@"online/goods/h5" paraDic:param showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

#pragma mark --- 获取商品详情评价列表
-(void)getGoodsCommentListWithGoodsData:(NSDictionary*)param CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{

    [YMUrl postWithUrl:@"online/goods/eval" paraDic:param showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

#pragma mark --- 修改密码
-(void)resetPswWithData:(NSDictionary *)data CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{

    [YMUrl postWithUrl:@"pw/modify" paraDic:data showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}


#pragma mark --- 获取商品sku信息
-(void)getGoodsSKUInfoWithGoodsID:(NSString *)goodsID CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    NSDictionary *param = @{
                            @"goodsId":goodsID?goodsID:@"",
                            };
    [YMUrl postWithUrl:@"online/goods/spec" paraDic:param showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

#pragma mark --- 获取线上店铺介绍
-(void)getOnlineStoreIdInfoWithStoreId:(NSString *)storeId CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    NSDictionary *param = @{
                            @"storeId":storeId?storeId:@"",
                            };
    [YMUrl postWithUrl:@"online/store/basis" paraDic:param showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

#pragma mark --- 线上收藏店铺/取消收藏
-(void)onlineStoreFoucsOrCancelGoodsWithStoreId:(NSString*)storeId isFoucs:(BOOL)isFoucs CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    NSString *url = isFoucs?@"online/store/note":@"online/store/cancelNote";
    NSDictionary *param = @{@"storeId":storeId?storeId:@""};
    [YMUrl postWithUrl:url paraDic:param showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

#pragma mark --- 线上店铺推荐
-(void)onlineStoreReferralsWithData:(NSDictionary *)data CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{

    [YMUrl postWithUrl:@"online/store/goods/referrals" paraDic:data showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

#pragma mark --- 线上店全部商品
-(void)onlineStoreGoodsAllWithData:(NSDictionary *)data CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    [YMUrl postWithUrl:@"online/store/goods/all" paraDic:data showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

#pragma mark --- 线上热销商品
-(void)onlineGoodsHotWithData:(NSDictionary *)data CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    [YMUrl postWithUrl:@"online/store/goods/hot" paraDic:data showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

#pragma mark --- 线上 线上上新
-(void)onlineGoodsLatestWithData:(NSDictionary *)data CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    [YMUrl postWithUrl:@"online/store/goods/latest" paraDic:data showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

#pragma mark --- 线上商品全部分类
-(void)onlineGoodsCatClassListWithData:(NSDictionary *)data CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    [YMUrl postWithUrl:@"online/store/goods/cat" paraDic:data showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

//基础信息-省市县级联
#pragma mark --- 基础信息-省市县级联
-(void)getAreaDataCallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    [YMUrl postWithUrl:@"base/area/cascade" paraDic:@{@"A":@"a"} showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

//online/cart/add
#pragma mark --- 添加到购物车
-(void)addGoodsToShopCartWithData:(NSDictionary *)data CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    [YMUrl postWithUrl:@"online/cart/add" paraDic:data showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}
//online/cart/list

#pragma mark --- 获取购物车列表
-(void)getShopCatrListWithUserID:(NSString *)userID CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    [YMUrl postWithUrl:@"online/cart/list" paraDic:@{@"uid":userID?userID:@""} showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

//online/cart/del

#pragma mark --- 获取购物车列表
-(void)deleteGoodeWithGoodsCartId:(NSString *)goodsCartId CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    [YMUrl postWithUrl:@"online/cart/del" paraDic:@{@"goodsCartId":goodsCartId?goodsCartId:@""} showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

#pragma mark --- 修改购物车商品数量
-(void)changeGoodsCountWithData:(NSDictionary *)dataDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    [YMUrl postWithUrl:@"online/cart/modify" paraDic:dataDic showLoading:NO Block:^(id data) {
        
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

//online/cart/calc
#pragma mark --- 购物车-结算
-(void)goodsModifyWithIdlist:(NSArray *)ids CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    //idlist：购物车商品编号（long数组）
    [YMUrl postWithUrl:@"online/cart/calc" paraDic:@{@"idlist":ids} showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

#pragma mark --- 商品-运费计算
-(void)getTransfeeWithData:(NSDictionary *)data  CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{

    [YMUrl postWithUrl:@"online/cart/transfee" paraDic:data showLoading:NO Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

#pragma mark --- 确认订单-提交订单
-(void)commitOrderWithData:(NSDictionary *)data  CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    [YMUrl postWithUrl:@"online/order/commit" paraDic:data showLoading:NO Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}


#pragma mark --- 线上商品搜索
-(void)onlineGoodsSearchWithData:(NSDictionary *)data  CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    [YMUrl postWithUrl:@"online/goods/search" paraDic:data showLoading:NO Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

#pragma mark --- 线上店铺搜索
-(void)onlineStoreSearchWithData:(NSDictionary *)data  CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    [YMUrl postWithUrl:@"online/store/search" paraDic:data showLoading:NO Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

#pragma mark --- 分类类目请求
-(void)getClassTabDataCallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    [YMUrl postWithUrl:@"base/cat/cascade" paraDic:@{@"1":@"1"} showLoading:NO Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

#pragma mark --- 获取用户地址列表
-(void)getUserAddressListWithData:(NSDictionary *)dataDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    [YMUrl postWithUrl:@"member/delivery/address/list" paraDic:dataDic showLoading:NO Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

#pragma mark ---设置默认地址
-(void)setDefultAddressAddreddID:(NSString *)addressID CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    [YMUrl postWithUrl:@"member/delivery/address/default" paraDic:@{@"id":addressID?addressID:@""} showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

#pragma mark ---删除地址
-(void)deleateAddressAddreddID:(NSString *)addressID CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    [YMUrl postWithUrl:@"member/delivery/address/del" paraDic:@{@"id":addressID?addressID:@""} showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

#pragma mark ---新增地址
-(void)addUserAddressWithData:(NSDictionary *)addData CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    [YMUrl postWithUrl:@"member/delivery/address/add" paraDic:addData showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}


#pragma mark ---修改用户收货地址
-(void)reSetUserAddressWithData:(NSDictionary *)addData CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    [YMUrl postWithUrl:@"member/delivery/address/modify" paraDic:addData showLoading:NO Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

//online/order/detail
#pragma mark ---获取订单详情
-(void)getOrderDetailWithOrderId:(NSString *)orderId CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    [YMUrl postWithUrl:@"online/order/detail" paraDic:@{@"orderId":orderId?orderId:@""} showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}


#pragma mark ---确认收货
-(void)confirmationOrderWithOrderId:(NSString *)orderId CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    [YMUrl postWithUrl:@"online/order/confirm" paraDic:@{@"orderId":orderId?orderId:@""} showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

//online/order/haste

#pragma mark ---提醒发货
-(void)remindingShipmentsWithOrderId:(NSString *)orderId CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    [YMUrl postWithUrl:@"online/order/haste" paraDic:@{@"orderId":orderId?orderId:@""} showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

//online/order/del
#pragma mark ---删除订单
-(void)deleteOrderWithOrderId:(NSString *)orderId CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    [YMUrl postWithUrl:@"online/order/del" paraDic:@{@"orderId":orderId?orderId:@""} showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

//online/order/goods/interest

#pragma mark ---评价订单
-(void)evaluateOrderWithOrderId:(NSDictionary *)data CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    [YMUrl postWithUrl:@"online/order/eval" paraDic:data showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

//online/order/eval
#pragma mark ---订单列表
-(void)getOnlineOrderListWithData:(NSDictionary *)data CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    [YMUrl postWithUrl:@"online/order/list" paraDic:data showLoading:NO Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}


#pragma mark ---取消订单
-(void)cancelOnlineOrderWithOrderID:(NSString *)orderId CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    [YMUrl postWithUrl:@"online/order/cancel" paraDic:@{@"id":orderId?orderId:@""} showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

//微信App支付统一下单接口
#pragma mark ---微信订单提交
-(void)weiChatPayWithData:(NSDictionary *)dataDic  CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    [YMUrl postWithUrl:@"pay/order/WxAppPay" paraDic:dataDic showLoading:NO Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}

//微信App支付同步回调接口（订单支付结果查询）
#pragma mark ---微信订单支付结果查询
-(void)weiChatPayCheckWithData:(NSDictionary *)dataDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    [YMUrl postWithUrl:@"pay/order/WxAppPayCheck" paraDic:dataDic showLoading:NO Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}


//online/cart/instance

#pragma mark ---商品立即购买
-(void)goodsBuyNowWithData:(NSDictionary *)dataDic CallBack:(void(^)(id data))callBack fail:(void(^)(NSString *errorString))fail{
    
    [YMUrl postWithUrl:@"online/cart/instance" paraDic:dataDic showLoading:YES Block:^(id data) {
        callBack(data);
    } fail:^(NSString *errorString) {
        fail(errorString);
    }];
}


@end
