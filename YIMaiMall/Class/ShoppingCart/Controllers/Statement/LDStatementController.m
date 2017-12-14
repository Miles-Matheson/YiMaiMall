//
//  LDStatementController.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/21.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDStatementController.h"
#import "LDAddressIndexCell.h"
#import "LDShopCartListCell.h"
#import "LDStatementIndexHeaderView.h"
#import "LDStatmentBottomView.h"
#import "RegisterCell.h"
#import "LDChooseExpressView.h"
#import "LDAddressListController.h"
#import "PayOrderViewController.h"
#import "ShopCartBaseController.h"
#import "LDStatementModel.h"
#import "LDCouponController.h"
#import "LDCouponListModel.h"

@interface LDStatementController ()<UITableViewDelegate,UITableViewDataSource,LDChooseExpressViewDelegate>

@property (nonatomic, strong) LDCouponListModel *selectCouponModel;
@property (nonatomic, strong) LDStatementModel *mainModel;
@property (nonatomic,strong)LDStatmentBottomView *bottomView;
//@property (nonatomic, assign) CGFloat totalPrice;
//@property (nonatomic, assign) NSInteger totalCount;

@end

@implementation LDStatementController

-(void)setModelList:(NSArray<LDShopGoodsCartsModel *> *)modelList
{
    _modelList = modelList;
}

-(LDStatmentBottomView *)bottomView
{
    ws(bself);
    if (!_bottomView) {
        _bottomView = [[LDStatmentBottomView alloc]init];
        [self.view addSubview:_bottomView];
        
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.height.offset(50);
            make.bottom.offset(isIPhpneX?-33:0);
        }];
        _bottomView.statmentClick = ^{
            [bself commitOrder];
        };
    }
    return _bottomView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"确认订单";
    [self initAtableView];
    
    _mainModel = [[LDStatementModel  alloc]init];
    [self getOrderBaseInfoWithIdlist:_modelList];
}

- (void)initAtableView{
    CGFloat top = isIPhpneX?88:64;
    CGFloat bottom = isIPhpneX?88:50;
    
    self.aTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height-bottom) style:UITableViewStyleGrouped];
    //    self.aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.aTableView.delegate   = self;
    self.aTableView.dataSource = self;
    self.aTableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.aTableView];
    
    [self registerCustomCell];
}

- (void)registerCustomCell
{
    [self.aTableView registerClass:[LDStatementIndexHeaderView class] forHeaderFooterViewReuseIdentifier:@"LDStatementIndexHeaderView"];
    
    [self.aTableView registerNib:[UINib nibWithNibName:@"LDAddressIndexCell" bundle:nil] forCellReuseIdentifier:@"LDAddressIndexCell"];
    
    [self.aTableView registerClass:[LDShopCartListCell class] forCellReuseIdentifier:@"LDShopCartListCell"];
    [self.aTableView registerClass:[RegisterCell class] forCellReuseIdentifier:ReuseIdentifier_Normal];
}

#pragma mark UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 1 || section == 2 || section == 3) {
        
        LDStatementIndexHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LDStatementIndexHeaderView"];
        headerView.backgroundColor   = WhiteColor;
        headerView.titleLB.text = _mainModel.storeName;
        return headerView;
    }
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0 ) {
        return 10;
    }else {
        return 40;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return SIZEFIT(95);
    }else{
        if (indexPath.row < _mainModel.goodsList.count){
            return SIZEFIT(130);
        }else{
            return SIZEFIT(45);
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else {
        return  _mainModel.goodsList.count+4;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    ws(bself);
    if (indexPath.section == 0) {
        LDAddressIndexCell *addCell = [tableView dequeueReusableCellWithIdentifier:@"LDAddressIndexCell"];
        if (_mainModel.addList.firstObject) {
            addCell.model = _mainModel.addList.firstObject;
        }
        return addCell;
    }else {
        
        if (indexPath.row < _mainModel.goodsList.count) {
            
            LDShopCartListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDShopCartListCell"];
            cell.statementModel = _mainModel.goodsList[indexPath.row];
            cell.isHiddenSelectBtn = YES;
            return cell;
            
        }else if (indexPath.row == _mainModel.goodsList.count){
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
                cell.textLabel.text = @"配送方式";
                cell.textLabel.font = kFont14;
                cell.detailTextLabel.font = kFont14;
            }
            if (_mainModel.freight == 0) {
                cell.detailTextLabel.text = @"快递免邮";
            }else{
                cell.detailTextLabel.text = [NSString stringWithFormat:@"运费¥%.2f",_mainModel.freight];
            }
            
            return cell;
            
        }else if (indexPath.row == _mainModel.goodsList.count+1){
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell0"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell0"];
                cell.textLabel.text = @"优惠券";
                cell.textLabel.font = kFont14;
                cell.detailTextLabel.font = kFont14;
            }
            if (_mainModel.usable.count) {
                cell.detailTextLabel.text = @"选择优惠券";
            }else{
                cell.detailTextLabel.text = @"暂无优惠券可用";
            }
            return cell;
        }else if (indexPath.row == _mainModel.goodsList.count+2){
            
            RegisterCell *lastCell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier_Normal];
            lastCell.titleLabel.text = @"买家留言";
            lastCell.contentTF.placeholder = @"请输入对本次交易的说明";
            lastCell.titleLabel.font = kFont14;
            lastCell.contentTF.font = kFont14;
            return lastCell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell1"];
                cell.backgroundColor = [UIColor whiteColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            NSString *moneyStr = [NSString stringWithFormat:@"¥%.2f",_mainModel.total + _mainModel.freight];
            NSString *allStr = [NSString stringWithFormat:@"共%ld件商品 运费%.f元 小计：%@",_mainModel.goodsList.count ,_mainModel.freight,moneyStr];
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:allStr];
            
            [attrStr addAttribute:NSForegroundColorAttributeName value:kAppSubThemeColor range:NSMakeRange(allStr.length - moneyStr.length, moneyStr.length)];
            
            cell.detailTextLabel.font = kFont15;
            cell.detailTextLabel.attributedText = attrStr;
            return cell;
        }
    }
    return [UITableViewCell new];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ws(bself);
    if (indexPath.section == 0) {
        LDAddressListController *addressVC = [[LDAddressListController alloc]init];
        addressVC.chageNewAdressCallBack = ^(LDAddressListModel *model) {
            
            if (bself.mainModel.addList.count) {
                [bself.mainModel.addList replaceObjectAtIndex:0 withObject:model];
            }else{
                [bself.mainModel.addList addObject:model];
            }
            [bself.aTableView reloadData];
            [bself getTransfee];
        };
        [self.navigationController pushViewController:addressVC animated:YES];
    }
    
    if (indexPath.section != 0 && indexPath.row == 2) {
        
        if (_mainModel.usable.count) {
            LDCouponController *coupVC = [[LDCouponController alloc]initWithCouponType:CouponTypeChoose];
            coupVC.couponTotalList = @[_mainModel.usable,_mainModel.unusable];
            [self.navigationController pushViewController:coupVC animated:YES];
        }
        
        //[LDChooseExpressView showInSubView:self Frame:CGRectMake(0,self.view.size.height/2., self.view.size.width, self.view.size.height/2.) dataSource:@[@"申通",@"圆通",@"免邮"]];
    }
}

