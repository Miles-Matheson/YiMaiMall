//
//  PayManager.m
//  BaseFrame
//
//  Created by 陈舟为 on 2017/5/14.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import "PayManager.h"
#import "DataSigner.h"
#import "payRequsestHandler.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "MMPopupWindow.h"
#import "MMAlertView.h"
#import "MMPopupView.h"

static PayManager *_payManager = nil;

@implementation PayManager

+(instancetype)shareManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _payManager = [[PayManager alloc] init];
        
    });
    
    return _payManager;
}

-(void)aliPay:(Order*)order success:(void (^)(NSDictionary *resultDic))success{
    //    if(![self checkExsitAlipay]){
    //        return;
    //    }
    /*
     BuyType  -----1
     BuyNO  -----订单号
     Price  -----价格
     Mobile  -----手机号
     PrePayID  -----null
     NotifyUrl  -----回调URL
     Title  ----- 商品详情
     GoodName  -----商品标题
     */
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = aliPaypartner;
    NSString *seller =aliPaySeller;
    NSString *privateKey = aliPayPrivateKey;
    /*============================================================================*/
    /*============================================================================*/
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    order.partner = partner;
    order.seller = seller;
    //  order.tradeNO = self.dinghao; //订单ID（由商家自行制定）
    // order.productName = self.dingdanname; //商品标题
    // order.productDescription = self.dingdanDetail; //商品描述
    
    
    
#pragma warn  待改  价格回调URL
    // order.amount = @"0.01";
    // order.amount = self.dingdanmoney;
    //    order.notifyURL = order.notifyURL;//@"http://120.26.124.121:8088/pay/notify_url.aspx"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //  NSLog(@"%@  %@  %@  %@",mitem.BuyNO,mitem.GoodName,mitem.Title,mitem.NotifyUrl);
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"feixiansheng2017";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    //    NSLog(@"orderSpec||||| %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil)
    {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        NSLog(@"orderString\\\%@",orderString);
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:success];
    }
}


-(NSMutableDictionary *)VEComponentsStringToDic:(NSString*)AllString withSeparateString:(NSString *)FirstSeparateString AndSeparateString:(NSString *)SecondSeparateString{
    
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    
    NSArray *FirstArr=[AllString componentsSeparatedByString:FirstSeparateString];
    
    for (int i=0; i<FirstArr.count; i++) {
        NSString *Firststr=FirstArr[i];
        NSArray *SecondArr=[Firststr componentsSeparatedByString:SecondSeparateString];
        [dic setObject:SecondArr[1] forKey:SecondArr[0]];
        
    }
    
    return dic;
}

- (void)sendPay_demo:(Order*)orderEntity
{
    //{{{
    //本实例只是演示签名过程， 请将该过程在商户服务器上实现
    
    //创建支付签名对象
    payRequsestHandler *req = [[payRequsestHandler alloc] init];
    //初始化支付签名对象
    [req init:APP_ID mch_id:MCH_ID];
    //设置密钥
    [req setKey:PARTNER_ID];
    
    //}}}
    
    //获取到实际调起微信支付的参数后，在app端调起支付
    NSMutableDictionary *dict = [req sendPay_demo:orderEntity];
    
    if(dict == nil){
        //错误提示
        NSString *debug = [req getDebugifo];
        
        [self alert:@"提示信息" msg:debug];
        
        NSLog(@"%@\n\n",debug);
    }else{
        NSLog(@"%@\n\n",[req getDebugifo]);
        //        [self alert:@"确认" msg:@"下单成功，点击OK后调起支付！"];
        
        NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
        
        //调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        req.openID              = [dict objectForKey:@"appid"];
        req.partnerId           = [dict objectForKey:@"partnerid"];
        req.prepayId            = [dict objectForKey:@"prepayid"];
        req.nonceStr            = [dict objectForKey:@"noncestr"];
        req.timeStamp           = stamp.intValue;
        req.package             = [dict objectForKey:@"package"];
        req.sign                = [dict objectForKey:@"sign"];
        
        [WXApi sendReq:req];
    }
}

- (void)WeiXinPay{
    
    if([WXApi isWXAppInstalled]) // 判断 用户是否安装微信
    {
        //   [self getAccessToken];
    }else{
        [self alert:@"提示" msg:@"您未安装微信!"];
    }
    
}


//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
    
}

#pragma mark - 发起支付请求
- (void)WXPayRequest:(NSString *)appId nonceStr:(NSString *)nonceStr package:(NSString *)package partnerId:(NSString *)partnerId prepayId:(NSString *)prepayId timeStamp:(NSString *)timeStamp sign:(NSString *)sign{
    //调起微信支付
    PayReq* wxreq             = [[PayReq alloc] init];
    wxreq.openID              = WXAppId;
    wxreq.partnerId           = WXPartnerId;
    wxreq.prepayId            = prepayId;
    wxreq.nonceStr            = nonceStr;
    wxreq.timeStamp           = [timeStamp intValue];
    wxreq.package             = package;
    wxreq.sign                = sign;
    [WXApi sendReq:wxreq];
}

#pragma mark - 通知信息
- (void)getOrderPayResult:(NSNotification *)notification{
    if ([notification.object isEqualToString:@"success"])
    {
        // [self checkVip];
        //  [self alert:@"恭喜" msg:@"您已成功支付啦!"];
    }
    else
    {
        [self alert:@"提示" msg:@"支付失败"];
        
    }
}



@end
