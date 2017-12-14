//
//  LLUMengManager.m
//  StoreIntegral
//
//  Created by kevin on 2017/1/6.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

#import "LLUMengManager.h"

@implementation LLUMengManager

+ (instancetype)sharedInstance
{
    static LLUMengManager *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (void)initUMmanger {
    /* 打开调试日志 */
    //    [[UMSocialManager defaultManager] openLog:YES];

    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"59786d485312dd4eb6000a78"];
    
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx7db7e5982abe238e" appSecret:@"e018048834de7ee61744d31a1840eb94" redirectURL:@"http://mobile.umeng.com/social"];
    
    //设置分享到QQ互联的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106224604"  appSecret:@"Hark1guWrY24hhqe" redirectURL:@"http://mobile.umeng.com/social"];
    
    [self configUSharePlatforms];
}

- (void)configUSharePlatforms{
    
    [UMSocialUIManager removeCustomPlatformWithoutFilted:UMSocialPlatformType_Sina];
    
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Tim),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatFavorite),@(UMSocialPlatformType_WechatTimeLine)]];
}

/**
 弹出分享面板 分享文字和图片
 */
- (void)showShareMenuView:(NSString *)title content:(NSString *)content img:(id)img redirectURL:(NSString *)redirectURL CompletionHandler:(ShareSuccessCallback)successCallback{
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        [self share:title content:content img:img redirectURL:redirectURL platformType:platformType CompletionHandler:^(BOOL isSuccess) {
            successCallback(isSuccess);
        }] ;
    }];
}

/**
 弹出分享面板,分享大图
 */
- (void)showShareMenuView:(id)img CompletionHandler:(ShareSuccessCallback)successCallback{
    
    ws(bself);
    
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)]];
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        [bself share:img platformType:platformType CompletionHandler:^(BOOL isSuccess) {
            
            successCallback(isSuccess);
        }];
    }];
}

/**
 分享大图
 */
- (void)share:(id)img platformType:(UMSocialPlatformType)platformType CompletionHandler:(ShareSuccessCallback)successCallback{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    
    UMShareImageObject *imgObject = [[UMShareImageObject alloc] init];
    
    //设置网页地址
    imgObject.shareImage = img;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = imgObject;
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:[LLUtils getCurrentVC] completion:^(id data, NSError *error) {
        if (!error) {
            
            NSLog(@"successCallback yes");
            successCallback(YES);
        } else {

            NSLog(@"successCallback no");
            successCallback(NO);
        }
    }];
}

/**
  分享
 */
- (void)share:(NSString *)title content:(NSString *)content img:(id)img redirectURL:(NSString *)redirectURL platformType:(UMSocialPlatformType)platformType CompletionHandler:(ShareSuccessCallback)successCallback{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:content thumImage:img];
    //设置网页地址
    shareObject.webpageUrl = redirectURL;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:[LLUtils getCurrentVC] completion:^(id data, NSError *error) {
        if (!error) {
            [LLUtils showSuccessHudWithStatus:@"分享成功"];
            successCallback(YES);
        } else {
            [LLUtils showErrorHudWithStatus:@"分享失败"];
            successCallback(NO);
        }
    }];
}

- (void)shareWithContent:(NSString *)content platformType:(UMSocialPlatformType)platformType{
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.text = content;
    
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:[LLUtils getCurrentVC] completion:^(id data, NSError *error) {
        if (!error) {
            [LLUtils showSuccessHudWithStatus:@"分享成功"];
        } else {
            [LLUtils showErrorHudWithStatus:@"分享失败"];
        }
    }];
}

/**
 第三方授权登录
 */
- (void)getAuthWithUserInfo:(UMSocialPlatformType)platform callback:(ThirdPartLoginCallback)callback{
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platform currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            if (callback) {
                callback(NO,nil);
            }
        } else {
            UMSocialUserInfoResponse *resp = result;
            if (callback) {
                callback(YES,resp);
            }
        }
    }];
}



@end