#pragma mark LDChooseExpressViewDelegate
-(void)expressViewShow:(LDChooseExpressView *)expressViewShow SelectIndex:(NSInteger)index{
    
    
}

-(void)getOrderBaseInfoWithIdlist:(NSArray <LDShopGoodsCartsModel*>*)models{
    WS(bself);
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (LDShopGoodsCartsModel *goodsCartsModel in models) {
        
        NSString *shopCartList = goodsCartsModel.goodsCartId;
        
        [array addObject:shopCartList];
    }
    
    [[APIManager sharedManager] goodsModifyWithIdlist:array CallBack:^(id data) {
        
        bself.mainModel =  [LDStatementModel mj_objectWithKeyValues:data[@"obj"]];
        [bself.bottomView setPrice:bself.mainModel.total count:bself.mainModel.goodsList.count];
        [bself.aTableView reloadData];
        
    } fail:^(NSString *errorString) {
        
    }];
}

-(void)getTransfee{
    
    ws(bself);
    
    NSMutableArray *array = [NSMutableArray array];
    for ( LDStatementListModel *model in _mainModel.goodsList) {
        
        NSDictionary *dataDic = @{
                                  @"gid":model.goodId,//购物车商品编号（long，见说明，编号B）
                                  @"cnt":@(model.count),//购物车商品数量
                                  };
        [array addObject:dataDic];
    }
    
    LDAddressListModel *addressModel = _mainModel.addList.firstObject;
    if (addressModel) {
        NSDictionary *param = @{
                                @"list":array,
                                @"areaId":addressModel.areaId,
                                };
        
        [[APIManager sharedManager] getTransfeeWithData:param CallBack:^(id data) {
            RC001;
            CGFloat bigdecimal = [data[@"obj"] floatValue];
            bself.mainModel.freight = bigdecimal;
            [bself.aTableView reloadData];
        } fail:^(NSString *errorString) {
            
        }];
    }
}

//提交订单
-(void)commitOrder{
    
    ws(bself);
    LDAddressListModel *model = self.mainModel.addList.firstObject;
    if (!model || model.areaId.length == 0 ) {
        [Dialog toastCenter:@"请选择收货地址!"];
        return;
    }
    
    RegisterCell *cell = [self.aTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_mainModel.goodsList.count+2 inSection:1]];
    
    NSString *mgs = cell.contentTF.text;
    
    NSMutableArray *gcIdArray = [NSMutableArray array];
    
    for (LDStatementListModel *goodsListModel in _mainModel.goodsList) {
        if (goodsListModel.ID) {
            [gcIdArray addObject:goodsListModel.ID];
        }
    }
    
    LDAddressListModel *addressModel = _mainModel.addList.firstObject;
    
    NSDictionary *dataDic = @{
                              @"addId":addressModel.ID?addressModel.ID:@"",
                              @"gcIds":gcIdArray,
                              @"couponId":_selectCouponModel.ID?_selectCouponModel.ID:@"",
                              @"msg":mgs?mgs:@"",
                              };
    
    [[APIManager sharedManager] commitOrderWithData:dataDic CallBack:^(id data) {
        
        RC001;
        
        NSDictionary *dataDic = (NSDictionary *)data;
        
        NSString *orderID = dataDic[@"obj"][@"id"];
        NSString *GDA = dataDic[@"obj"][@"gda"];
        CGFloat orderAmount = [dataDic[@"obj"][@"orderAmount"]  floatValue];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:ORDERCHANGE object:nil];
        
        PayOrderViewController *payVC = [[PayOrderViewController alloc] init];
        payVC.orderID = orderID;
        payVC.orderAmount = orderAmount;
        payVC.gda = GDA;
        payVC.orderName = bself.mainModel.storeName;
        
        if ([bself.navigationController.childViewControllers.firstObject isKindOfClass:[ShopCartBaseController class]]) {//从详情进去
            [[NSNotificationCenter defaultCenter] postNotificationName:ORDERSUBMITFINISH object:@0];
        }
        [bself.navigationController pushViewController:payVC animated:YES];
        
    } fail:^(NSString *errorString) {
        
    }];
}

@end

