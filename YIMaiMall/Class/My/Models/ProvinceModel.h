//
//  ProvinceModel.h
//  BaseFrame
//
//  Created by Zxs on 17/1/6.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaModel : NSObject

@property(nonatomic,assign)NSInteger  sequence;
@property(nonatomic,copy)NSString* ID;
@property(nonatomic,copy)NSString * parentId;
@property(nonatomic,copy)NSString * name;
//@property(nonatomic,strong)NSMutableArray *childs;

@end


@interface CityModel : NSObject

@property(nonatomic,assign)NSInteger  sequence;
@property(nonatomic,copy)NSString* ID;
@property(nonatomic,copy)NSString * parentId;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,strong)NSMutableArray <AreaModel*>* childs;

@end


@interface ProvinceModel : NSObject

@property(nonatomic,assign)NSInteger  sequence;///sequence：序号（int）
@property(nonatomic,copy)NSString* ID;///id：编号（long）
@property(nonatomic,copy)NSString * parentId;///parentId：上级编号（long）
@property(nonatomic,copy)NSString * name;///name：名称（string）
@property(nonatomic,strong)NSMutableArray <CityModel*>* childs;///childs：当前对象

@end








