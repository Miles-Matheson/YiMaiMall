//
//  MyBaseController.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/28.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "MyBaseController.h"
#import "LDMineHeaderCell.h"

#import "LDMineSetController.h"
#import "LDMineInfoController.h"

#import "LDCouponController.h"//我的优惠券
#import "LDSaveShopController.h"//店铺收藏
#import "LDSaveGoodsController.h"//商品收藏
#import "LDFootPrintController.h"//我的足迹
#import "LDOrderObLineBaseController.h"//线上订单

#import "LDAddressListController.h"


@interface MyBaseController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIView *customNavView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation MyBaseController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navBackgroundImageView.alpha = 0;
    if (self.aTableView) {
//        [self setnavColor];
        self.aTableView.delegate  = self;
    }
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setBarTintColor:WhiteColor];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navBackgroundImageView.alpha = 1;
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor blackColor]}];
    [self.navigationController.navigationBar setBarTintColor:WhiteColor];
}
-(void)clickRightBtn:(UIButton *)rightBtn{
    [self.navigationController pushViewController:[LDMineSetController new] animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人中心";
    
    [self setRightText:@"设置" textColor:WhiteColor ImgPath:nil];
    _dataArray = [NSMutableArray array];

    for (int i = 0; i < 4; i ++) {
        NSMutableArray *array = [NSMutableArray array];
        if (i == 0){
            NSDictionary *dataDic = @{@"title":@"",@"image":@""};
            [array addObject:dataDic];
        }else if (i == 1) {
            for (int a = 0; a < 3; a ++) {
                NSDictionary *dataDic = @{@"title":a == 0?@"兑换专区":a== 1?@"线上消费":@"线下消费",@"image":i==0?@"icon_exch":i==1?@"icon_online":@"icon_offline"};
                [array addObject:dataDic];
            }
            
        }else if (i == 2){
            for (int a = 0; a < 4; a ++) {
                NSDictionary *dataDic = @{@"title":a == 0?@"我要入驻":a== 1?@"我的钱包":a==2?@"我的账号":@"我的优惠券",@"image":a==0?@"icon_ruzhu":a==1?@"icon_purse":a==2?@"icon_id":@"icon_ticket"};
                [array addObject:dataDic];
            }
        }else{
            for (int a = 0; a < 4; a ++) {
                NSDictionary *dataDic = @{@"title":a == 0?@"业绩统计":a== 1?@"资金记录":a==2?@"我的分享":@"我的消息",@"image":a==0?@"icon_perf":a==1?@"icon_fund":a==2?@"icon_share":@"icon_mess"};
                [array addObject:dataDic];
            }
        }
        [_dataArray addObject:array];
    }
    [self initTableView];

    _customNavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, isIPhpneX?88:64)];
    _customNavView.backgroundColor = kAppThemeColor;
    [self.view addSubview:_customNavView];
}

-(void)initTableView
{
    self.aTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.size.height-49) style:UITableViewStyleGrouped];
    self.aTableView.delegate  = self;
    self.aTableView.dataSource  = self;
    [self.view addSubview:self.aTableView];
    
    if (@available (iOS 11.0,*)) {
        self.aTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self registerCell];
}
-(void)registerCell{
    
    [self.aTableView registerNib:[UINib nibWithNibName:@"LDMineHeaderCell" bundle:nil] forCellReuseIdentifier:@"LDMineHeaderCell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *array =  _dataArray[section];
    return array.count;
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
    if (section == 0) {
         return CGFLOAT_MIN;
    }
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 230;
    }
    return SIZEFIT(50);
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ws(bself);
    if (indexPath.section == 0) {
        LDMineHeaderCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"LDMineHeaderCell"];
        headerCell.headerClick = ^(UIButton *btn) {
//            if ([bself isLogin]) {
                [bself.navigationController pushViewController:[LDMineInfoController new] animated:YES];
//            }
        };
        headerCell.bottomClick = ^(NSInteger selectIndex) {
            if (selectIndex == 0) {
                [bself.navigationController pushViewController:[LDSaveGoodsController new] animated:YES];
            }else if (selectIndex == 1){
                [bself.navigationController pushViewController:[LDSaveShopController new] animated:YES];
            }else{
                [bself.navigationController pushViewController:[LDFootPrintController new] animated:YES];
            }
        };
        return headerCell;
    }
    
    NSDictionary *dataDic = _dataArray[indexPath.section][indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = dataDic[@"title"];
    cell.imageView.image = [UIImage imageNamed:dataDic[@"image"]];
    
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = @"充值";
            cell.detailTextLabel.font = kFont16;
             cell.detailTextLabel.textColor = RGB(153, 153, 513);
        }else if (indexPath.row == 1){
            cell.detailTextLabel.font = kFont16;
            cell.detailTextLabel.text = @"10000";
            cell.detailTextLabel.textColor = kAppThemeColor;
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
        }else if (indexPath.row == 1){
            
            [self.navigationController pushViewController:[LDOrderObLineBaseController new] animated:YES];
            
        }else if (indexPath.row == 2){
            
        }
//        [self login];
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            [self.navigationController pushViewController:[LDAddressListController new] animated:YES];
        }else if (indexPath.row == 1){
            
        }else if (indexPath.row == 2){

        }else if (indexPath.row == 3){
            
            LDCouponController *VC = [[LDCouponController alloc]initWithCouponType:CouponTypeNormal];
            [self.navigationController pushViewController:VC animated:YES];
        }
    }else if (indexPath.section == 3){
        [self login];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self setnavColor];
}

-(void)setnavColor{
    ws(bself);

    CGFloat alpha = self.aTableView.contentOffset.y/64;
    
    _customNavView.alpha = alpha;
    
//    if (offsetY < 0) {
//        //        headView.frame = CGRectMake(offsetY/2., 0, kScreenWidth - offsetY, offsetY - SIZEFIT(163));
//
//    }else{
//        //        headView.frame = CGRectMake(0, 0, kScreenWidth, offsetY - SIZEFIT(163));
//    }
//
//    if (offsetY > 20) {
//        [UIView animateWithDuration:1.0 animations:^{
//            //            bself.navigationItem.title = @"个人中心";
//        }];
//    }else{
//        //        bself.navigationItem.title = nil;
//    }
    
}

@end
