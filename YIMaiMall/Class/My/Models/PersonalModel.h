//
//  PersonalModel.h
//  BaseFrame
//
//  Created by 陈舟为 on 2017/6/23.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonalModel : NSObject

@property(nonatomic,copy)NSString *Birthday;

@property(nonatomic,copy)NSString *Head;

@property(nonatomic,copy)NSString *HeadURL;

@property(nonatomic,copy)NSString *Mobile;

@property(nonatomic,copy)NSString *NickName;

@property(nonatomic,copy)NSString *RealName;

@property(nonatomic,copy)NSString *UserName;

@property(nonatomic,assign)NSInteger Sex;

@property(nonatomic,copy)NSString* CompanyName;
@property(nonatomic,copy)NSString* CompanyPhoto;
@property(nonatomic,copy)NSString* CompanyPhotoURL;
@property(nonatomic,copy)NSString*CompanyAddress;
@end
