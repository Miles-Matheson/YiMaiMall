//
//  LDOnlineOrderDetailController.m
//  YIMaiMall
//
//  Created by Miles on 2017/12/11.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDOnlineOrderDetailController.h"
#import "LDOnlineOrderDetailAddressCell.h"
#import "LDOnlineOrderDetailCallPhoneCell.h"
#import "LDOnlineOrderDetailHeaderView.h"
#import "LDOrderDetailModel.h"
#import "LDOrderDetailListCell.h"
#import "LDOnlineOrderDetailTopCell.h"

@interface LDOnlineOrderDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) LDOrderDetailModel *orderModel;

@end

@implementation LDOnlineOrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"订单详情";

    
    UIButton *informationCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [informationCardBtn addTarget:self action:@selector(enterehzFilesVC:) forControlEvents:UIControlEventTouchUpInside];
    [informationCardBtn setImage:[UIImage imageNamed:@"shop_1"] forState:UIControlStateNormal];
    
    [informationCardBtn sizeToFit];
    UIBarButtonItem *informationCardItem = [[UIBarButtonItem alloc] initWithCustomView:informationCardBtn];
    
    self.navigationItem.rightBarButtonItem  = informationCardItem;
    
    _orderModel = [[LDOrderDetailModel alloc]init];
    
    [self initTableView];
    
    [self getOrderDetailRequestWithIrderId:_orderID];
}

-(void)enterehzFilesVC:(UIButton *)btn{
    
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
    
    
    
    
    [self.aTableView registerClass:[LDOnlineOrderDetailTopCell class] forCellReuseIdentifier:@"LDOnlineOrderDetailTopCell"];
    [self.aTableView registerNib:[UINib nibWithNibName:@"LDOnlineOrderDetailAddressCell" bundle:nil] forCellReuseIdentifier:@"LDOnlineOrderDetailAddressCell"];
    [self.aTableView registerNib:[UINib nibWithNibName:@"LDOnlineOrderDetailCallPhoneCell" bundle:nil] forCellReuseIdentifier:@"LDOnlineOrderDetailCallPhoneCell"];
    
    
    [self.aTableView registerNib:[UINib nibWithNibName:@"LDOrderDetailListCell" bundle:nil] forCellReuseIdentifier:@"LDOrderDetailListCell"];
    
    

//    [self.aTableView registerClass:[LDOnlineOrderDetailAddressCell class] forCellReuseIdentifier:@"LDOnlineOrderDetailAddressCell"];
//    [self.aTableView registerClass:[LDOnlineOrderDetailAddressCell class] forCellReuseIdentifier:@"LDOnlineOrderDetailAddressCell"];
//    [self.aTableView registerClass:[LDOnlineOrderDetailAddressCell class] forCellReuseIdentifier:@"LDOnlineOrderDetailAddressCell"];
//    [self.aTableView registerClass:[LDOnlineOrderDetailAddressCell class] forCellReuseIdentifier:@"LDOnlineOrderDetailAddressCell"];
    
    
    [self.aTableView registerClass:[LDOnlineOrderDetailHeaderView class] forHeaderFooterViewReuseIdentifier:@"LDOnlineOrderDetailHeaderView"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0?1:section == 1?1:section == 2?_orderModel.orderGoods.count+4:0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        LDOnlineOrderDetailHeaderView *headerView = (LDOnlineOrderDetailHeaderView*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LDOnlineOrderDetailHeaderView"];
        headerView.model = _orderModel;
        headerView.storeClickCallBack = ^{
            
        };
        return headerView;
    }
    return [UIView new];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return 45;
    }
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 10;
    }
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return SIZEFIT(180);
    }else if (indexPath.section == 1){
        return SIZEFIT(85);
    }else if (indexPath.section == 2){
        if (indexPath.row < _orderModel.orderGoods.count) {
            return SIZEFIT(130);
        }else{
             return 45;
        }
    }
    return 44;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        LDOnlineOrderDetailTopCell *topCell = [tableView dequeueReusableCellWithIdentifier:@"LDOnlineOrderDetailTopCell"];
        topCell.model = _orderModel;
        return topCell;
    }else if (indexPath.section == 1){
        
        LDOnlineOrderDetailAddressCell *addressCell = [tableView dequeueReusableCellWithIdentifier:@"LDOnlineOrderDetailAddressCell"];
        addressCell.userNameLB.text = [NSString stringWithFormat:@"%@",_orderModel.trueName];
        addressCell.userAddressLB.text = [NSString stringWithFormat:@"收货人地址：%@",_orderModel.address];
        return addressCell;
        
    }else if (indexPath.section == 2){
        
        if (indexPath.row < _orderModel.orderGoods.count) {
            
            LDOrderDetailListCell *orderListCell = [tableView dequeueReusableCellWithIdentifier:@"LDOrderDetailListCell"];
            orderListCell.listModel = _orderModel.orderGoods[indexPath.row];
            return orderListCell;

        }else if (indexPath.row == _orderModel.orderGoods.count){
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
                cell.textLabel.font  = kFont14;
                cell.detailTextLabel.font = kFont14;
            }
            cell.textLabel.text = @"配送方式";
            cell.detailTextLabel.text = _orderModel.transport;
            return cell;
 
        }else if (indexPath.row == _orderModel.orderGoods.count +1){
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell1"];
                cell.textLabel.font  = kFont14;
                cell.detailTextLabel.font = kFont14;
            }
            cell.textLabel.text = @"优惠券";
            cell.detailTextLabel.text = @"-10";
            return cell;
            
        }else if (indexPath.row == _orderModel.orderGoods.count +2){
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
                cell.backgroundColor = [UIColor whiteColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.font  = kFont14;
                cell.detailTextLabel.font = kFont14;
            }
        
            NSInteger count = 0;
            
            for (LDOrderGoodsListModel *model in _orderModel.orderGoods) {
                count = model.count+count;
            }
            NSString *moneyStr = [NSString stringWithFormat:@"¥%.2f",_orderModel.totalPrice];
            NSString *allStr = [NSString stringWithFormat:@"共%ld件商品 小计：%@",count,moneyStr];
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:allStr];
            
            [attrStr addAttribute:NSForegroundColorAttributeName value:kAppThemeColor range:NSMakeRange(allStr.length - moneyStr.length, moneyStr.length)];
            
            cell.detailTextLabel.attributedText = attrStr;
            return cell;
            
            
        }else if (indexPath.row == _orderModel.orderGoods.count +3){
            
            LDOnlineOrderDetailCallPhoneCell *callPhoneCell = [tableView dequeueReusableCellWithIdentifier:@"LDOnlineOrderDetailCallPhoneCell"];
            callPhoneCell.callPhoneClickCallBack = ^(NSInteger tag) {
                if (tag) {
                    [LDAlterView  alterViewWithTitle:@"10000" content:@"确认拨打?" cancel:nil sure:@"确定" cancelBtClcik:nil  sureBtClcik:^{
                        [LLUtils callPhoneWithPhone:@"10000"];
                    }];
                }else{//im 联系卖家
                    
                }
            };
            return callPhoneCell;
        }
    }
    
    return [UITableViewCell new];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)getOrderDetailRequestWithIrderId:(NSString *)orderId{
    
    ws(bself);
    [[APIManager sharedManager] getOrderDetailWithOrderId:orderId?orderId:@"" CallBack:^(id data) {
    
        bself.orderModel =  [LDOrderDetailModel mj_objectWithKeyValues:data[@"obj"]];
        if ( bself.orderModel) {
            [bself.aTableView reloadData];
        }
    } fail:^(NSString *errorString) {
//
    }];
}

@end
