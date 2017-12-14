//
//  LDFindOrChangeController.m
//  BaseFrame
//
//  Created by Miles on 2017/6/26.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import "LDFindOrChangeController.h"
#import "LDBaseNavigationController.h"
#import "LDLoginRegisterController.h"
#import "RegisterCell.h"
#import "LDSendInfoCell.h"
@interface LDFindOrChangeController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LDFindOrChangeController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改登录密码";
    
    //解决导航栏透明问题
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    
    navView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:navView];
    
    self.aTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64,SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    self.aTableView.delegate   = self;
    self.aTableView.dataSource = self;
    self.aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.aTableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.aTableView];
    
    [self.aTableView registerClass:[RegisterCell class] forCellReuseIdentifier:@"RegisterCell"];
    [self.aTableView registerClass:[LDSendInfoCell class] forCellReuseIdentifier:@"LDSendInfoCell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return SIZEFIT(10);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {
        return 272/2.;
    }
    return SIZEFIT(55);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 3) {
        LDSendInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDSendInfoCell"];
        [cell.sendBtn addTarget:self action:@selector(commitInfo) forControlEvents:UIControlEventTouchUpInside];
        [cell.sendBtn setTitle:@"提交" forState:0];
        return cell;
    }else{
        
        RegisterCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RegisterCell"];
        cell.contentTF.secureTextEntry = YES;
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text = @"原密码";
                cell.contentTF.placeholder = @"请输入原密码";
            }
                break;
            case 1:
            {
                cell.textLabel.text = @"新密码";
                cell.contentTF.placeholder = @"请输入登录密码";
            }
                break;
            case 2:
            {
                cell.textLabel.text = @"确认密码";
                cell.contentTF.placeholder = @"请输再次入密码";
            }
                break;
                
            default:
                break;
        }
        return cell;
    }
    
    
    return [UITableViewCell new];
}
-(void)commitInfo
{
    NSIndexPath *inxPath1 = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *inxPath2 = [NSIndexPath indexPathForRow:1 inSection:0];
    NSIndexPath *inxPath3 = [NSIndexPath indexPathForRow:2 inSection:0];
    
    RegisterCell *cell1 = [self.aTableView cellForRowAtIndexPath:inxPath1];
    RegisterCell *cell2 = [self.aTableView  cellForRowAtIndexPath:inxPath2];
    RegisterCell *cell3 = [self.aTableView  cellForRowAtIndexPath:inxPath3];
    
    //正则验证.......???
    
    if (cell1.contentTF.text.length < 1) {
        [Dialog toastCenter:@"输入原密码"];
        return;
    }else if (cell2.contentTF.text.length <1){
        [Dialog toastCenter:@"请输入新密码"];
    }else if (cell3.contentTF.text.length < 1){
        [Dialog toastCenter:@"请输入确认密码"];
    }else if (![cell2.contentTF.text isEqualToString:cell3.contentTF.text]){
        [Dialog toastCenter:@"两次密码不一致请重新输入"];
        return;
    }
    
    [self requestWithOldPsw:cell1.contentTF.text NewPsw:cell3.contentTF.text];
}

- (void)requestWithOldPsw:(NSString *)oldPew NewPsw:(NSString *)newPsw//发送请求
{
    
    ws(bself);
    
    NSDictionary *param = @{
                            @"aa":@"a",
                            @"bb":@"b",
                            @"token":[kUserDefault objectForKey:TOKEN],
                            };
    
    [[APIManager sharedManager] resetPswWithData:param CallBack:^(id data) {
        
    } fail:^(NSString *errorString) {
        
    }];
    
//    [ToolManager showWithMessage:@"正在提交..."];
    
//    [[APIManager sharedManager]changeUserPswWithInfo:param Block:^(id data) {
//
//        [ToolManager dismiss];
//         RC001;
//        [kUserDefault removeObjectForKey:TOKEN];
//        [NSNotic_Center postNotificationName:LOGOUTSUCCESS object:nil];
//         [Dialog toastCenter:@"密码修改成功,请重新登录!"];
//        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//            LDBaseNavigationController *nav= [[LDBaseNavigationController alloc]initWithRootViewController:[[LDLoginRegisterController alloc] init]];
//            
//            [bself presentViewController:nav animated:YES completion:^{
//                
//                [bself.navigationController popToRootViewControllerAnimated:YES];
//                
//            }];
//        });
//        
//    } fail:^(NSString *errorString) {
//        [bself.view showCenterToast:errorString];
//    }];

}

@end
