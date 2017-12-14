//
//  PayOrderViewController.m
//  BaseFrame
//
//  Created by 陈舟为 on 2017/6/28.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import "PayOrderViewController.h"
#import "LDBaseNavigationController.h"
#import "LDOrderObLineBaseController.h"

#import "ShopCartBaseController.h"
#import "MyBaseController.h"
#import "LDSendInfoCell.h"
#import "WXApi.h"
#import "APOrderInfo.h"
#import <AlipaySDK/AlipaySDK.h>
#import <APAuthInfo.h>
#import "APRSASigner.h"


@interface PayOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,copy)NSString *Credit;
@property(nonatomic,strong)NSArray *imgArr,*subTitArr;
@property(nonatomic,strong)UIButton *btn_1,*btn_2,*btn_3,*btn_4;
@end

@implementation PayOrderViewController


-(UIButton *)btn_1{
    if (_btn_1 == nil) {
        
        _btn_1 = [[UIButton alloc] init];
        [_btn_1 setImage:[UIImage imageNamed:@"choose4"] forState:UIControlStateNormal];
        [_btn_1 setImage:[UIImage imageNamed:@"choose3"] forState:UIControlStateSelected];
        _btn_1.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _btn_1.userInteractionEnabled = NO;
    }
    return _btn_1;
}

-(UIButton *)btn_3{
    if (_btn_3 == nil) {
        
        _btn_3 = [[UIButton alloc] init];
        [_btn_3 setImage:[UIImage imageNamed:@"choose4"] forState:UIControlStateNormal];
        [_btn_3 setImage:[UIImage imageNamed:@"choose3"] forState:UIControlStateSelected];
        _btn_3.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _btn_3.userInteractionEnabled = NO;
    }
    return _btn_3;
}

-(UIButton *)btn_4{
    if (_btn_4 == nil) {
        
        _btn_4 = [[UIButton alloc] init];
        [_btn_4 setImage:[UIImage imageNamed:@"choose4"] forState:UIControlStateNormal];
        [_btn_4 setImage:[UIImage imageNamed:@"choose3"] forState:UIControlStateSelected];
        _btn_4.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _btn_4.userInteractionEnabled = NO;
    }
    return _btn_4;
}

-(UIButton *)btn_2{
    
    if (_btn_2 == nil) {
        _btn_2 = [[UIButton alloc] init];
        [_btn_2 setImage:[UIImage imageNamed:@"choose4"] forState:UIControlStateNormal];
        [_btn_2 setImage:[UIImage imageNamed:@"choose3"] forState:UIControlStateSelected];
        _btn_2.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _btn_2.userInteractionEnabled = NO;
    }
    return _btn_2;
}

-(void)WXPayFailed{
    [Dialog toastCenter:@"微信支付失败"];
}
-(void)WXPaySuccess{
    ws(bself);
    [Dialog toastCenter:@"微信支付成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [bself payFinish];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单支付";
    
    //解决导航栏透明问题
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navView];
    
    self.imgArr = @[@"pay_1",@"pay_2",@"pay_3",@"pay_4"];
    self.subTitArr = @[@"商城支付",@"支付宝支付",@"微信支付",@"银联支付"];
    
    [self createTableView];
    
    [self setLeftText:nil textColor:WhiteColor ImgPath:@"back"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WXPaySuccess) name:@"WXPaySuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WXPayFailed) name:@"WXPayFailed" object:nil];
}

-(void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [UIView new];
    _tableView.sectionFooterHeight = CGFLOAT_MIN;
    _tableView.sectionHeaderHeight = 10;
    
    [_tableView registerClass:[LDSendInfoCell class] forCellReuseIdentifier:@"LDSendInfoCell"];
}


