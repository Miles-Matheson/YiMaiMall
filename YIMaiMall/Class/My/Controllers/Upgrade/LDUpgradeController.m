//
//  LDUpgradeController.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/29.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDUpgradeController.h"
#import "LDUpgradeCell.h"
#import "LDUpgradeNoticView.h"
@interface LDUpgradeController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LDUpgradeController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.navBackgroundImageView.alpha = 0;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear: animated];
     self.navBackgroundImageView.alpha = 1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBackgroundImageView.alpha = 0;
    [self setTitleTtextColor:WhiteColor];
    
    self.navigationItem.title = @"我要升级";
    
    [self initTableView];
}

-(void)initTableView{
    
    self.aTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.aTableView.delegate  = self;
    self.aTableView.dataSource  = self;
    [self.view addSubview:self.aTableView];
    
    if (@available (iOS 11.0 ,*)) {
        self.aTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self registerCell];
}
-(void)registerCell{
    
    [self.aTableView registerNib:[UINib nibWithNibName:@"LDUpgradeCell" bundle:nil] forCellReuseIdentifier:@"LDUpgradeCell"];
    [self.aTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_HEIGHT;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ws(bself);
    LDUpgradeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDUpgradeCell"];
    cell.upgradeClick = ^{
        [bself showUpgradeNoticView];
    };
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


-(void)showUpgradeNoticView{
    
    LDUpgradeNoticView *noticView = [[LDUpgradeNoticView alloc]initWithFrame:KeyWindow.bounds];
    noticView.agreeItemClick = ^{
        
        [LDAlterView  alterViewWithTitle:@"温馨提示" content:@"您已提交申请，请耐心等待，颐脉工作人员会及时联系您，请保持电话畅通" cancel:nil sure:@"确定" cancelBtClcik:nil  sureBtClcik:^{
            
        }];
    };
    [KeyWindow addSubview:noticView];
}

@end
