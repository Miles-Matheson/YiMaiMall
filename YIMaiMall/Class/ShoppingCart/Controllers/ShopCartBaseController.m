//
//  BaseShopCartController.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/18.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "ShopCartBaseController.h"
#import "LDShopCartListCell.h"
#import "LDShopCartHeaderView.h"
#import "LDBaseGoodsDetailController.h"
#import "ShopCartBottomView.h"
#import "LDStatementController.h"
#import "LDShopCartModel.h"
@interface ShopCartBaseController ()<UITableViewDelegate,UITableViewDataSource,ShopcartBotttomViewDelegate>

@property (nonatomic,strong)NSMutableArray <LDShopGoodsCartsModel *>* selectArray;
@property (nonatomic,strong)ShopCartBottomView *bottomView;

@end

@implementation ShopCartBaseController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
/*
 ///0 :全不选,
 ///1 :全选,
 ///2 :删除,
 /// 3 :支付,
 */
#pragma param ShopcartBotttomViewDelegate
- (void)shopCartBotttomViewClickItemImdex:(NSInteger)index{
    
    if (index == 2) {                   //删除,
        
    }else if (index == 0 || index == 1){ //全不选, 全选,
        [self changeAllCellStatus:index];
    }else{                              //:支付,
        LDStatementController * statementVC = [[LDStatementController alloc]init];
        statementVC.modelList = _selectArray;
        [self.navigationController pushViewController:statementVC animated:YES];
    }
}

-(ShopCartBottomView*)bottomView{
    ws(bself);
    if (!_bottomView) {
        _bottomView = [[ShopCartBottomView alloc]init];
        _bottomView.delegate = self;
        [self.view addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.height.offset(50);
            make.top.equalTo(bself.aTableView.mas_bottom);
        }];
    }
    return _bottomView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"购物车";
    
    _selectArray = [NSMutableArray array];

    [self setRightText:@"编辑全部" textColor:RGB(51, 51, 51) ImgPath:nil];
   
    [self initTableView];
    [self getShopCartListWithUserID:@""];
    self.bottomView.hidden = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:LOGINSUCCESS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:ADDGOODSCOUNT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:LOGOUTSUCCESS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:ADDGOODS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:ORDERSUBMITFINISH object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:ADDGOODS object:nil];
}

-(void)reloadData{
    [self silenceRefresh];
}
-(void)clickRightBtn:(UIButton *)rightBtn{
    
    [rightBtn setTitle:@"取消" forState:UIControlStateSelected];
    [rightBtn setTitle:@"编辑全部" forState:UIControlStateNormal];
    rightBtn.selected =  !rightBtn.selected;
    
    for (int i = 0; i< [self.aTableView numberOfSections]; i ++) {
        [self cellEditWithSection:i IsEdit:rightBtn.selected];
    }
}

-(void)initTableView{
    
    CGFloat bottom = 0;
    if ([self.navigationController.childViewControllers.firstObject isKindOfClass:[ShopCartBaseController class]]) {
        bottom = 49;
    }
    
    self.aTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, self.view.height -64-50-bottom) style:UITableViewStyleGrouped];
    self.aTableView.delegate  = self;
    self.aTableView.dataSource  = self;
    [self.view addSubview:self.aTableView];
    
    if (@available (iOS 11.0,*)) {
        self.aTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets    = NO;
    }
    
    [self registerCell];
}
-(void)registerCell{
    
    [self.aTableView registerClass:[LDShopCartListCell class] forCellReuseIdentifier:@"LDShopCartListCell"];
    [self.aTableView registerClass:[LDShopCartHeaderView class] forHeaderFooterViewReuseIdentifier:@"LDShopCartHeaderView"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.contentArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    LDShopCartModel *model =  self.contentArr[section];
    return model.goodsCarts.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    ws(bself);
    LDShopCartHeaderView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LDShopCartHeaderView"];
    headerView.model = self.contentArr[section];
    headerView.sectionIndex = section;
    headerView.selectItemClick = ^(LDShopCartHeaderView *headerView) {
        [bself sectionHeaderSelectChangeStatusWithHeaderView:headerView];
    };
    headerView.editItemClick = ^(BOOL isEdit,NSInteger sectionIndex) {///是否被编辑
        [bself cellEditWithSection:sectionIndex IsEdit:!isEdit];
    };
    return headerView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SIZEFIT(130);
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ws(bself);
    LDShopCartModel *model = self.contentArr[indexPath.section];
    
    LDShopCartListCell *listCell = [tableView dequeueReusableCellWithIdentifier:@"LDShopCartListCell"];
    listCell.model = model.goodsCarts[indexPath.row];
    
    listCell.selectItemClick = ^(LDShopCartListCell *cell) {
        [bself goodsSelectChangeStatusWithCell:cell];
    };
    listCell.deleteItemClick = ^(LDShopCartListCell *cell) {
         [bself deleteGoodsWithModel:cell.model];
    };
    listCell.changeCountClick = ^(LDShopGoodsCartsModel *model, NSInteger changeCount, NSInteger currentCount) {
        
        [bself chageGoodsCountWithGoodsCartId:model.goodsCartId ChangeCount:changeCount CurrentCont:currentCount CallBack:^(BOOL success) {
            if (success) {
                model.count = currentCount;
            }
        }];
    };
    return listCell;
    
    return [UITableViewCell new];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.navigationController pushViewController:[[LDBaseGoodsDetailController alloc]initWithGoodsID:@""] animated:YES];
}

