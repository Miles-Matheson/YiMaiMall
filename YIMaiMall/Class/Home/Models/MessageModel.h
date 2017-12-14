//
//  MessageModel.h
//  BaseFrame
//
//  Created by 陈舟为 on 2017/3/29.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property(nonatomic,assign)int ID,Type;

@property(nonatomic,copy)NSString *Title;
@property(nonatomic,copy)NSString *Content;
@property(nonatomic,copy)NSString *SendTime;

@property(nonatomic,assign)CGFloat textHeight;

@end
