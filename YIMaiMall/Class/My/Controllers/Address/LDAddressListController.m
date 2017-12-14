//
//  GoodsAddressController.m
//  BaseFrame
//
//  Created by Miles on 2017/6/23.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import "LDAddressListController.h"
#import "LDGoodsAddCell.h"
#import "EditAddressViewController.h"

@interface LDAddressListController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LDAddressListController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = WhiteColor;
    [self setTitleTtextColor:BlackColor];
    self.navBackgroundImageView.alpha = 1.0;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"收货地址";
    
    [self setRightText:@"添加" textColor:RGB(51, 51, 51) ImgPath:nil];

    [self initTableView];
    
    [self request];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(request) name:RELOADADDRESS object:nil];
}

- (void)clickRightBtn:(UIButton *)rightBtn
{
    //点击添加按钮
    EditAddressViewController *vc = [[EditAddressViewController alloc]init];

    [self.navigationController pushViewController:vc animated:YES];
}

- (void)initTableView
{
    self.aTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64,SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    self.aTableView.delegate = self;
    self.aTableView.dataSource = self;
    self.aTableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.aTableView];
    
    [self registerCell];
}
- (void)registerCell
{
    [self.aTableView registerClass:[LDGoodsAddCell class] forCellReuseIdentifier:@"LDGoodsAddCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.contentArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger sectioin = (NSInteger)indexPath.section;
    
    LDAddressListModel * model = self.contentArr[sectioin];
    
    CGSize size = [LLUtils getStringSize:model.areaInfo font:16 width:SCREEN_WIDTH-30];
    
    return size.height +[MyAdapter laDapter:160] -19 ;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contentArr.count == 0?0:1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.contentArr.count != 0) {
        ws(bself);
        LDGoodsAddCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDGoodsAddCell"];
        
        cell.model = self.contentArr[indexPath.section];
        
        cell.bianjiBlock = ^(LDAddressListModel *addModel){
            
            EditAddressViewController *vc = [[EditAddressViewController alloc]init];
            vc.addressModel = addModel;
            [bself.navigationController pushViewController:vc animated:YES];
            
        };
        cell.adderssBlock = ^(LDAddressListModel *model) {//设置默认地址
            
            [bself setDefaultAddressWithId:model.ID];
        };
        cell.shanchuBlock = ^(LDAddressListModel *model) {//删除地址
            [LLUtils showAlterView:bself title:@"提示" message:@"确认删除改地址?" yesBtnTitle:@"确认" noBtnTitle:@"取消" yesBlock:^{
                [bself deleteAddressWithId:model.ID];
            } noBlock:^{}];
            
        };
        return cell;
        
    }else{
        
        return [UITableViewCell new];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LDAddressListModel *model = self.contentArr[indexPath.section];
    
    if (self.chageNewAdressCallBack) {
        
        _chageNewAdressCallBack(model);
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)request{
    
    [self setScroll:self.aTableView firstPageNor:1 pageSize:10 networkCallback:^(NSInteger page, CompletionCallback completionCallback) {

        NSDictionary *dataDic = @{
                                  @"cur":@(page),
                                  @"rp":@"10",
                                  };
        [[APIManager sharedManager] getUserAddressListWithData:dataDic CallBack:^(id data) {
            
           NSArray *array = [LDAddressListModel mj_objectArrayWithKeyValuesArray:data[@"obj"][@"rows"]];
            completionCallback(array?YES:NO,array?array:@[]);
            
        } fail:^(NSString *errorString) {
            completionCallback(NO,@[]);
        }];
    } noMoreDataCallback:^(NSInteger page) {
        
    }];
    [self silenceRefresh];
}

- (void)setDefaultAddressWithId:(NSString *)ID{
    ws(bself);
    [[APIManager sharedManager] setDefultAddressAddreddID:ID CallBack:^(id data) {
        
        [bself silenceRefresh];
        NSString * message = data[@"msg"];
        [Dialog toastCenter:message];
        
    } fail:^(NSString *errorString) {
        
    }];
}

- (void)deleteAddressWithId:(NSString *)ID{
    ws(bself);
    [[APIManager sharedManager] deleateAddressAddreddID:ID CallBack:^(id data) {
        
        [bself silenceRefresh];
        NSString * message = data[@"msg"];
        [Dialog toastCenter:message];
    } fail:^(NSString *errorString) {
        
    }];
}

@end
