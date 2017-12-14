//
//  LDAddressListModel.h
//  BaseFrame
//
//  Created by Miles on 2017/6/23.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDAddressListModel : NSObject

@property (nonatomic,copy)NSString * ID;        //编号(long)
@property (nonatomic,copy)NSString * areaInfo;  //：详细信息(string)
@property (nonatomic,copy)NSString * mobile;    //：手机号码(string);
@property (nonatomic,copy)NSString * truename;  //姓名(string)
@property (nonatomic,copy)NSString * zip;       //邮编(string)
@property (nonatomic,copy)NSString * areaId;    //地区编号(long)
@property (nonatomic,assign) BOOL  isDefault;  //是否是默认地址(byte)(1：默认地址 0：不默认)


@end
