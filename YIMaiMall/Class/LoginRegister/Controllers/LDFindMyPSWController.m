//
//  LDFindMyPSWController.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/28.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDFindMyPSWController.h"
#import "LDFindPswCell.h"
@interface LDFindMyPSWController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)int timeCount;
@end

@implementation LDFindMyPSWController

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_timer setFireDate:[NSDate distantFuture]];
    self.navBackgroundImageView.alpha = 1.0;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_timer setFireDate:[NSDate distantPast]];
    self.navBackgroundImageView.alpha = 1.0;
    
}

-(NSTimer *)timer
{
    _timeCount = 10;
    if (!_timer) {
        _timer=[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timeDown) userInfo:nil repeats:YES];
        //将定时器添加到runloop中
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

-(void)timeDown{
    
    LDFindPswCell *findCell = [self.aTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [findCell timeDown:_timeCount];
    _timeCount-- ;
    if (_timeCount < 0) {
        [_timer invalidate];
        _timer = nil;
        _timeCount = 10;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.navigationItem.title = @"找回密码";
    
    [self initTableView];
}

-(void)initTableView
{
    self.aTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height) style:UITableViewStyleGrouped];
    self.aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.aTableView.delegate   = self;
    self.aTableView.dataSource = self;
    self.aTableView.showsHorizontalScrollIndicator = NO;
    self.aTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.aTableView];
    self.aTableView.backgroundColor = WhiteColor;
    
    [self registerCell];
}
-(void)registerCell{
    
    [self.aTableView registerClass:[LDFindPswCell class] forCellReuseIdentifier:@"LDFindPswCell"];
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
    return SCREEN_HEIGHT;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ws(bself);
    LDFindPswCell *findCell = [tableView dequeueReusableCellWithIdentifier:@"LDFindPswCell"];
    findCell.findItemClick  = ^(NSInteger index, LDFindPswCell *cell) {
        [bself findCellClickWithIndex:index Cell:cell];
    };
    return findCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

//注册页面点击页面响应
-(void)findCellClickWithIndex:(NSInteger)index Cell:(LDFindPswCell *)cell
{
    if (index == 0) {

        
//        [self getMsgCodeWithDataDynamicWithMobile:cell.phoneTextFild.text Code:self.codeView.codeTextFiled.text];
        
    }else if (index == 1){//注册
        
//        [self getVerificationMobileCodeWithDynamicWithMobile:cell.phoneTextFild.text Code:cell.pswTextFild.text Psw:cell.rePswTextFild.text];
        
    }else{//用户协议
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}



@end
