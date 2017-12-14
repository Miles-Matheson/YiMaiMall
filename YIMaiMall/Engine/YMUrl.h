
//  LimiBuyerUrl.h
//  LimiBuyer
//
//  Created by steven on 16/1/28.
//  Copyright © 2016年 limi360. All rights reserved.
//  买家版请求接口配置档

#import <Foundation/Foundation.h>

#pragma mark - 服务器域名

//  本机tomcat安装war包

//#define Server  @"http://192.168.0.230:9000/"//文野
//#define Server  @"http://192.168.0.137:9000/"//王金飞
#define Server  @"http://192.168.0.188:9000/"//公用
//#define Server  @"http://192.168.0.225:9000/"//mpp
//#define Server  @"http://192.168.3.102:9000/"//plw

//#define Server   @""//生产环境

#define KiPAddress @"192.168.3.133"
#define kAppVersion @"1.0.0"
#define kAppApiVersion @"1.0"
#define kAppClient_type @"1"

/*  Demo账号密码
 **********  测试环境 **********
18019961713 psw: 123456
 **********  生产环境 **********

*/

@interface YMUrl : NSObject

#pragma mark 
+ (void) postWithUrl:(NSString *_Nullable)url paraDic:(NSDictionary *_Nonnull)param showLoading:(BOOL)isShowLoading Block:(void (^_Nullable)(id _Nonnull data))block fail:(void(^)(NSString * _Nonnull errorString))fail;

+(void)uplodatImageWithpath:(NSString *_Nullable)url imgeData:(NSData *_Nullable)data param:(NSDictionary *)param name:(NSString *)name CallBack:(void(^_Nullable)(float Progress))Progress success:(void(^_Nonnull)(NSURLSessionDataTask * task , id responseObject))success fail:(void(^)(NSURLSessionDataTask * _Nullable task,NSError *error))fail;
@end
