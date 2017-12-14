//
//  LDCommentController.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/16.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDCommentController.h"
#import "LDCommentCell.h"
#import "LDCommentModel.h"

@interface LDCommentController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LDCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
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

    [self.aTableView registerClass:[LDCommentCell class] forCellReuseIdentifier:@"LDCommentCell"];
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
//    LDCommentModel *model = self.contentArr[indexPath.section];
    
    LDCommentModel *model = [[LDCommentModel alloc]init];
    model.AddTime = @"2017.11.15";
    model.Content = @"好吃不贵够实惠!!!!!!!!";
    model.Name = @"爱卿平身";
    model.OrderNO = @"MJ0889BHSF";
    model.IMG = @"http://a.hiphotos.baidu.com/image/pic/item/2934349b033b5bb5d1d220343fd3d539b700bcf6.jpg,http://d.hiphotos.baidu.com/image/pic/item/6c224f4a20a446234a817e719222720e0cf3d75e.jpg";
    
    model.Pic =@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=4115160689,1674949075&fm=27&gp=0.jpg";
    model.Reply = @"双击666,谢谢亲的肯定,我们还会做的更好!";
    model.Score = 3.0;
    return model.cellHeight;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LDCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDCommentCell"];
    
    LDCommentModel *model = [[LDCommentModel alloc]init];
    model.AddTime = @"2017.11.15";
    model.Content = @"好吃不贵够实惠!!!!!!!!";
    model.Name = @"爱卿平身";
    model.OrderNO = @"MJ0889BHSF";
    model.IMG = @"http://a.hiphotos.baidu.com/image/pic/item/2934349b033b5bb5d1d220343fd3d539b700bcf6.jpg,http://d.hiphotos.baidu.com/image/pic/item/6c224f4a20a446234a817e719222720e0cf3d75e.jpg";
    
    model.Pic =@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=4115160689,1674949075&fm=27&gp=0.jpg";
    model.Reply = @"双击666,谢谢亲的肯定,我们还会做的更好!";
    model.Score = 3.0;
    
    
    cell.model = model;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
