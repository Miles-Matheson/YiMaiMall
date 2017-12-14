//
//  LDLogin&RegisterController.m
//  FullAndFresh
//
//  Created by Miles on 2017/9/21.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDLoginRegisterController.h"
#import "LDFindMyPSWController.h"
//#import "LDLoginCell.h"
#import "LDLoginNewCell.h"
#import "LDRegisterNewCell.h"
#import "LDRegisterSubmitCell.h"
#import "LDYZCodeView.h"
#import "PhoneAddController.h"
@interface LDLoginRegisterController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)LDYZCodeView *codeView;
 @property(nonatomic,assign)NSInteger showCellIndex;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)int timeCount;
@end

@implementation LDLoginRegisterController

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_timer setFireDate:[NSDate distantFuture]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_timer setFireDate:[NSDate distantPast]];

}

-(NSTimer *)timer
{
    _timeCount = 10;
    if (!_timer) {
        _timer=[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timeDown) userInfo:nil repeats:YES];
        //将定时器添加到runloop中
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

-(void)timeDown{
    
    LDRegisterNewCell *registerCell = [self.aTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    [registerCell timeDown:_timeCount];
    _timeCount-- ;
    if (_timeCount < 0) {
        [_timer invalidate];
        _timer = nil;
        _timeCount = 60;
    }
}
-(void)reloadTableViewWithisRegisterVC:(BOOL)isRegister{
    
    self.navigationItem.title = isRegister?@"注册":@"登录";

    _showCellIndex = isRegister?_showCellIndex+1:_showCellIndex-1;
    
    [self.aTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:isRegister? UITableViewRowAnimationLeft:UITableViewRowAnimationRight];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"登录";
    self.navBackgroundImageView.alpha = 0;
    self.view.backgroundColor = WhiteColor;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
    [self initAtableView];

    if ([self.navigationController.childViewControllers.firstObject isKindOfClass:[LDLoginRegisterController class]] && !_showCellIndex) {//如果导航栏内第一个页面是自身 说明当前页面是模态弹出的
        [self setLeftText:nil textColor:nil ImgPath:@"close"];
    }else{

    }
    
    if (@available (iOS 11.0 ,*)) {
        self.aTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
-(void)clickLeftBtn:(UIButton *)leftBtn
{
    if (!_showCellIndex) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (_showCellIndex==1){
        if (_codeView) {
            [_codeView removeFromSuperview];
            _codeView = nil;
        }
        [self reloadTableViewWithisRegisterVC:NO];
    }else if (_showCellIndex==2){
         [self reloadTableViewWithisRegisterVC:NO];
    }
}
- (void)initAtableView{
    
    self.aTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height) style:UITableViewStyleGrouped];
    self.aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.aTableView.delegate   = self;
    self.aTableView.dataSource = self;
    self.aTableView.showsHorizontalScrollIndicator = NO;
    self.aTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.aTableView];
    self.aTableView.backgroundColor = WhiteColor;
    [self registerCustomCell];
}

- (void)registerCustomCell
{
    [self.aTableView registerNib:[UINib nibWithNibName:@"LDLoginNewCell" bundle:nil] forCellReuseIdentifier:@"LDLoginNewCell"];
    [self.aTableView registerNib:[UINib nibWithNibName:@"LDRegisterNewCell" bundle:nil] forCellReuseIdentifier:@"LDRegisterNewCell"];
    [self.aTableView registerNib:[UINib nibWithNibName:@"LDRegisterSubmitCell" bundle:nil] forCellReuseIdentifier:@"LDRegisterSubmitCell"];
}

#pragma mark UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ws(bself);
    if (!_showCellIndex) {
        LDLoginNewCell *loginCell = [tableView dequeueReusableCellWithIdentifier:@"LDLoginNewCell"];
        loginCell.selectionStyle = UITableViewCellSelectionStyleNone;
        loginCell.loginItemClick = ^(NSInteger index, LDLoginNewCell *cell) {
            [bself loginCellClickWithIndex:index Cell:cell];

        };
        return loginCell;
    }else if (_showCellIndex == 1){

        LDRegisterNewCell *registerCell = [tableView dequeueReusableCellWithIdentifier:@"LDRegisterNewCell"];
        registerCell.selectionStyle = UITableViewCellSelectionStyleNone;
        registerCell.nextClick = ^(NSInteger index, NSString *yaoQingCode, NSString *phoneNumber, NSString *zfCode) {
            
            if (index == 0) {//获取国家

                [bself choosePhoneAddressCallBack];
            }else if (index == 1){//获取验证码
                
                [bself getMessageWithMobile:phoneNumber?phoneNumber:@"" CallBack:^(BOOL success) {
                    if (success) {
                        bself.timer;
                    }
                }];
            }else if (index == 2){//下一步

                [bself reloadTableViewWithisRegisterVC:YES];
            }
        };
        return registerCell;
    }else{
        
        LDRegisterSubmitCell *submitCell = [tableView dequeueReusableCellWithIdentifier:@"LDRegisterSubmitCell"];
        submitCell.selectionStyle = UITableViewCellSelectionStyleNone;
        submitCell.submitClick = ^(NSInteger index, NSString *psw) {
            
        };
        return submitCell;
    }
}

