//
//  LDHomeModel.h
//  StairOrder
//
//  Created by Miles on 2017/8/21.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LDGoodsListModel.h"


@interface LDBannerModel : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, assign) NSInteger title;
@end


@interface LDClickIndexModel : NSObject
@property (nonatomic,assign)NSInteger ID;
@property (nonatomic,assign)NSInteger sequence;//序号（int）

@property (nonatomic,copy)NSString *imgUrl;
@property (nonatomic,copy)NSString *name;


@end

@interface LDNoticModel : NSObject

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,assign)NSInteger ID;

@property (nonatomic, assign) NSInteger MessageCount;
@end


@interface LDSellerListModel :NSObject

@property(nonatomic,copy)NSString *BusinessPic;
@property(nonatomic,assign)CGFloat score;
@property(nonatomic,assign)CGFloat Distance;
@end

@interface LDHomeAreaModel :NSObject

@property(nonatomic,assign)NSInteger ID;
@property(nonatomic,copy)NSString * img;
@property(nonatomic,copy)NSString * type;

@end


@interface LDNewsModel : NSObject
@property (nonatomic,assign)NSInteger ID;
@property (nonatomic,copy)NSString * Title;
@end

@interface LDHomeModel : NSObject

@property (nonatomic,copy)NSArray <LDClickIndexModel*>*ClassList;//clickItem 数据源
@property (nonatomic,copy)NSArray <LDNoticModel*>*noticArray;//通知滚动栏 数据源
@property (nonatomic,copy)NSArray<LDHomeAreaModel*> *areaList;//五大模块
@property (nonatomic,copy)NSArray<LDGoodsListModel*> *publicList;//五大模块

@property (nonatomic,copy)NSDictionary *Announcement; //首页弹窗的通知公告。
@property (nonatomic,assign)NSInteger MessageCount;//消息数量
@end
