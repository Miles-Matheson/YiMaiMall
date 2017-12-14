//
//  FSBaseViewController.m
//  FSScrollViewNestTableViewDemo
//
//  Created by huim on 2017/5/23.
//  Copyright © 2017年 fengshun. All rights reserved.
//
#define KGenericColor [UIColor colorWithRed:49/255.0 green:194/255.0 blue:124/255.0 alpha:1.0]
#import "FSBaseViewController.h"
#import "FSBaseTableView.h"
#import "WMSearchBar.h"

#import "FSPageContentView.h"
#import "FSSegmentTitleView.h"

#import "LDBaseShopDetailController.h"
#import "FSBottomTableViewCell.h"

#import "LDShopHeaderView.h"

#import "LDShopClassController.h"///宝贝分类
#import "LDShopIntroduceController.h"//店铺介绍

#import "LDStoreModel.h"

@interface FSBaseViewController ()<UITableViewDelegate,UITableViewDataSource,FSPageContentViewDelegate,FSSegmentTitleViewDelegate,UISearchBarDelegate>



@property (nonatomic, strong)LDStoreModel *storeModel;
@property (nonatomic, strong) LDShopHeaderView *headerView;

@property(nonatomic,strong)WMSearchBar *searchBar;
@property (nonatomic, copy) NSArray *titleArray;

@property (nonatomic, strong) FSBottomTableViewCell *contentCell;
@property (nonatomic, strong) FSSegmentTitleView *titleView;
@property (nonatomic, assign) BOOL canScroll;
@end

@implementation FSBaseViewController

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
     self.navBackgroundImageView.alpha = 0;
     [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navBackgroundImageView.alpha = 1;
}

#pragma mark - add view

- (void)addSearchBar {
    
    _searchBar = [self addSearchBarWithFrame:CGRectMake(0, 0, kScreenWidth - 2 * 44 - 2 * 15, 44)];
    UIView *wrapView = [[UIView alloc] initWithFrame:_searchBar.frame];
    [wrapView addSubview:_searchBar];
    self.navigationItem.titleView = wrapView;
}

- (WMSearchBar *)addSearchBarWithFrame:(CGRect)frame {
    
    self.definesPresentationContext = YES;
    
    WMSearchBar *searchBar = [[WMSearchBar alloc]initWithFrame:frame];

    searchBar.delegate = self;
    searchBar.placeholder = @"搜索本店                    ";
    [searchBar setShowsCancelButton:NO];
    [searchBar setTintColor:KGenericColor];
    
//    if (self.isChangeSearchBarFrame) {
//
//        CGFloat height = searchBar.bounds.size.height;
//        CGFloat top = (height - 20.0) / 2.0;
//        CGFloat bottom = top;
//
//        searchBar.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
//    }
    return searchBar;
}

#pragma mark - searchBar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
}

#pragma mark - button click
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [_searchBar resignFirstResponder];
}

