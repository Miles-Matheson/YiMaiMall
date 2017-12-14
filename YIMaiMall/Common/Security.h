//
//  Security.h
//  BaseFrame
//
//  Created by 陈舟为 on 2017/3/15.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Security : NSObject

+(instancetype)shareSecurity;


-(NSString *)getTokenWithName:(NSString *)name withPsd:(NSString *)psd;

-(NSString *)psdMD5WithString:(NSString *)psd;

-(NSString *)nameMD5WithString:(NSString *)name;

-(NSString *)keyMD5WIthName:(NSString *)md5name;

-(NSString *)ivMD5WIthName:(NSString *)md5iv;


- (NSString*)decryptAESData:(NSString *)string withKey:(NSString *)key withIv:(NSString *)iv;


- (NSString*)EncryptAESData:(NSString *)string withKey:(NSString *)key withIv:(NSString *)iv;


-(NSString *)getMD5Key;

-(NSString *)getMD5Iv;

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

- (NSString*)dictionaryToJson:(NSDictionary *)dic;

//加密数据
- (NSString*)encryptAESData:(NSDictionary *)dic;

//加密数据
- (NSString*)encryptAESDataStr:(NSString *)str;


//解密数据
- (NSDictionary*)decryptAESData:(NSString *)string;
@end
