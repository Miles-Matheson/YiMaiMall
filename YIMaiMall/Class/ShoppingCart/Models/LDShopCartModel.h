//
//  LDShopCartModel.h
//  YIMaiMall
//
//  Created by Miles on 2017/12/7.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface  LDShopGoodsModel : NSObject

@property (nonatomic, copy) NSString *goodsName;
@property (nonatomic, copy) NSString *goodsPhotoUrl;
@property (nonatomic, copy) NSString *goodsId;
@property (nonatomic, copy) NSString *goodsMainPhotoId;

@end

@interface  LDShopGoodsCartsModel : NSObject

@property (nonatomic, strong) LDShopGoodsModel*goods;

@property (nonatomic, copy) NSString *goodsId;
@property (nonatomic, copy) NSString *goodsCartId;
@property (nonatomic, copy) NSString *goodsSpec;

@property (nonatomic, assign) CGFloat cartPrice;
@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign)BOOL isselect;
@property (nonatomic, assign)BOOL isEditing;



// 商品左侧按钮是否选中
@property (nonatomic,assign) BOOL productIsChoosed;

@end

@interface LDShopCartModel : NSObject

@property (nonatomic, copy) NSString *storeName;
@property (nonatomic, copy) NSString *storeId;
@property (nonatomic, copy) NSArray <LDShopGoodsCartsModel*>*goodsCarts;
@property (nonatomic, copy) NSString *storeCartId;

@property (nonatomic, assign)BOOL isselect;
@property (nonatomic, assign)BOOL isEditing;

@end
