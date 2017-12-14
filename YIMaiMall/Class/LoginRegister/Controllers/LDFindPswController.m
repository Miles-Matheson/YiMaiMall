//
//  LDFindPswController.m
//  FullAndFresh
//
//  Created by Miles on 2017/9/26.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDFindPswController.h"
#import "RegisterCell.h"
#import "LDSendInfoCell.h"
#import "LDYZCodeView.h"

@interface LDFindPswController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL _isSecondVC;
}

@property(nonatomic,strong)LDYZCodeView *codeView;

@end

@implementation LDFindPswController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self.navigationController.navigationBar setBackgroundImage:[LLUtils imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.navigationController.navigationBar setBackgroundImage:[LLUtils imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    
    if (_codeView) {
        [_codeView removeFromSuperview];
        _codeView = nil;
    }
}

-(void)reloadTableViewWithisRegisterVC:(BOOL)isSecondVC{
    
    _isSecondVC = isSecondVC;
    
    [self.aTableView reloadSections:[[NSIndexSet alloc]initWithIndex:0] withRowAnimation:_isSecondVC?UITableViewRowAnimationLeft:UITableViewRowAnimationRight];
    [self.aTableView reloadSections:[[NSIndexSet alloc]initWithIndex:1] withRowAnimation:_isSecondVC?UITableViewRowAnimationLeft:UITableViewRowAnimationRight];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"找回密码";
    
    [self initAtableView];
    
    [self setLeftText:nil textColor:nil ImgPath:@"go_left"];
}
-(void)clickLeftBtn:(UIButton *)leftBtn
{
     if (_isSecondVC){
        [self reloadTableViewWithisRegisterVC:NO];
     }else{
         [self.navigationController popViewControllerAnimated:YES];
     }
}

- (void)initAtableView
{
    self.aTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width,self.view.bounds.size.height) style:UITableViewStyleGrouped];
    self.aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.aTableView.delegate   = self;
    self.aTableView.dataSource = self;
    self.aTableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.aTableView];
    
    [self registerCustomCell];
}

- (void)registerCustomCell
{
    [self.aTableView registerClass:[RegisterCell class] forCellReuseIdentifier:ReuseIdentifier_Normal];
    [self.aTableView registerClass:[RegisterCell class] forCellReuseIdentifier:ReuseIdentifier_Code];
    [self.aTableView registerClass:[LDSendInfoCell class] forCellReuseIdentifier:@"LDSendInfoCell"];
}

