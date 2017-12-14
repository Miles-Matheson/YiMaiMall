//
//  NSData+AES256.h
//  YIMaiMall
//
//  Created by Miles on 2017/12/1.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonKeyDerivation.h>
@interface NSData (AES256)
+ (NSString *)AES256EncryptWithPlainText:(NSString *)plain;// withKey:(NSString *)key;        /*加密方法,参数需要加密的内容*/
+ (NSString *)AES256DecryptWithCiphertext:(NSString *)ciphertexts withKey:(NSString *)key; /*解密方法，参数数密文*/

@end  
