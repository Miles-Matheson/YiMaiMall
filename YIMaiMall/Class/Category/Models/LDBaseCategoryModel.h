//
//  LDBaseCategoryModel.h
//  FullAndFresh
//
//  Created by Miles on 2017/10/13.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDCategoryThirdChildModel :NSObject
@property(nonatomic,assign)NSInteger sequence;
@property(nonatomic,copy)NSString *classname;
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *parentId;
@property(nonatomic,copy)NSString *iconUrl;
//@property(nonatomic,copy)NSArray <LDCategorySecondChildModel*>*childs;

@end

@interface LDCategorySecondChildModel :NSObject

@property(nonatomic,assign)NSInteger sequence;
@property(nonatomic,copy)NSString *classname;
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *parentId;
@property(nonatomic,copy)NSString *iconUrl;
@property(nonatomic,copy)NSArray <LDCategoryThirdChildModel*>*childs;

@end

@interface LDBaseCategoryModel :NSObject <NSCopying,NSMutableCopying>

@property(nonatomic,assign)NSInteger sequence;
@property(nonatomic,copy)NSString *classname;
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *parentId;
@property(nonatomic,copy)NSString *iconUrl;
@property(nonatomic,copy)NSArray <LDCategorySecondChildModel*>*childs;

@end
