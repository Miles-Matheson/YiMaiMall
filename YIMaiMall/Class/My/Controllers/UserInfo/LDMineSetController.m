//
//  LDMineSetController.m
//  StairOrder
//
//  Created by Miles on 2017/8/16.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDMineSetController.h"
#import "LDSetingHeaderCell.h"
#import "LDFindOrChangeController.h"
#import "LDUpgradeController.h"


@interface LDMineSetController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation LDMineSetController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navBackgroundImageView.alpha = 1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"设置";
    
    _dataArray = [NSMutableArray array];
    
    for (int i = 0; i < 4; i ++) {
        NSMutableArray *array = [NSMutableArray array];
        if (i == 0){
            for (int a = 0; a < 2; a ++) {
                NSDictionary *dataDic = @{@"title":a == 0?@"":@"我的收货地址",@"image":a ==0?@"":@""};
                [array addObject:dataDic];
            }
        }else if (i == 1) {
            for (int a = 0; a < 4; a ++) {
                NSDictionary *dataDic = @{@"title":a == 0?@"帮助中心":a== 1?@"自助申请":a==2?@"我要咨询":@"我要升级",@"image":@""};
                [array addObject:dataDic];
            }
        }else if (i == 2){
            for (int a = 0; a < 3; a ++) {
                NSDictionary *dataDic = @{@"title":a == 0?@"隐私":a== 1?@"通用":i==2?@"账户与安全":@"关于颐脉商城",@"image":@""};
                [array addObject:dataDic];
            }
        }
        [_dataArray addObject:array];
    }
    
    [self initTableView];
    [self createBottomView];
}

-(void)createBottomView{
    ws(bself);
    UIButton *bottomBtn = [ViewCreate    createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"退出当前账号" titleColor:WhiteColor font:kFont17 backgroundColor:kAppThemeColor touchUpInsideEvent:^(UIButton *sender) {
        [bself logOutAccountCallBack:^(BOOL success) {
            if (success) {
                [[NSNotificationCenter defaultCenter] postNotificationName:LOGOUTSUCCESS object:nil];
                [bself.navigationController popViewControllerAnimated:YES];
            }
        }];
    }];
    [self.view addSubview:bottomBtn];
    
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.offset(0);
    }];
}

- (void)initTableView{
    
    self.aTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.size.height-50) style:UITableViewStyleGrouped];
     self.aTableView.delegate   = self;
     self.aTableView.dataSource = self;
    self.aTableView.separatorColor = RGB(236, 236, 236);
     self.aTableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview: self.aTableView];
    
    [self.aTableView registerNib:[UINib nibWithNibName:@"LDSetingHeaderCell" bundle:nil] forCellReuseIdentifier:@"LDSetingHeaderCell"];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 && indexPath.section == 0    ) {
         return SIZEFIT(90);
    }
    return SIZEFIT(50);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = _dataArray[section];
    return array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0 && indexPath.row == 0) {
        LDSetingHeaderCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"LDSetingHeaderCell"];
        return headerCell;
    }
    
    NSDictionary *dataDic = _dataArray[indexPath.section][indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = dataDic[@"title"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {//修改登录密码
//        if ( ![self isLogin]) {
//            [self.view showCenterToast:@"亲还没有登录哦~"];
//            return;
//        }
//
        [self.navigationController pushViewController:[LDFindOrChangeController new] animated:YES];
        
    }else if(indexPath.section == 1 ){
        
        if (indexPath.row == 0) {
            
        }else if (indexPath.row == 1){
            
        }else if (indexPath.row == 2){
            
        }else if (indexPath.row == 3){
            [self.navigationController pushViewController:[LDUpgradeController new] animated:YES];
        }
    }
}


- (void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