//登录页面点击事件响应
-(void)loginCellClickWithIndex:(NSInteger)index Cell:(LDLoginNewCell *)cell
{
    
    /*
     0 登录
     1 忘记密码
     2 去注册
     3 qq登录
     4 微信登录
     5 微
     6 获取国家地区
     */
    
    if (index == 0) {

        [self loginRequestWithPsw:cell.pswTF.text phone:cell.pswTF.text];

    }else if (index == 1){
        [self.navigationController pushViewController:[LDFindMyPSWController new] animated:YES];
    }else if (index == 2) {
        [self reloadTableViewWithisRegisterVC:YES];
    }else if (index == 6){//6 获取国家地区
        [self choosePhoneAddressCallBack];
    }else{//微信登录
        //
        
//        [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
//            if (error) {
//
//                //微信授权失败
//
//            } else  if (result != nil) {
//                UMSocialUserInfoResponse *resp = result;
//                [self ThirdLoginWithType:@"wx" withUID:resp.uid];
//            }
//        }];
    }
}
//注册页面点击页面响应
-(void)registerCellClickWithIndex:(NSInteger)index Cell:(LDRegisterNewCell *)cell
{
    if (index == 0) {
        
    }else if (index == 1){//注册

    }else{//用户协议
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.aTableView) {
        CGFloat offset = scrollView.contentOffset.y + SIZEFIT(163);
//        headBgView.frame = CGRectMake(0, 0, kScreenWidth, offset - SIZEFIT(163));
    }
}

-(void)getcodeimagewithPath:(NSString *)path
{
    ws(bself);
    [LLNetworkEngine getWithUrl:path paraDic:@{@"22":@""} successBlock:^(BOOL isSuccess, NSString *message, id jsonObj) {
        
        if (isSuccess) {
            bself.codeView.codeImage =  [UIImage imageWithData:jsonObj];
        }else{
            [self.view showCenterToast:message];
        }
    } failedBlock:^(NSError *error) {
        
    }];
}


-(void)registNewAccountWithInfoWithMobile:(NSString *)mobile Psw:(NSString *)psw Code:(NSString *)code
{
    ws(bself);
    
    NSString *ticksid   = [kUserDefault objectForKey:TICKSID];
    NSString *ticks     = [kUserDefault objectForKey:TICKS];
    
    NSDictionary *param = @{
                            @"ticksid":ticksid?ticksid:@"",
                            @"ticks":ticks?ticks:@"",
                            @"mobile":mobile?mobile:@"",
                            @"password":psw?psw:@"",
                            @"mobilecode":code?code:@"",
                            @"device_token":@"",
                            };
    
//    NSString *token = [MySecurity getTokenWithName:mobile?mobile:@"" withPsd:psw?psw:@""];

}

- (void)getTicksIdRequestCallBack:(void(^)(void))callBack
{

}

- (void)loginRequestWithPsw:(NSString *)psw phone:(NSString *)phone
{
    ws(bself);

    if (![LLUtils validateMobile:phone]) {
        
        [self.view showCenterToast:@"请输入正确的手机号"];
        return;
    }else if (phone.length == 0 ){
        
        [self.view showCenterToast:@"请输入密码"];
        return;
    }

    NSString *device_token = kUUID;
    
    NSDictionary * dataInfo = @{
                                @"phone":phone?phone:@"",
                                @"password":psw?psw:@"",
                                @"clientId":device_token?device_token:@"",//客户端唯一标识
                                @"pushId":device_token?device_token:@"",//
                                @"phoneModel":@"ios",
                                };
    
    [[APIManager sharedManager] userMobileLoginWithData:dataInfo CallBack:^(id data) {
        
//  RC001;
        
        NSString *timestamp = [kUserDefault objectForKey:@"timestamp"];
        
        NSString *usetToken = data[@"obj"][@"usertoken"];
        
         //MD5Util.MD5_32(time+ ""+ clientId + "" + phone + "" userToken)
        NSString *token = [NSString stringWithFormat:@"%@ %@ %@ %@",timestamp,device_token,phone,usetToken?usetToken:@""];
        token = [token md5];

        [kUserDefault setObject:token?token:@"" forKey:TOKEN];
        [kUserDefault synchronize];
        [NSNotic_Center postNotificationName:LOGINSUCCESS object:nil];
        
        [Dialog toastCenter:@"登录成功!"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            [bself dismissViewControllerAnimated:YES completion:nil];
        });
    } fail:^(NSString *errorString) {
        
    }];
}


-(void)choosePhoneAddressCallBack{
    
    ws(bself);
    PhoneAddController *addVC = [[PhoneAddController alloc]init];
    addVC.title = @"选择国家和地区";
    addVC.itemClickCallBack = ^(NSString *phoneName) {
        
        if (bself.showCellIndex == 0) {
            LDLoginNewCell *cell = [bself.aTableView cellForRowAtIndexPath:[ NSIndexPath indexPathForRow:0 inSection:0]];
            [cell.chooseCountryButton setTitle:phoneName forState:UIControlStateNormal];
        }else{
            LDRegisterNewCell *cell = [bself.aTableView cellForRowAtIndexPath:[ NSIndexPath indexPathForRow:0 inSection:0]];
            [cell.chooseCountryBtn setTitle:phoneName forState:UIControlStateNormal];
        }
        [bself.navigationController popViewControllerAnimated:YES];
    };
    [bself.navigationController pushViewController:addVC animated:YES];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [_timer invalidate];
    _timer = nil;
}
@end
