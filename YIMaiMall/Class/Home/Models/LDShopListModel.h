//
//  LDShopListModel.h
//  YIMaiMall
//
//  Created by Miles on 2017/11/21.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <Foundation/Foundation.h>

//店铺推荐model
@interface LDShopRrecommendGoodsModel : NSObject

@property (nonatomic,copy)NSString *advertisingDesc; //商品推荐标语）
@property (nonatomic,copy)NSString *gName;  // 商品名）
@property (nonatomic,copy)NSString *gcId;   // (商品分类Id）
@property (nonatomic,copy)NSString *ID;     //（商品Id）
@property (nonatomic,copy)NSString *img;    //（商品主图）
@property (nonatomic,assign)CGFloat   price;  //（商品价格）
@property (nonatomic,assign)NSInteger pv;     //（商品GDA）
@property (nonatomic,assign)NSInteger salenum;//（商品销量）

@end

@interface LDShopListModel : NSObject

@property (nonatomic, copy)NSString * deleteStatus;//（删除状态0未删除 ）
@property (nonatomic, copy)NSArray <LDShopRrecommendGoodsModel *>* storRrecommendGoods;//(店铺推荐商品）
@property (nonatomic, copy)NSString * ID;       //（店铺id)
@property (nonatomic, copy)NSString * gradeId;  //（店铺等级
@property (nonatomic, copy)NSString * storeStatus;// 2(店铺状态 1：待审核 2：正常 3：违规关闭 )
@property (nonatomic, copy)NSString * addTime;  //（添加时间）
@property (nonatomic, copy)NSString * storeLogo;//（店铺logo）
@property (nonatomic, copy)NSString * storeName;//（店铺名称)

///是否处于编辑状态
@property (nonatomic, assign) BOOL isEditing;
///是否被选中
@property (nonatomic, assign) BOOL isselect;
@end
