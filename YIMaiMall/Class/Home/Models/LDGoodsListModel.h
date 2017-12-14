//
//  LDGoodsListModel.h
//  StairOrder
//
//  Created by Miles on 2017/8/15.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDGoodsListModel : NSObject

@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *img;
@property (nonatomic,copy)NSString *gName;
@property (nonatomic,assign)NSInteger gda;
@property (nonatomic,assign)CGFloat price;

@property (nonatomic,assign)NSInteger count;

///是否处于编辑状态
@property (nonatomic, assign) BOOL isEditing;
///是否被选中
@property (nonatomic, assign) BOOL isselect;

@end