-(void)clickLeftBtn:(UIButton *)leftBtn
{
    ws(bself);
    [LLUtils showAlterView:self title:@"温馨提示" message:@"您还没有支付，确定返回吗？" yesBtnTitle:@"确定" noBtnTitle:@"取消" yesBlock:^{
        //这里如果是从购物车进来就要发通知刷新购物车
        if ([bself.navigationController.childViewControllers.firstObject isKindOfClass:[ShopCartBaseController class]]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:ORDERSUBMITFINISH object:@0];
        }
        //我的界面数量更新
        [[NSNotificationCenter defaultCenter] postNotificationName:USERINFOCHANGE object:nil];
        
        [bself.navigationController popToRootViewControllerAnimated:YES];
    } noBlock:^{
        
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return section==0?2:section==1?self.subTitArr.count:1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ws(bself);
    if (indexPath.section == 0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell0"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell0"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.row == 0) {
            
            cell.textLabel.text = @"订单金额";
            cell.detailTextLabel.textColor = kAppSubThemeColor;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"¥%.2lf",_orderAmount];
        }else{
            cell.textLabel.text = @"可用余额";
            cell.detailTextLabel.textColor = RGB(51, 51, 51);
            cell.detailTextLabel.text = [NSString stringWithFormat:@"¥%.2lf",_orderAmount];
        }
        return cell;
    }else if (indexPath.section == 1){
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell1"];
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
            line.backgroundColor = RGB(230, 230, 230);
            [cell.contentView addSubview:line];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
        }
        cell.imageView.image = [UIImage imageNamed:self.imgArr[indexPath.row]];
        cell.textLabel.text = self.subTitArr[indexPath.row];
        
        if (indexPath.row == 0) {
            
            [cell.contentView addSubview:self.btn_1];
            [self.btn_1 mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.offset(0);
                make.right.offset(-10);
                make.size.sizeOffset(CGSizeMake(20, 20));
            }];
        }else  if (indexPath.row == 1) {
            
            [cell.contentView addSubview:self.btn_2];
            [self.btn_2 mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.offset(0);
                make.right.offset(-10);
                make.size.sizeOffset(CGSizeMake(20, 20));
            }];
        }else if (indexPath.row == 2){
            
            [cell.contentView addSubview:self.btn_3];
            [self.btn_3 mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.offset(0);
                make.right.offset(-10);
                make.size.sizeOffset(CGSizeMake(20, 20));
            }];
        }else{
            
            [cell.contentView addSubview:self.btn_4];
            [self.btn_4 mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.offset(0);
                make.right.offset(-10);
                make.size.sizeOffset(CGSizeMake(20, 20));
            }];
        }
        
        return cell;
        
    }else{
        
        LDSendInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDSendInfoCell"];
        [cell.sendBtn setTitle:@"确认支付" forState:0];
        cell.sendBtnClick = ^{
            if (bself.btn_1.selected) {
                
                [bself balancePay];
                
            }else if (bself.btn_2.selected) {
                
                [bself alipay];
                
            }else if (bself.btn_3.selected) {
                [bself weiChatPay];
                
            }else if (bself.btn_4.selected) {
                //                [bself weiChatPay];
                [Dialog toastCenter:@"银联支付"];
            }else{
                [Dialog toastCenter:@"请选择支付方式"];
            }
        };
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section != 2) {
        return SIZEFIT(55);
    }else{
        return 100;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            self.btn_1.selected = !self.btn_1.selected;;
            self.btn_2.selected = NO;
            self.btn_3.selected = NO;
            self.btn_4.selected = NO;
        }else if (indexPath.row == 1) {
            
            self.btn_2.selected = !self.btn_2.selected;
            self.btn_1.selected = NO;
            self.btn_3.selected = NO;
            self.btn_4.selected = NO;
        }else if (indexPath.row == 2){
            
            self.btn_3.selected = !self.btn_3.selected;;
            self.btn_2.selected = NO;
            self.btn_1.selected = NO;
            self.btn_4.selected = NO;
        }else if (indexPath.row == 3){
            
            self.btn_4.selected = !self.btn_4.selected;;
            self.btn_2.selected = NO;
            self.btn_1.selected = NO;
            self.btn_3.selected = NO;
        }
        
    }
}

