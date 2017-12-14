//
//  LDOnLineGoodsClassModel.h
//  YIMaiMall
//
//  Created by Miles on 2017/12/6.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDOnLineGoodsClassSonModel : NSObject

@property (nonatomic, copy) NSString *className;
@property (nonatomic, copy) NSString *gcId;
@property (nonatomic, copy) NSString *parentId;
@property (nonatomic, copy) NSString *lowerLevel;
@end

@interface LDOnLineGoodsClassModel : NSObject

@property (nonatomic, copy) NSString *className;
@property (nonatomic, copy) NSString *gcId;
@property (nonatomic, copy) NSString *parentId;
@property (nonatomic, copy) NSArray<LDOnLineGoodsClassSonModel *> *lowerLevel;

@end
