//
//  LDShopIntroduceController.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/30.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDShopIntroduceController.h"
#import "LDIntroduceHeaderCell.h"
#import "LDShopLicenseController.h"///工商执照

@interface LDShopIntroduceController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LDShopIntroduceController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navBackgroundImageView.alpha = 1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBackgroundImageView.alpha = 1;
    self.navigationItem.title = @"店铺介绍";
    [self initTableView];
}

-(void)initTableView
{
    self.aTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.aTableView.delegate  = self;
    self.aTableView.dataSource  = self;
    [self.view addSubview:self.aTableView];
    
    [self registerCell];
}
-(void)registerCell{
    
    [self.aTableView registerNib:[UINib nibWithNibName:@"LDIntroduceHeaderCell" bundle:nil] forCellReuseIdentifier:@"LDIntroduceHeaderCell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
         return 2;
    }else if (section == 2){
         return 3;
    }else if (section == 3){
         return 2;
    }else if (section == 4){
         return 1;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return SIZEFIT(85);
    }
    return 45;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        LDIntroduceHeaderCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"LDIntroduceHeaderCell"];
        headerCell.model = _dataSouce;
        return headerCell;
    }else if (indexPath.section == 1){
        
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (!cell1) {
            cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"cell1"];
            cell1.textLabel.textAlignment = Left;
            cell1.textLabel.font = kFont15;
            cell1.textLabel.textColor = RGB(153, 153, 153);
        }
        if (indexPath.row == 0) {
            cell1.textLabel.text = @"好评率";
            cell1.detailTextLabel.text = _dataSouce.praiseRate;
        }else if (indexPath.row == 1){
            cell1.textLabel.text = @"开店时间";
            cell1.detailTextLabel.text = _dataSouce.addTime;
        }
        return cell1;
    }else if (indexPath.section==2){
        UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (!cell2) {
            cell2 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"cell2"];
            cell2.detailTextLabel.textColor = kAppThemeColor;
            cell2.textLabel.font = kFont15;
            cell2.textLabel.textColor = RGB(153, 153, 153);
        }
        if (indexPath.row == 0) {
            cell2.textLabel.text = @"描述相符";
            cell2.detailTextLabel.text = _dataSouce.descriptionEvaluate;
        }else if (indexPath.row == 1){
            cell2.textLabel.text = @"服务态度";
            cell2.detailTextLabel.text = _dataSouce.serviceEvaluate;
        }else{
            cell2.textLabel.text = @"物流服务";
            cell2.detailTextLabel.text = _dataSouce.shipEvaluate;
        }
        cell2.textLabel.textAlignment = NSTextAlignmentLeft;
         return cell2;
    }else if (indexPath.section==3){
        UITableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
        if (!cell3) {
            cell3 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"cell3"];
            cell3.textLabel.textAlignment = Left;
            cell3.textLabel.textColor = RGB(153, 153, 153);
            cell3.textLabel.font = kFont15;
             UIButton *headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [cell3.contentView addSubview:headerBtn];
            [headerBtn setImage:[UIImage imageNamed:@"store_chat"] forState:UIControlStateNormal];
            [headerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.offset(-15);
                make.centerY.offset(0);
            }];
        }
        if (indexPath.row == 0) {
            cell3.textLabel.text = @"经营范围";
            cell3.detailTextLabel.text = _dataSouce.storeSeoDescription;
        }else if (indexPath.row == 1){
            cell3.textLabel.text = @"掌柜名";
            cell3.detailTextLabel.text = _dataSouce.storeOwer;
        }
        for (UIView *view in cell3.contentView.subviews ) {
            if ([view isKindOfClass:[UIButton class]]) {
                UIButton *btn = (UIButton*)view;
                if (indexPath.row == 0) {
                    [btn setImage:nil forState:UIControlStateNormal];
                }else{
                    [btn setImage:[UIImage imageNamed:@"store_chat"] forState:UIControlStateNormal];
                }
            }
        }
         return cell3;
    }else{
        UITableViewCell *cell4 = [tableView dequeueReusableCellWithIdentifier:@"cell4"];
        if (!cell4) {
            cell4 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"cell4"];
            cell4.textLabel.textAlignment = Left;
            cell4.textLabel.textColor = RGB(153, 153, 153);
            cell4.textLabel.font = kFont15;
            UIButton *zhizhaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [cell4.contentView addSubview:zhizhaoBtn];
            [zhizhaoBtn setImage:[UIImage imageNamed:@"store_license"] forState:UIControlStateNormal];
            [zhizhaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.offset(-15);
                make.centerY.offset(0);
            }];
        }
        cell4.textLabel.text = @"工商执照";
         return cell4;
    }
    return [UITableViewCell new];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
    }else if (indexPath.section==1){
        
    }else if (indexPath.section==2){
        
    }else if (indexPath.section==3){
        
    }else{
        [self.navigationController pushViewController:[LDShopLicenseController new] animated:YES];
    }
}

@end