//微信支付
-(void)weiChatPay{
    
    NSDictionary *param = @{
                            @"id":self.orderID,
                            };
    [[APIManager sharedManager] weiChatPayWithData:param CallBack:^(id data) {
        
        RC001;
        
        NSDictionary *dataDic =  data[@"obj"];
        if (dataDic) {
            
            NSString *prepayid = dataDic[@"prepayid"];
            //             NSString *orderId = dataDic[@"orderId"];
            NSString *partnerid = dataDic[@"partnerid"];
            NSString *package = dataDic[@"package"];
            NSString *noncestr = dataDic[@"noncestr"];
            NSString *timestamp = dataDic[@"timestamp"];
            NSString *sign = dataDic[@"sign"];
            NSString *appid = dataDic[@"appid"];
            
            PayReq *payReq =  [[PayReq alloc]init];
            
            payReq.prepayId =  prepayid?prepayid:@"";
            payReq.partnerId = partnerid?partnerid:@"";
            payReq.package   = package?package:@"";
            payReq.nonceStr  = noncestr?noncestr:@"";
            payReq.timeStamp = timestamp.intValue;
            payReq.sign      = sign?sign:@"";
            payReq.openID    = appid?appid:@"";
            
            //发送请求到微信，等待微信返回onResp
            [WXApi sendReq:payReq];
        }
    } fail:^(NSString *errorString) {
        
    }];
}


//余额支付
-(void)balancePay{
    
    
}

//支付宝支付
-(void)alipay{
    
    // 重要说明
    // 这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    // 真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    // 防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *pid = @"";
    NSString *appID = @"";
    
    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
    NSString *rsa2PrivateKey = @"";
    NSString *rsaPrivateKey = @"";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //pid和appID获取失败,提示
    if ([pid length] == 0 ||[appID length] == 0 ||([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0)){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"缺少pid或者appID或者私钥,请检查参数设置" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault  handler:^(UIAlertAction *action){
            
        }];
        
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:^{ }];
        return;
    }
    
    //生成 auth info 对象
    APAuthInfo *authInfo = [APAuthInfo new];
    authInfo.pid = pid;
    authInfo.appID = appID;
    
    //auth type
    NSString *authType = [[NSUserDefaults standardUserDefaults] objectForKey:@"authType"];
    if (authType) {
        authInfo.authType = authType;
    }
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"alisdkdemo";
    
    // 将授权信息拼接成字符串
    NSString *authInfoStr = [authInfo description];
    NSLog(@"authInfoStr = %@",authInfoStr);
    
    // 获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    
    APRSASigner* signer = [[APRSASigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:authInfoStr withRSA2:YES];
    } else {
        signedString = [signer signString:authInfoStr withRSA2:NO];
    }
    
    // 将签名成功字符串格式化为订单字符串,请严格按照该格式
    if (signedString.length > 0) {
        authInfoStr = [NSString stringWithFormat:@"%@&sign=%@&sign_type=%@", authInfoStr, signedString, ((rsa2PrivateKey.length > 1)?@"RSA2":@"RSA")];
        
        [[AlipaySDK defaultService] auth_V2WithInfo:authInfoStr fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            
            NSString *authCode = nil;
            
            if (result.length>0) {
                
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
}

//支付完成
-(void)payFinish{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ORDERSUBMITFINISH object:@1];
    [[NSNotificationCenter defaultCenter] postNotificationName:ORDERCHANGE object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:USERINFOCHANGE object:nil];
    
    ws(bself);
    
    if ([self.navigationController.childViewControllers.firstObject isKindOfClass:[MyBaseController class]]){
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [bself.navigationController popViewControllerAnimated:YES];
        });
        
    }else{
        
        
        LDOrderObLineBaseController *ordersVc = [[LDOrderObLineBaseController alloc] init];
        [ordersVc createLeftBtn];
        LDBaseNavigationController *baseNav = [[LDBaseNavigationController alloc] initWithRootViewController:ordersVc];

        [self presentViewController:baseNav animated:YES completion:^{
            [bself.navigationController popToRootViewControllerAnimated:YES];
        }];
    }
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];;
}

@end
