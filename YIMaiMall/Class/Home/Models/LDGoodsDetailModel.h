//
//  LDGoodsDetailModel.h
//  YIMaiMall
//
//  Created by Miles on 2017/12/4.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LDGoodsDetailModel.h"

@interface LDGoodsDetailBannerModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *url;

@end

@interface LDGoodsEvaluateDtoModel : NSObject

@property (nonatomic, assign) NSInteger count;//（评价人数）
@property (nonatomic, copy) NSString *praiseRate;//（好评率）

@end


@interface LDGoodsStoreInfoModel : NSObject

@property (nonatomic, assign) CGFloat descriptionEvaluate;//（（商品评)
@property (nonatomic, assign) CGFloat serviceEvaluate;//（服务评分）
@property (nonatomic, assign) CGFloat shipEvaluate;//（运输评分）
@property (nonatomic, assign) NSInteger goodsCount;//（（店铺的商品数量）
@property (nonatomic, assign) NSInteger favoriteCount;//（（关注人数）
@property (nonatomic, assign) CGFloat generalScore;//（（综合评价）

@property (nonatomic, copy) NSString *ID;// （店铺id）
@property (nonatomic, copy) NSString *imgName;//
@property (nonatomic, copy) NSString *imgPath;//
@property (nonatomic, copy) NSString *logo;//（）
@property (nonatomic, copy) NSString *storeAddress;//（（地址）
@property (nonatomic, copy) NSString *storeName;//（（名称））
@property (nonatomic, copy) NSString *storeOwer;//（店铺拥有者）
@property (nonatomic, copy) NSString *storeStatus;//（店铺状态）
@property (nonatomic, copy) NSString *storeTelephone;//（店铺电话）

@end


@interface LDGoodsDetailModel : NSObject

@property (nonatomic, copy) NSArray <LDGoodsDetailBannerModel*>*bannerList;//（（分类id）
@property (nonatomic, strong)LDGoodsEvaluateDtoModel *goodsEvaluateDto;
@property (nonatomic, strong)LDGoodsStoreInfoModel *shopStoreDto;


@property (nonatomic, copy) NSString *des;
@property (nonatomic, copy) NSString *gcId;//（（分类id）
@property (nonatomic, copy) NSString *goodsClick;//（点击量）

@property (nonatomic, assign) NSInteger gda;//（GDA）
@property (nonatomic, assign) NSInteger goodsInventory;//库存）
@property (nonatomic, assign) CGFloat goodsCurrentPrice;//（（当前价格）

@property (nonatomic, copy) NSString *goodsMainPhotoUrl;//（商品图片）
@property (nonatomic, copy) NSString *goodsName;//（I’m David16专柜新品爱大卫韩版春季男装长袖休闲外套DQJP11C1",
@property (nonatomic, assign) CGFloat goodsPrice;//（商品价格）
@property (nonatomic, assign) NSInteger goodsSalenum;//（商品销量）
@property (nonatomic, assign) NSInteger goodsStatus;//（商品状态）
@property (nonatomic, copy) NSString *goodsStoreId;//（商品店铺id）

@property (nonatomic, copy) NSString *h5;//
@property (nonatomic, copy) NSString *ID;//（商品ID）
@property (nonatomic, assign) BOOL isCollect;//（（用户是否收藏此商品 0未收藏 1已收藏）
@property (nonatomic, assign) CGFloat storePrice;//（商品的店铺售价）

@end