//点击cell更改cell以及区头状态
-(void)goodsSelectChangeStatusWithCell:(LDShopCartListCell *)cell{
    
    NSIndexPath *path = [self.aTableView indexPathForCell:cell];
    LDShopCartHeaderView *headerView =  (LDShopCartHeaderView *)[self.aTableView headerViewForSection:path.section];
    
    LDShopGoodsCartsModel *model = cell.model;
    model.isselect =  !model.isselect;
    
    ///防止数据出错 加个包含处理
    if (![_selectArray containsObject:model] && model.isselect) {
        [_selectArray addObject:model];
    }else if ([_selectArray containsObject:model] && !model.isselect){
        [_selectArray removeObject:model];
    }
    
    LDShopCartModel *shopCartModel =  headerView.model;
    
    NSInteger selctionSelectCount  = 0; //当前区内所有商品数量
    NSInteger selctionAllCount  = 0;    //当前区内所有已经选中商品数量
    
    for (LDShopGoodsCartsModel *goodsCartsModel in shopCartModel.goodsCarts) {
        selctionSelectCount ++;
        if (goodsCartsModel.isselect) {
            selctionAllCount ++;
        }
    }
    shopCartModel.isselect = (selctionSelectCount == selctionAllCount);
    NSIndexSet *set = [[NSIndexSet alloc]initWithIndex:path.section];
    [self.aTableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
    
    [self calculationTotalPriceWithSelectModels:_selectArray];
}

//点击区头更改区头以及区内cell状态
-(void)sectionHeaderSelectChangeStatusWithHeaderView:(LDShopCartHeaderView *)headerView{
    
    LDShopCartModel *shopCartModel =  headerView.model;
    shopCartModel.isselect =  !shopCartModel.isselect;
    
    for (LDShopGoodsCartsModel * goodsCartsModel in shopCartModel.goodsCarts) {
        goodsCartsModel.isselect = shopCartModel.isselect;
        
        if (![_selectArray containsObject:goodsCartsModel] && shopCartModel.isselect) {//如果不包含该该model 且该区被全选
            [_selectArray addObject:goodsCartsModel];
        }else if ([_selectArray containsObject:goodsCartsModel] && !shopCartModel.isselect){ //如果包含该该model 且该区被全不选
            [_selectArray removeObject:goodsCartsModel];
        }
    }
    
    NSInteger section = headerView.sectionIndex;
    NSIndexSet *set = [[NSIndexSet alloc]initWithIndex:section];
    [self.aTableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
    
    [self calculationTotalPriceWithSelectModels:_selectArray];
}

///计算总价格
-(CGFloat)calculationTotalPriceWithSelectModels:(NSArray<LDShopGoodsCartsModel*>*)selectModels{
    
    CGFloat selectPrice = 0.0;   //已经选择商品总价格
    NSInteger allCount = 0;     //所有商品数量
    NSInteger selectCount = 0;  //已经选择的数量
    
    for (LDShopCartModel *shopChopCartModel in self.contentArr) {  //计算所有购物车内所有商品数量
        allCount = shopChopCartModel.goodsCarts.count + allCount;
    }
    for (LDShopGoodsCartsModel * goodsCartsModel in selectModels) {//计算已经选择的商品价格 数量
        selectPrice = goodsCartsModel.cartPrice +selectPrice;
        selectCount++;
    }
    ///计算商品是否全部选中 动态更改底部按钮状态 info
    [self.bottomView configureShopcartBottomViewWithTotalPrice:selectPrice selectCount:selectCount isAllselected:allCount==selectCount];
    return selectPrice;
}

-(void)changeAllCellStatus:(BOOL)isAllSelect{
    
    [_selectArray removeAllObjects];
    
    for (LDShopCartModel *shopCartModel in self.contentArr) {
        shopCartModel.isselect = isAllSelect;
        for (LDShopGoodsCartsModel * goodsCartsModel in shopCartModel.goodsCarts) {
            goodsCartsModel.isselect = isAllSelect;
            if ( goodsCartsModel.isselect) {
                [_selectArray addObject:goodsCartsModel];
            }
        }
    }
    [self.aTableView reloadData];
    [self calculationTotalPriceWithSelectModels:_selectArray];
}

//改变cell编辑状态
-(void)cellEditWithSection:(NSInteger)section IsEdit:(BOOL)isEdit{
    
    LDShopCartHeaderView * headerView = (LDShopCartHeaderView*)[self.aTableView headerViewForSection:section];
    headerView.model.isEditing = isEdit;
    
    NSInteger row = [self.aTableView numberOfRowsInSection:section];
    
    for (int i = 0; i < row ; i ++) {
        LDShopCartListCell *cell = [self.aTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:section]];
        cell.model.isEditing = isEdit;
        cell.isEditing   =  isEdit;
    }
    
    //    UIButton *btn =  self.navigationItem.rightBarButtonItem.customView;
    //    if ([self isAllCancelEditSention:section]) {
    //        btn.selected = NO;
    //    }else{
    //        btn.selected = YES;
    //    }
    [self.aTableView reloadData];
}

-(void)getShopCartListWithUserID:(NSString *)userID{
    

    [self setScroll:self.aTableView firstPageNor:1 pageSize:1000 networkCallback:^(NSInteger page, CompletionCallback completionCallback) {

        [[APIManager sharedManager] getShopCatrListWithUserID:userID CallBack:^(id data) {

            NSArray *array =  [LDShopCartModel mj_objectArrayWithKeyValuesArray:data[@"obj"]];
            completionCallback(array?YES:NO,array?array:@[]);

        } fail:^(NSString *errorString) {
            completionCallback(NO,@[]);
        }];

    } noMoreDataCallback:^(NSInteger page) {
    }];
    [self silenceRefresh];
}

//删除商品
-(void)deleteGoodsWithModel:(LDShopGoodsCartsModel*)model{
    ws(bself);
    LDShopGoodsModel *goodsModel = model.goods;
    NSString *string = [NSString stringWithFormat:@"确定删除%@ ?",goodsModel.goodsName];
    [LLUtils showAlterView:self title:@"提示" message:string yesBtnTitle:@"确定" noBtnTitle:@"取消" yesBlock:^{
        
        [[APIManager sharedManager] deleteGoodeWithGoodsCartId:model.goodsCartId?model.goodsCartId:@"" CallBack:^(id data) {
            RC001;
            [bself silenceRefresh];
        } fail:^(NSString *errorString) {
            
        }];
        
    } noBlock:^{
    }];
}

-(void)chageGoodsCountWithGoodsCartId:(NSString *)goodsCartId ChangeCount:(NSInteger)changeCount CurrentCont:(NSInteger)currentCount CallBack:(void(^)(BOOL success))callBack{
    WS(bself);
    NSDictionary *param = @{
                            @"goodsCartId":goodsCartId?goodsCartId:@"",
                            @"count":@(changeCount),
                            };
    [[APIManager sharedManager] changeGoodsCountWithData:param CallBack:^(id data) {
        
        if ([data[@"state"] boolValue]) {
             callBack(YES);
        }else{
             callBack(NO);
            [bself.view showCenterToast:data[@"msg"]];
        }
        [bself.aTableView reloadData];
    } fail:^(NSString *errorString) {
        
    }];
}

@end
