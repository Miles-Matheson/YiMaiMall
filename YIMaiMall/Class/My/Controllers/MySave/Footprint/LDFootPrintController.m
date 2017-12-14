//
//  LDFootPrintController.m
//  YIMaiMall
//
//  Created by Miles on 2017/12/1.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDFootPrintController.h"
#import "LDSaveGoodsCell.h"
@interface LDFootPrintController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LDFootPrintController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的足迹";
    
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
    
    [self.aTableView registerNib:[UINib nibWithNibName:@"LDSaveGoodsCell" bundle:nil] forCellReuseIdentifier:@"LDSaveGoodsCell"];
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
    return SIZEFIT(100);
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LDSaveGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDSaveGoodsCell"];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
