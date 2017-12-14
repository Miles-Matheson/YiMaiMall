//
//  LimiBuyerUrl.m
//  LimiBuyer
//
//  Created by steven on 16/1/28.
//  Copyright © 2016年 limi360. All rights reserved.
//


#ifdef DEBUG

#define NSLog(FORMAT, ...) fprintf(stderr, "%s:%zd\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String]);

#else

#define NSLog(FORMAT, ...) nil
#endif


#import "YMUrl.h"

#import <AFNetworking/AFNetworking.h>
#import "LDErrorInfo.h"
#import "NSData+AES256.h"
@implementation YMUrl : NSObject


#pragma mark - 公共接口

+(void)uplodatImageWithpath:(NSString *)url imgeData:(NSData *)data param:(NSDictionary *)param name:(NSString *)name CallBack:(void(^)(float Progress))Progress success:(void(^)(NSURLSessionDataTask * task , id responseObject))success fail:(void(^)(NSURLSessionDataTask * _Nullable task,NSError *error))fail
{
     NSString *URLString = [NSString stringWithFormat:@"%@%@",Server,url];
    
    //上传服务器
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    [manager POST:URLString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        
        NSString *fileName = [NSString stringWithFormat:@"%@.png",str];
        [formData appendPartWithFileData:data name:@"Head" fileName:fileName mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {

        NSLog(@"进度= %f",uploadProgress.fractionCompleted);
        
        Progress(uploadProgress.fractionCompleted);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        success(task,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        fail(task,error);
    }];
}


+ (void) postWithUrl:(NSString *)url paraDic:(NSDictionary *)param showLoading:(BOOL)isShowLoading Block:(void (^)(id data))block fail:(void(^)(NSString *errorString))fail{
    
    ws(bself);
    
    if (isShowLoading) {
        [SVProgressHUD showWithStatus:@"加载中...."];
    }

    // 开始设置请求头
    NSString *timestamp = kTimeStamp;
    NSString *md5TimesTamp = [timestamp md5];
    NSString *testUp         = [md5TimesTamp uppercaseString];    //大写
    
//    NSString *dataString = [NSString stringWithFormat:@"%@|%@|%@|%@,%@",kAppCLIENT_TYPE,kAppVersion,kAppAPIVERSION,timestamp,testUp];
    
//    NSString* postfix = [NSData AES256EncryptWithPlainText:dataString];

     NSString* postfix = [NSData AES256EncryptWithPlainText:@"1|1.0|1.0|20171202094546"];
//     NSString* postfix11 = [NSData AES256DecryptWithCiphertext:postfix withKey:@"022CBE5D4D4B209655157BFFF219B360"];
    
    NSString *URLString = [NSString stringWithFormat:@"%@%@",Server,url];
    NSDictionary *dataDic = @{
                              @"client":kAppCLIENT_TYPE,
                               @"version":kAppVersion,
                               @"apiVersion":kAppAPIVERSION,
                               @"timestamp":timestamp,
                               @"postfix":postfix,
                              };

//    NSLog(@"dataDic === %@",dataDic);
    
    [LLNetworkEngine postWithUrl:URLString dataDic:dataDic paraDic:param successBlock:^(BOOL isSuccess, NSString *message, id jsonObj) {
        
        if (isShowLoading) {
            [SVProgressHUD dismiss];
        }
        
        NSData *data = (NSData *)[NSJSONSerialization dataWithJSONObject:jsonObj options:NSJSONWritingPrettyPrinted error:nil];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        id tempObj = [dic objectForKey: @"obj"];
        
        NSString *decryptString = nil;
        
        if ([tempObj isKindOfClass:[NSString class]]) {
//            NSDictionary*codeDic = [MySecurity decryptAESData:dic[@"data"]];
            NSDictionary*codeDic = dic[@"data"];
            if (!codeDic) {
//                codeDic = dic[@"obj"];
            }
            if (codeDic != nil) {
                decryptString =  [self convertToJSONData:codeDic];
            }
        }else{
            decryptString =  [self convertToJSONData:dic];
        }

        NSLog(@"\n\n【请求地址】%@\n【请求Json】\n%@\n【解析json】\n%@\n\n",URLString,[self DataToJsonString:param],decryptString);
        
        if ([jsonObj[@"state"] integerValue] == -1) {
            
            [kUserDefault removeObjectForKey:TOKEN];
            [NSNotic_Center postNotificationName:LOGOUTSUCCESS object:nil];
            [NSNotic_Center removeObserver:bself];
            
        }else if ([URLString rangeOfString:@"user/login"].location !=NSNotFound){
            
            NSString *loginTimestamp =  timestamp;
            [kUserDefault setObject:loginTimestamp?loginTimestamp:@"" forKey:@"timestamp"];
            [kUserDefault synchronize];
        }
        if(isSuccess){
            block(jsonObj);
        }
        
    } failedBlock:^(NSError *error) {
        
        if (isShowLoading) {
            [SVProgressHUD dismiss];
        }
        NSLog(@"\n\n【请求地址】%@\n【请求参数】\n%@\n【请求Json】\n%@",URLString,param,[self DataToJsonString:param]);
        if (error) {
            NSLog(@"error == %@",error);
        }
        fail([LDErrorInfo getErrorInfo:error]);
        [[LLUtils getCurrentVC].view showCenterToast:[LDErrorInfo getErrorInfo:error]];
    }];
}

+ (NSString*)DataToJsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    
    @try {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                           options:NSJSONWritingPrettyPrinted
                            // Pass 0 if you don't care about the readability of the generated string 如果NSJSONWritingPrettyPrinted 是nil 的话 返回的数据是没有 换位符的
                                                             error:&error];
        if (! jsonData) {
            NSLog(@"Got an error: %@", error);
        } else {
            jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
        return jsonString;
    } @catch (NSException *exception) {
        return @"";
    }
}

+(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return html;
}

+ (NSString*)convertToJSONData:(id)infoDict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:infoDict
                                                       options:NSJSONWritingPrettyPrinted
    // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    NSString *jsonString = @"";
    
    if (! jsonData){
        NSLog(@"Got an error: %@", error);
    }else{
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return jsonString;
}

@end
