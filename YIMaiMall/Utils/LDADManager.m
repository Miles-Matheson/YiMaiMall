//
//  LDUMManager.m
//  FullAndFresh
//
//  Created by Miles on 2017/9/26.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDADManager.h"
//#import "UMMobClick/MobClick.h"
//#import <UMessage.h>
#import <UMSocialCore/UMSocialCore.h>
#import <UserNotifications/UserNotifications.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "XZMCoreNewFeatureVC.h"
#import <XHLaunchAd/XHLaunchAd.h>
#import "LDBaseTabBarController.h"

@implementation LDADManager

+(void)initIQKeyboardManager
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager]; //处理键盘遮挡
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
}

+(void)showADAndNAVViewWithWindow:(UIWindow *)window
{
    ws(bself);
    if([XZMCoreNewFeatureVC canShowNewFeature]){ //判断是否需要显示：（内部已经考虑版本及本地版本缓存）

        window.rootViewController = [XZMCoreNewFeatureVC newFeatureVCWithImageNames:@[@"lauch_1",@"lauch_2",@"lauch_3",@"lauch_4"] enterBlock:^{

            [bself enterMainWindow:window];

        } configuration:^(UIButton *enterButton) {  //配置进入按钮 仅在最一张图片显示

            [enterButton setTitleColor:kAppThemeColor forState:0];
            [enterButton setTintColor:kAppThemeColor];
            [enterButton  setTitle:@"立即进入" forState:0];
            enterButton.layer.borderWidth = 1.0;
            enterButton.layer.borderColor = kAppThemeColor.CGColor;
            enterButton.bounds = CGRectMake(0, 0, 120, 40);
            enterButton.center = CGPointMake(KScreenW * 0.5, KScreenH* 0.85);
        }];

    }else{
        [self enterMainWindow:window];;
    }
}

+(void)enterMainWindow:(UIWindow *)wintdow
{
    wintdow.rootViewController = [[LDBaseTabBarController alloc]init];;
}

//--2.2.2 自定义配置初始化
- (void)showCustomVideo{
    //2.自定义配置
    /**********************************************************************************************************/
    /*若你的广告图片/视频URL来源于数据请求,请在请求数据前设置等待时间,在数据请求成功回调里配置广告,如下:*/

    //1.因为数据请求是异步的,请在数据请求前,调用下面方法配置数据等待时间.
    //2.设为3即表示:启动页将停留3s等待服务器返回广告数据,3s内等到广告数据,将正常显示广告,否则将自动进入window的RootVC
    //3.数据获取成功,初始化广告时,自动结束等待,显示广告.
    //设置数据等待时间
    [XHLaunchAd setWaitDataDuration:3];//请求广告URL前,必须设置,否则会先进入window的RootVC

    //[XHLaunchAd clearDiskCache];

    ws(bself);
    //广告数据请求
    //    [[APIManager sharedManager] getADDataBlock:^(id data, NSError *error) {
    //
    //        //type  3 商品分类    4 商品详情  5 门店详情  6 H5网页
    //        // palyType 1 图片  2 视频
    //
    //        if (!error) {
    //
    //            NSDictionary *dataDic =data[@"dynamic"];
    //
    //            if (dataDic == nil) {
    //                return ;
    //            }
    //
    //            NSInteger PlayType = [dataDic[@"PlayType"] integerValue];
    //
    //            NSString * Type = (NSString *)dataDic[@"Type"];
    //
    //            NSURL *dataURL = [NSURL URLWithString:dataDic[@"Pic"]];
    //
    //            bself.Val = (NSString *)dataDic[@"Val"];
    //            bself.url = (NSString *)dataDic[@"URL"];
    //
    //            if (PlayType == 1) {//图片
    //
    //                if (!isFirstOpen) {
    //                    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
    //                    //广告停留时间
    //                    imageAdconfiguration.duration = 5;
    //                    //广告frame
    //                    imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-150);
    //                    //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
    //                    imageAdconfiguration.imageNameOrURLString = dataDic[@"Pic"];;
    //                    //网络图片缓存机制(只对网络图片有效)
    //                    imageAdconfiguration.imageOption = XHLaunchAdImageRefreshCached;
    //                    //图片填充模式
    //                    imageAdconfiguration.contentMode = UIViewContentModeScaleToFill;
    //                    //广告点击打开链接
    //                    imageAdconfiguration.openURLString =  [NSString stringWithFormat:@"%@",Type];
    //                    //广告显示完成动画
    //                    imageAdconfiguration.showFinishAnimate =ShowFinishAnimateFadein;
    //                    //广告显示完成动画时间
    //                    imageAdconfiguration.showFinishAnimateTime = 0.8;
    //                    //跳过按钮类型
    //                    imageAdconfiguration.skipButtonType = SkipTypeTimeText;
    //                    //后台返回时,是否显示广告
    //                    imageAdconfiguration.showEnterForeground = NO;
    //                    //显示开屏广告
    //                    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
    //                }
    //
    //                if ([XHLaunchAd checkImageInCacheWithURL:dataURL]) {
    //
    //                    return ;
    //                }else{
    //                    [XHLaunchAd downLoadImageAndCacheWithURLArray:@[dataURL]];
    //                }
    //
    //            }else if (PlayType == 2){//视频
    //
    //                if (!isFirstOpen) {
    //
    //                    XHLaunchVideoAdConfiguration *videoAdconfiguration = [XHLaunchVideoAdConfiguration new];
    //
    //                    videoAdconfiguration.videoNameOrURLString = dataDic[@"Pic"];
    //
    //                    videoAdconfiguration.scalingMode = MPMovieScalingModeFill;
    //                    //广告点击打开链接
    //                    videoAdconfiguration.openURLString = [NSString stringWithFormat:@"%@",Type];
    //                    //广告显示完成动画
    //                    videoAdconfiguration.showFinishAnimate =ShowFinishAnimateFadein;
    //                    //广告显示完成动画时间
    //                    videoAdconfiguration.showFinishAnimateTime = 0.8;
    //                    //跳过按钮类型
    //                    videoAdconfiguration.skipButtonType = SkipTypeTimeText;
    //                    //后台返回时,是否显示广告
    //                    videoAdconfiguration.showEnterForeground = NO;
    //                    //在此处利用服务器返回的广告数据,按上面示例添加开屏广告代码
    //                    [XHLaunchAd videoAdWithVideoAdConfiguration:videoAdconfiguration delegate:self];
    //                    //                videoAdconfiguration.customSkipView = [self customSkipView];
    //                }
    //
    //                if ([XHLaunchAd checkVideoInCacheWithURL:dataURL]) {
    //
    //                    return ;
    //                }else{
    //                    [XHLaunchAd downLoadVideoAndCacheWithURLArray:@[dataURL]];
    //                }
    //            }
    //        }
    //
    //    }];
}

