//
//  LDCommentModel.h
//  BaseFrame
//
//  Created by Miles on 2017/7/3.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 //商品 .商家 评价model
 */

@interface LDCommentModel : NSObject
@property (nonatomic,copy)NSString *userName;
@property (nonatomic,copy)NSString *evaluateGoodsId;
@property (nonatomic,copy)NSString *evaluateInfo;//（评价语）
@property (nonatomic,copy)NSString *evaluateUserId;

@property (nonatomic,copy)NSString *headimgurl;//（用户头像）
@property (nonatomic,copy)NSString *addTime;
@property (nonatomic,copy)NSString *evaluateType;
@property (nonatomic,assign)NSInteger evaluateBuyerVal;//（评价分数）

@property (nonatomic,copy)NSArray *imgs;

@property (nonatomic,assign)CGFloat cellHeight;
@property (nonatomic,copy)NSString *Reply;//回复内容


@end
