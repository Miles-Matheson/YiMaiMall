//
//  LDOnlineOrderController.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/23.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDOnlineOrderController.h"
#import "LDShopCartListCell.h"
#import "LDOrderListTopCell.h"
#import "LDTableViewFooterView.h"
#import "LDBaseShopDetailController.h"
#import "LDOnlineOrderDetailController.h"
#import "LDOrderModel.h"

@interface LDOnlineOrderController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LDOnlineOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
    
    [self requestOrderListWithOrderStatus:_ststus];
}

-(void)initTableView{
    
    self.aTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.size.height-64-44) style:UITableViewStyleGrouped];
    self.aTableView.delegate  = self;
    self.aTableView.dataSource  = self;
    [self.view addSubview:self.aTableView];
    
    [self registerCell];
}
-(void)registerCell{
    
    [self.aTableView registerClass:[LDOrderListTopCell class] forCellReuseIdentifier:@"LDOrderListTopCell"];
    [self.aTableView registerClass:[LDShopCartListCell class] forCellReuseIdentifier:@"LDShopCartListCell"];
    [self.aTableView registerClass:[LDTableViewFooterView class] forHeaderFooterViewReuseIdentifier:@"LDTableViewFooterView"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.contentArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    LDOrderModel *model = self.contentArr[section];
    return model.list.count+1;;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return [UIView new];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    ws(bself);
    LDTableViewFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LDTableViewFooterView"];
    LDOrderModel *model = self.contentArr[section];
    footerView.model = model;
    footerView.statusCliackCallBack = ^(NSInteger selectIndex, LDOrderModel *model) {
        
        [bself changeOrderStatusWithSelectIndexTag:selectIndex model:model];
    };
    return footerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
         return 45;
    }else{
        
         return SIZEFIT(130);
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LDOrderModel *model = self.contentArr[indexPath.section];

    if (indexPath.row == 0) {
        LDOrderListTopCell *topCell = [tableView dequeueReusableCellWithIdentifier:@"LDOrderListTopCell"];
        topCell.model = model;
        return topCell;
    }else{
        LDShopCartListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDShopCartListCell"];
        cell.orderModel = model.list[indexPath.row-1];
        cell.isHiddenSelectBtn = YES;
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LDOrderModel *model = self.contentArr[indexPath.section];
    
    if (0 < indexPath.row &&  indexPath.row<= model.list.count) {
        
        LDOnlineOrderDetailController *detailVC = [[LDOnlineOrderDetailController alloc]init];
        detailVC.orderID = model.ID;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

-(void)requestOrderListWithOrderStatus:(NSInteger)status{
    
    [self setScroll:self.aTableView firstPageNor:1 pageSize:15 networkCallback:^(NSInteger page, CompletionCallback completionCallback) {

        NSDictionary *param = @{
                                @"cur":@(page),
                                @"rp":@"15",
                                @"status":@(status),//订单状态（int，0：全部，1：待付款，2：待收货，3：待评价，4：已完成）
                                };
        [[APIManager sharedManager] getOnlineOrderListWithData:param CallBack:^(id data) {

            NSArray *array = [LDOrderModel mj_objectArrayWithKeyValuesArray:data[@"obj"][@"rows"]];
            completionCallback(array?YES:NO,array?array:@[]);
            
        } fail:^(NSString *errorString) {
            completionCallback(NO,@[]);
        }];
        
    } noMoreDataCallback:^(NSInteger page) {
        
    }];
    [self silenceRefresh];
}

@end
