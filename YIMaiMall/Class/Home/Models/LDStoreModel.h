//
//  LDStoreModel.h
//  YIMaiMall
//
//  Created by Miles on 2017/12/6.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDStoreModel : NSObject
@property (nonatomic, copy) NSString *banner;

@property (nonatomic, copy) NSString *weixinToken;
@property (nonatomic, copy) NSString *weixinStoreName;
@property (nonatomic, copy) NSString *weixinAppId;
@property (nonatomic, copy) NSString *weixinAppSecret;
@property (nonatomic, copy) NSString *ID;

@property (nonatomic, assign) BOOL isAttention;
@property (nonatomic, copy) NSString *logo;//商铺logo）

@property (nonatomic, copy) NSString *storeOwer;//（店主）
@property (nonatomic, copy) NSString *storeName;//平台自营店",    （商铺名）
@property (nonatomic, copy) NSString *addTime;//(开店时间)
@property (nonatomic, assign) NSInteger favoriteCount;//（关注人数）
@property (nonatomic, assign) NSInteger gradeLevel;
@property (nonatomic, copy) NSString *storeSeoDescription;//（经营范围）
@property (nonatomic, copy) NSString *lisence;//（营业执照）

@property (nonatomic, copy) NSString *shipRaiseRate;//与同行的比较）
@property (nonatomic, copy) NSString *serviceRaiseRate;//（与同行的比较）
@property (nonatomic, copy) NSString *descriptionpRaiseRate;//（与同行的比较）
@property (nonatomic, copy) NSString *praiseRate;//（综合评价）

@property (nonatomic, copy) NSString *descriptionEvaluate;//（描述相符）
@property (nonatomic, copy) NSString *serviceEvaluate;//（服务评分）
@property (nonatomic, copy) NSString *shipEvaluate;//物流服务评分


@end
