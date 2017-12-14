//
//  BaseWebViewController.h
//  BaseFrame
//
//  Created by 陈舟为 on 2017/4/1.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

typedef NS_ENUM(NSInteger,webType){
    
    AboutWe = 1,//关于我们
    ContactWe,//联系我们
    Announcement,//通知公告 /Other
    VersionInformation,//版本信息
    MakeIntegral,//赚积分 
};

@interface LDBaseWebViewController : UIViewController

+(LDBaseWebViewController *)loadURLWithString:(NSString *)urlString;

@property (nonatomic,copy)NSString *requestUrlString;
@property (nonatomic,copy)NSString *loadHTMLString;

@end
