//
//  LDCouponSonController.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/30.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDCouponSonController.h"

#import "LDQuanListCell.h"
#import "LDCouponListModel.h"
@interface LDCouponSonController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy) NSString *identifier;
@end

@implementation LDCouponSonController

-(instancetype)initWithReuseIdentifier:(NSString *)identifier{
    
    if (self = [super init]) {
        _identifier = identifier;
    }
    return self;
}

-(void)setCouponModelList:(NSArray<LDCouponListModel *> *)couponModelList{
    _couponModelList = couponModelList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
    
    if (!_couponModelList.count) {
        
    }
}

-(void)initTableView
{
    self.aTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.bounds.size.height-64-44) style:UITableViewStyleGrouped];
    self.aTableView.delegate  = self;
    self.aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.aTableView.dataSource  = self;
    [self.view addSubview:self.aTableView];
    
    [self registerCell];
}
-(void)registerCell{
    //LDQuanListCell_Normal
    [self.aTableView registerNib:[UINib nibWithNibName:@"LDQuanListCell" bundle:nil] forCellReuseIdentifier:_identifier];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
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
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SIZEFIT(90);
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LDCouponListModel *model = [[LDCouponListModel alloc]init];
    model.status = 1;
    
    LDQuanListCell *cell = [tableView dequeueReusableCellWithIdentifier:_identifier];
    cell.rightBtnClickCallBack = ^(LDCouponListModel *model) {
        
    };
    cell.identifier = _identifier;
    cell.model = model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
