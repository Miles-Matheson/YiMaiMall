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
    
    [self requestMainDataWithGoodsID:_goodsID];
}
-(void)registerCell{

    [self.aTableView registerClass:[LDCommentCell class] forCellReuseIdentifier:@"LDCommentCell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.contentArr.count;
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

    LDCommentModel *model = self.contentArr[indexPath.section];
    return model.cellHeight;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LDCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDCommentCell"];
    cell.model = self.contentArr[indexPath.section];;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(void)requestMainDataWithGoodsID:(NSString *)goodsID{

    [self setScroll:self.aTableView firstPageNor:1 pageSize:10 networkCallback:^(NSInteger page, CompletionCallback completionCallback) {
        
        NSDictionary *param = @{
                                @"goodsId":goodsID?goodsID:@"",
                                @"currentPage":@(page),
                                @"pageSize":@"10",
                                };
        [[APIManager sharedManager] getGoodsCommentListWithGoodsData:param CallBack:^(id data) {
             NSArray *array = [LDCommentModel mj_objectArrayWithKeyValuesArray:data[@"obj"][@"data"]];
            if (array) {
                completionCallback(YES,array);
            }else{
                completionCallback(NO,@[]);
            }
        } fail:^(NSString *errorString) {
             completionCallback(NO,@[]);
        }];
    } noMoreDataCallback:^(NSInteger page) {
        
    }];
    [self silenceRefresh];
}

@end
