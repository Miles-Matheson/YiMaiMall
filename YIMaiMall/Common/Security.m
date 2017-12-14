//
//  Security.m
//  BaseFrame
//
//  Created by 陈舟为 on 2017/3/15.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import "Security.h"

#import "SecurityUtil.h"


static Security *security = nil;

@implementation Security

+(instancetype)shareSecurity{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        security = [[Security alloc] init];
    });
    
    return security;
}

-(NSString *)getTokenWithName:(NSString *)name withPsd:(NSString *)psd{
    
    
    NSString *md5Name = [self nameMD5WithString:name];
    
    md5Name = [md5Name md5].uppercaseString;
    
    md5Name = [md5Name substringToIndex:30];
    
    NSString *md5Psd = [self psdMD5WithString:psd];
    
    md5Psd = [md5Psd md5].uppercaseString;
    
    md5Psd = [md5Psd substringFromIndex:2];

    NSString *result = [NSString stringWithFormat:@"%@%@",md5Name,md5Psd];

    return result;
}

-(NSString *)psdMD5WithString:(NSString *)psd{
    
    NSString *psdMD5 = [psd md5];
    
    //后30位
    psdMD5 = [psdMD5 substringFromIndex:2];
    
    psdMD5 = psdMD5.uppercaseString;
    
    psdMD5 = [psdMD5 md5];
    
    //前30位
   psdMD5 = [psdMD5 substringToIndex:30];
    
    
    psdMD5 = psdMD5.uppercaseString;
    
    
    NSString *result = [NSString stringWithFormat:@"XB%@",psdMD5];
    
    return result;

    
}

-(NSString *)nameMD5WithString:(NSString *)name{
    
    NSString *nameMD5 = [name md5];
    
    nameMD5 = nameMD5.uppercaseString;
    
    nameMD5 = [nameMD5 md5];
    
    nameMD5 = nameMD5.uppercaseString;
    
    nameMD5 = [nameMD5 substringFromIndex:2];
    
    return nameMD5;
}

-(NSString *)keyMD5WIthName:(NSString *)md5name{
    
    
    NSString *key = [NSString stringWithFormat:@"%@%@",[self nameMD5WithString:md5name],[kUserDefault objectForKey:TICKS]];
    
    key = [key md5].uppercaseString;
    
    key = [key substringFromIndex:2];
    
    NSString *result = [NSString stringWithFormat:@"XB%@",key];
    
    return result;
    
}

-(NSString *)ivMD5WIthName:(NSString *)md5name{
    
    NSString *iv = [NSString stringWithFormat:@"%@%@",[self nameMD5WithString:md5name],[kUserDefault objectForKey:TICKSID]];
    
    iv = [iv md5].uppercaseString;
    
    iv = [iv substringWithRange:NSMakeRange(2 , 14)];
    
    NSString *result = [NSString stringWithFormat:@"XB%@",iv];
    
    return result;
    
}


-(NSString *)getMD5Key{
    
    NSString *key = [self keyMD5WIthName:[kUserDefault objectForKey:PHONENUM]];;
    
    return key;
    
}

-(NSString *)getMD5Iv{
    
    NSString *iv = [self ivMD5WIthName: [kUserDefault objectForKey:PHONENUM]];;
                    
    return iv;
    
}

#pragma mark - AES解密

- (NSString*)decryptAESData:(NSString *)string withKey:(NSString *)key withIv:(NSString *)iv
{
    
    NSString *decodeData = [SecurityUtil decryptAESData256:string withKey:key withIv:iv];
    
    return decodeData;
}

#pragma mark - AES加密

- (NSString*)EncryptAESData:(NSString *)string withKey:(NSString *)key withIv:(NSString *)iv{
    
    NSString *encodeData = [SecurityUtil encryptAESData256:string withKey:key withIv:iv];
    
    
    return encodeData;
    
}


//字符串转字典
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
//字典转换为字符串
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

//加密数据
- (NSString*)encryptAESData:(NSDictionary *)dic{
    
    return   [self EncryptAESData:[self dictionaryToJson:dic] withKey:[self getMD5Key] withIv:[self getMD5Iv]];
    
}
//加密数据
- (NSString *)encryptAESDataStr:(NSString *)str{
    
    return   [self EncryptAESData:str withKey:[self getMD5Key] withIv:[self getMD5Iv]];
}

//解密数据
- (NSDictionary*)decryptAESData:(NSString *)string{
    
    NSString *key = [self keyMD5WIthName:[kUserDefault objectForKey:PHONENUM]];
    
    NSString *iv = [self ivMD5WIthName:[kUserDefault objectForKey:PHONENUM]];
    
    NSString *str = [self decryptAESData:string withKey:key withIv:iv];
    
    
    NSDictionary *dic = [self dictionaryWithJsonString:str];
    
    return dic;
    
}

@end