-(void)rightBtnClick:(UIButton *)button{
    ws(bself);
    NSArray *array = @[@{@"title":@"宝贝分类",@"image":@""},@{@"title":@"店铺介绍",@"image":@""}];
    
    [self showMoreViewWithHandl:button InfoData:array CallBack:^(NSInteger selectIndex) {
        
        if (selectIndex == 0) {
            
            LDShopClassController *classVC = [[LDShopClassController alloc]init];
            classVC.storeId = _storeId;
            classVC.title = _headerView.model.storeName;
            [bself.navigationController pushViewController:classVC animated:YES];
        }else if (selectIndex == 1){
            LDShopIntroduceController *introduceVC = [[LDShopIntroduceController alloc]init];
            introduceVC.dataSouce = _storeModel;
            [bself.navigationController pushViewController:introduceVC animated:YES];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self addSearchBar];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 55, 40);
    [btn setTitle:@"..." forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    
    [self getShopBaseInfoRequestWithStoreId:_storeId];
    
    self.navBackgroundImageView.alpha = 0;//self.aTableView.contentOffset.y/64;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:@"leaveTop" object:nil];
    
    _titleArray = @[@"店铺首页",@"全部商品",@"热销商品",@"商品上新"];

    self.aTableView = [[FSBaseTableView alloc]initWithFrame:CGRectMake(0, 0,CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) style:UITableViewStylePlain];
    self.aTableView.delegate = self;
    self.aTableView.dataSource = self;
    [self.view addSubview:self.aTableView];
    
    if (@available (iOS 11.0,*)) {
        self.aTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
//    [self setRightText:@"...." textColor:nil ImgPath:nil];
    [self setupSubViews];
}

- (void)setupSubViews{
    self.canScroll = YES;
    self.aTableView.backgroundColor = [UIColor whiteColor];
    __weak typeof(self) weakSelf = self;
//    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf insertRowAtTop];
//    }];
}

- (void)insertRowAtTop{
    self.contentCell.currentTagStr = _titleArray[self.titleView.selectIndex];
    self.contentCell.isRefresh = YES;
//    [self.tableView.pullToRefreshView stopAnimating];
}

#pragma mark notify
- (void)changeScrollStatus{//改变主视图的状态
    self.canScroll = YES;
    self.contentCell.cellCanScroll = NO;
}

#pragma mark UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 200;
    }
    return CGRectGetHeight(self.view.bounds);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 50) titles:_titleArray delegate:self indicatorType:FSIndicatorTypeEqualTitle];
    self.titleView.backgroundColor = [UIColor whiteColor];
    return self.titleView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ws(bself);
    if (indexPath.section == 0) {
        UITableViewCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"headerCell"];
        if (!headerCell) {
            headerCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"headerCell"];
            _headerView = [[LDShopHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
            [headerCell.contentView addSubview:_headerView];
            _headerView.foucsClick = ^{
                [bself onlineStoreFoucsOrCancelGoodsWithStoreId:bself.storeId];
            };
            [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.offset(0);
            }];
        }
         return headerCell;
    }else{
        _contentCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!_contentCell) {
            _contentCell = [[FSBottomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];

            NSMutableArray *contentVCs = [NSMutableArray array];
            
            for (int i = 0; i < _titleArray.count; i++) {
                LDBaseShopDetailController *vc = [[LDBaseShopDetailController alloc]init];
                vc.storeId = self.storeId;
                vc.selectIndex = i;
                [contentVCs addObject:vc];
            }
            _contentCell.viewControllers = contentVCs;
            _contentCell.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64) childVCs:contentVCs parentVC:self delegate:self];
            [_contentCell.contentView addSubview:_contentCell.pageContentView];
        }
        return _contentCell;
    }
    return [UITableViewCell new];
}

#pragma mark FSSegmentTitleViewDelegate
- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex{
    
    self.titleView.selectIndex = endIndex;
    self.aTableView.scrollEnabled = YES;//此处其实是监测scrollview滚动，pageView滚动结束主tableview可以滑动，或者通过手势监听或者kvo，这里只是提供一种实现方式
}

- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex{
    
    self.contentCell.pageContentView.contentViewCurrentIndex = endIndex;
}

- (void)FSContentViewDidScroll:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex progress:(CGFloat)progress{
    self.aTableView.scrollEnabled = NO;//pageView开始滚动主tableview禁止滑动
}

#pragma mark UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat bottomCellOffset = [self.aTableView rectForSection:1].origin.y - 64;
    if (scrollView.contentOffset.y >= bottomCellOffset) {
        scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        if (self.canScroll) {
            self.canScroll = NO;
            self.contentCell.cellCanScroll = YES;
        }
    }else{
        if (!self.canScroll) {//子视图没到顶部
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        }
    }
    self.aTableView.showsVerticalScrollIndicator = _canScroll?YES:NO;
    self.navBackgroundImageView.alpha = 0;//self.aTableView.contentOffset.y/64;
}

-(void)getShopBaseInfoRequestWithStoreId:(NSString *)storeId{
    
    ws(bself);
    [[APIManager sharedManager] getOnlineStoreIdInfoWithStoreId:storeId?storeId:@"" CallBack:^(id data) {
      bself.storeModel = [LDStoreModel mj_objectWithKeyValues:data[@"obj"]];
        bself.headerView.model = bself.storeModel;
    } fail:^(NSString *errorString) {
        
    }];
}
-(void)onlineStoreFoucsOrCancelGoodsWithStoreId:(NSString *)storeId{

    ws(bself);
    [[APIManager sharedManager] onlineStoreFoucsOrCancelGoodsWithStoreId:storeId?storeId:@"" isFoucs:!_headerView.model.isAttention CallBack:^(id data) {
        RC001;
        [bself.view showCenterToast:data[@"msg"]];
        bself.storeModel.favoriteCount = bself.storeModel.isAttention?bself.storeModel.favoriteCount-1:bself.storeModel.favoriteCount+1;
        bself.storeModel.isAttention  =  !bself.storeModel.isAttention;
        bself.headerView.model = bself.storeModel;
    } fail:^(NSString *errorString) {

    }];
}

@end