//1.XHLaunchImageAdConfiguration 和XHLaunchVideoAdConfiguration 均有一个configuration.customSkipView 属性
//2.自定义一个skipView 赋值给configuration.customSkipView属性 便可替换默认跳过按钮 如下:
//configuration.customSkipView = [self customSkipView];


/**
 *  广告点击
 *
 *  @param launchAd      launchAd
 *  @param openURLString  打开页面地址
 */
- (void)xhLaunchAd:(XHLaunchAd *)launchAd clickAndOpenURLString:(NSString *)openURLString
{
    //    //type  3 商品分类    4 商品详情  5 门店详情  6 H5网页
    //    if(openURLString)
    //    {
    //        BaseTabBarController *tabVC = (BaseTabBarController *)self.window.rootViewController;
    //
    //        NSString *type = (NSString *)openURLString;
    //
    //        NSInteger index = [type integerValue];
    //
    //        //跳转到广告详情页面
    //
    //        if (index == 3) {
    //
    //            tabVC.selectedIndex = 1;
    //
    //        }else if (index == 4){
    //
    //            ClassDetailViewController*detailVC = [[ClassDetailViewController alloc] init];
    //            detailVC.ID = [self.Val integerValue];
    //            tabVC.selectedIndex = 1;
    //
    //            BaseNavigationController *nav = tabVC.selectedViewController;
    //            [nav pushViewController:detailVC animated:YES];
    //
    //        }else if (index == 5){
    //
    //            LDSellerDetailController*sellerVC = [[LDSellerDetailController alloc] init];
    //            sellerVC.shopId = self.Val;
    //            tabVC.selectedIndex = 2;
    //            BaseNavigationController *nav = tabVC.selectedViewController;
    //
    //            [nav pushViewController:sellerVC animated:YES];
    //
    //        }else if (index == 6){
    //
    //            BaseWebViewController*webVC = [[BaseWebViewController alloc] init];
    //            webVC.webType = MakeIntegral;
    //            webVC.url = self.url;
    //
    //            BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:webVC];
    //            [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
    //        }
    //    }
}


@end

