//
//  LDGoodsSkuModel.h
//  YIMaiMall
//
//  Created by Miles on 2017/12/4.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LDGoodsSkuStandardInfoModel : NSObject
@property (nonatomic, copy) NSString *standardName;
@property (nonatomic, copy) NSString *attrValueId;
@property (nonatomic, copy) NSString *attrvalueTitle;
@property (nonatomic, assign) BOOL isSelect;

@end

@interface LDGoodsSkuSiftKeyModel : NSObject
@property (nonatomic, copy) NSString * standardListName;
@property (nonatomic, copy) NSString * standardType;
@property (nonatomic, copy) NSArray <LDGoodsSkuStandardInfoModel *>* standardInfoList;

@end


@interface LDGoodsSkuModel : NSObject

@property (nonatomic, copy) NSString * ID;
@property (nonatomic, copy) NSString * img;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSArray <LDGoodsSkuSiftKeyModel*>* siftKey;
@property (nonatomic, copy) NSString * minId;
@property (nonatomic, assign) CGFloat  minPrice;
@property (nonatomic, strong) NSDictionary * skuDate;

@end