#pragma mark UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        static NSString *header = @"customHeader";
        
        UITableViewHeaderFooterView *vHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:header];
        if (!vHeader) {
            vHeader = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:header];
            UILabel *lab = [[UILabel alloc]init];
            lab.textColor = RGB(138, 138, 138);
            lab.font = [UIFont systemFontOfSize:14.0f];
            lab.text = @" 温馨提示:找回密码也可以通过";
            [vHeader addSubview:lab];
            [lab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(10);
                make.centerY.offset(0);
            }];

             NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"客服找回"];
            [attStr addAttribute:NSUnderlineStyleAttributeName
                        value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                        range:NSMakeRange(0,attStr.length)];
            [attStr addAttribute:NSForegroundColorAttributeName
                                 value:RGB(0, 131, 231)
                                 range:NSMakeRange(0,attStr.length)];
            [attStr addAttribute:NSFontAttributeName
                                 value:[UIFont systemFontOfSize:14.0f]
                                 range:NSMakeRange(0,attStr.length)];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
                //打电话 客服找回
                
                [LDAlterView alterViewWithTitle:@"400-820-8828" content:@"" cancel:@"取消" sure:@"拨打" cancelBtClcik:^{
                    
                } sureBtClcik:^{
                
                }];
            }];
            [btn setAttributedTitle:attStr forState:0];
            [vHeader addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lab.mas_right);
                make.centerY.equalTo(lab.mas_centerY);
            }];
            
        }
        return vHeader;
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 50;
    }
    return CGFLOAT_MIN;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        LDSendInfoCell *sendCell = [tableView dequeueReusableCellWithIdentifier:@"LDSendInfoCell"];
        sendCell.sendBtnClick = ^{
            if (!_isSecondVC) {
                [self reloadTableViewWithisRegisterVC:YES];
            }else{//找回密码
                
                
            }
        };
        [sendCell.sendBtn setTitle:_isSecondVC?@"确定":@"下一步" forState:0];
        return sendCell;
    }
    
    if (!_isSecondVC ) {

        if (indexPath.row == 0) {
            RegisterCell *indexCell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier_Normal];
            indexCell.contentTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
            indexCell.contentTF.autocorrectionType = UITextAutocorrectionTypeNo;
            indexCell.contentTF.returnKeyType = UIReturnKeyDone;
            indexCell.contentTF.textAlignment = Left;
            indexCell.titleWidth = 40;
            
            indexCell.imageView.image = [UIImage imageNamed:@"icon_pwd"];
            indexCell.contentTF.placeholder   = @"请输入手机号";
            indexCell.contentTF.keyboardType = UIKeyboardTypeEmailAddress;
            return indexCell;
            
        }else{
            RegisterCell *codeCell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier_Code];
            codeCell.imageView.image = [UIImage imageNamed:@"icon_key"];
            [codeCell.codeButton setTitleColor:kAppThemeColor forState:0];
            [codeCell.codeButton setTitle:@"获取验证码" forState:0];
            codeCell.contentTF.placeholder   = @"请输入验证码";
            codeCell.contentTF.keyboardType = UIKeyboardTypeNumberPad;
            codeCell.contentTF.textAlignment = Left;
            codeCell.titleWidth = 40;
            [codeCell.codeButton handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
                
                ws(bself);
                
                [bself getMobile];
            }];
            return codeCell;
        }
    }else{
        
        RegisterCell *indexCell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier_Normal];
        indexCell.contentTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
        indexCell.contentTF.autocorrectionType = UITextAutocorrectionTypeNo;
        indexCell.contentTF.returnKeyType = UIReturnKeyDone;
        indexCell.contentTF.textAlignment = Left;
        indexCell.titleWidth = 40;
        indexCell.imageView.image = [UIImage imageNamed:@"icon_pwd"];
        indexCell.contentTF.placeholder   = indexPath.row == 0?@"请重新输入密码":@"请再次输入密码";
        indexCell.contentTF.keyboardType = UIKeyboardTypeEmailAddress;
        return indexCell;
    }
    return [UITableViewCell new];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


-(void)getMobile
{
    ws(bself);
    
    RegisterCell *cell = [self.aTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    NSString *phone = cell.contentTF.text;
    
    if (![LLUtils validateMobile:phone]) {
        
        [self.view showCenterToast:@"请输入正确的手机号码"];
        return;
    }
    
    NSString *URLString = [NSString stringWithFormat:@"%@Tool/PicCode?mobile=%@",Server,phone];
    [self getcodeimagewithPath:URLString];

    
    _codeView = [[LDYZCodeView alloc]init];
    _codeView.selectImageCallBack = ^{
        
        [bself getcodeimagewithPath:URLString];
        
    };
    _codeView.sureBlock = ^(NSString *code) {

        [bself getMsgCodeWithDataDynamicWithMobile:phone Code:bself.codeView.codeTextFiled.text];
    };
    [self.view addSubview:_codeView];
    [self.view bringSubviewToFront:_codeView];
    
    
}

//获取图片验证码
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

//发送验证码确认
-(void)getMsgCodeWithDataDynamicWithMobile:(NSString *)mobile Code:(NSString *)code
{
    ws(bself);
    
    NSDictionary *param = @{
                            @"mobile":mobile?mobile:@"",
                            @"piccode":code?code:@"",
                            };
    
//    [[APIManager sharedManager]getMsgCodeWithData:param CallBack:^(id data) {
//        RC001;
//        RC002;
//        //验证码正确
//        [bself.codeView removeAllSubviews];
//        [bself.codeView removeFromSuperview];
//        bself.codeView = nil;
//
//    } fail:^(NSString *errorString) {
//
//    }];
}


@end
