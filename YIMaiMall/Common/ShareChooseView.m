//
//  ShareChooseView.m
//  BaseFrame
//
//  Created by 陈舟为 on 2017/7/13.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import "ShareChooseView.h"
#import "CustomVerticalBtn.h"
#import <UMSocialCore/UMSocialCore.h>

@implementation ShareModel

@end

@implementation ShareChooseView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.type = MMPopupTypeSheet;
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
            make.height.mas_equalTo(140);
            
        }];
        
        
        [self initUI];
        
    }
    
    return self;
}

-(void)initUI{
    
    UIView *shareBgView = [[UIView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 140)];
    
    [self addSubview:shareBgView];
    
    NSArray *imgArr = @[@"icon_share1",@"icon_share2",@"icon_share3",@"icon_share4"];
    
    NSArray *titArr = @[@"微信好友",@"QQ",@"QQ空间",@"朋友圈"];
    
    CGFloat width = SCREEN_WIDTH / 4;
    
    for (int i = 0; i < 4; i ++) {
        
        CustomVerticalBtn *btn = [[CustomVerticalBtn alloc] initWithFrame:CGRectMake(i * width, 10,width,90)];
        
        btn.imgName = imgArr[i];
        
        btn.platformName = titArr[i];
        
        btn.font = 16;
        
        btn.color = RGB(39, 39, 39);
        
        btn.tag = 600 + i;
        
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [shareBgView addSubview:btn];
        
    }

    
}

-(void)setModel:(ShareModel *)model{
    
    _model = model;
    
}


-(void)btnAction:(UIButton *)btn{
    
    if (btn.tag == 600) {
        
        [self shareWXHY];
        
    }
    
    if (btn.tag == 601) {
        
        [self shareQQ];
        
    }
    
    if (btn.tag == 602) {
        
        [self shareQQKJ];
        
    }
    
    if (btn.tag == 603) {
        
        [self shareWXPYQ];
        
    }
    
}


//微信好友
-(void)shareWXHY{
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL =  self.model.SharePic;
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.model.Title descr:self.model.ShareContent thumImage:thumbURL];
    
    //设置网页地址
    shareObject.webpageUrl = self.model.URL;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            
            [Dialog toastCenter:@"分享失败"];
            
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
                [Dialog toastCenter:@"分享成功"];
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
    
}

//QQ好友
-(void)shareQQ{
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL =  self.model.SharePic;
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.model.Title descr:self.model.ShareContent thumImage:thumbURL];
    
    //设置网页地址
    shareObject.webpageUrl = self.model.URL;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_QQ messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            
            [Dialog toastCenter:@"分享失败"];
            
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
                [Dialog toastCenter:@"分享成功"];
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        //        [Dialog showError:error];
    }];
    
    
}

//QQ空间
-(void)shareQQKJ{
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL =  self.model.SharePic;
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.model.Title descr:self.model.ShareContent thumImage:thumbURL];
    
    //设置网页地址
    shareObject.webpageUrl = self.model.URL;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Qzone messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            //            UMSocialLogInfo(@"************Share fail with error %@*********",error);
            [Dialog toastCenter:@"分享失败"];
            
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
                [Dialog toastCenter:@"分享成功"];
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        //        [Dialog showError:error];
    }];
    
    
}

//微信朋友圈
-(void)shareWXPYQ{
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL =  self.model.SharePic;
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.model.Title descr:self.model.ShareContent thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = self.model.URL;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatTimeLine messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            //            UMSocialLogInfo(@"************Share fail with error %@*********",error);
            [Dialog toastCenter:@"分享失败"];
        
            
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
                [Dialog toastCenter:@"分享成功"];
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
//                [Dialog showError:error];
    }];
    
}


@end
