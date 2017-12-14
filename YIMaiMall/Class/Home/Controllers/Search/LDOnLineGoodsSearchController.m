//
//  LDOnLineGoodsSearchController.m
//  YIMaiMall
//
//  Created by Miles on 2017/12/8.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDOnLineGoodsSearchController.h"
#import "LDSearchHeadView.h"
#import "TagViewCell.h"
#import "LDGoodsLisCell.h"
#import "PurchaseCarAnimationTool.h"
#import "LDCommonFilterView.h"
#import "LDSubbranchSelView.h"
#import "LDGoodsListModel.h"
#import "LDSearchDefultCell.h"
@interface LDOnLineGoodsSearchController ()<UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate,LDCommonFilterViewDelegate,LDSubbranchSelViewDelegate>
@property (nonatomic,strong)LDCommonFilterView *filterView;
@end

@implementation LDOnLineGoodsSearchController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _searchBar.delegate  = self;
}
-(LDCommonFilterView*)filterView{
    if (!_filterView) {
        _filterView = [[LDCommonFilterView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 50) titles:@[@"综合",@"销量",@"价格",@"新品"] isShowImgs:@[@"1",@"1",@"1",@"1"] interactions:@[@(1),@(1),@(1),@(1)]  imgTitleIntervals:@[@(-30),@(-30)] titleIntervals:@[@(1),@(1)] normalImages:@[@"triangle_3",@"triangle_3",@"triangle_4",@"store_view1",] selectImages:@[@"triangle_1",@"triangle_2",@"triangle_5",@"store_view2",]];
        _filterView.delegate = self;
        _filterView.tag = 100;
        [self.view addSubview:_filterView];
    }
    return _filterView;
}

- (void)LDCommonFilterView:(LDCommonFilterView *)view clickBtn:(UIButton *)btn{
    
    //状态：0待确认 1已驳回 2已上线 3已下线
    if (btn.selected) {
        
        
        SubbranchStatus  status =  btn.tag == 0?SubbranchStatusImageAndLeft:SubbranchStatusDefulat;
        
        [LDSubbranchSelView showInView:self.view frame:CGRectMake(0, view.bottom,kScreenWidth, SCREEN_HEIGHT - view.bottom-49) SubbranchStatus:status delegate:self dataSource:@[@{@"11":@"111",@"22":@"222",}]  object:@(btn.tag) lastSelIndex:0];
        
        
    } else {
        
        [LDSubbranchSelView dismissFromView:self.view];
    }
}
- (void)LDSubbranchSelView:(LDSubbranchSelView *)view selectedIndex:(NSInteger)selectedIndex{
    
    [LDSubbranchSelView dismissFromView:self.view];
    
    [_filterView rotateArrow];
    
    int tag = [view.object intValue];
    
    
    if (tag==0) {
        
        if (view.lastSelIndex != 0) {
            
        }else{
            
        }
    } else if (tag==1){
        //选择状态
        
    }
}
- (void)LDSubbranchSelViewDismiss:(LDSubbranchSelView *)view{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.NoMoreDataType = NoMoreDataTypeNoSearch;
    self.filterView;
    [self loadCollectionView];
}

- (void)loadCollectionView
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0.5;
    layout.minimumLineSpacing = 5;
    
    if (@available(iOS 11.0, *)) {
        self.aCollectionView.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
        self.aCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0,+50, self.view.frame.size.width, self.view.frame.size.height-64 -44-50) collectionViewLayout:layout];
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.aCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0,50, self.view.frame.size.width, self.view.frame.size.height-64 -44-50) collectionViewLayout:layout];
    }
    
    self.aCollectionView.dataSource = self;
    self.aCollectionView.delegate = self;
    [self.view addSubview:self.aCollectionView];
    self.aCollectionView.backgroundColor = RGB(245, 245, 245);
    layout.headerReferenceSize = CGSizeMake(self.view.width, 5);
    layout.footerReferenceSize = CGSizeMake(0, 0);
    // 注册cell、sectionHeader、sectionFooter
    
    [self.aCollectionView registerClass:[TagViewCell class] forCellWithReuseIdentifier:@"TagViewCell"];
    [self.aCollectionView registerClass:[LDGoodsLisCell class] forCellWithReuseIdentifier:@"LDGoodsLisCell"];
    
    [self.aCollectionView registerNib:[UINib nibWithNibName:@"LDSearchShopCell" bundle:nil] forCellWithReuseIdentifier:@"LDSearchShopCell"];
    
    [self.aCollectionView registerClass:[LDSearchDefultCell class] forCellWithReuseIdentifier:@"LDSearchDefultCell"];
    
    [self.aCollectionView registerClass:[LDSearchHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LDSearchHeadView"];
    
    [self.aCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LDProductCollectionFootView"];
}

//创建头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (_searchBar.text.length == 0 && self.contentArr.count == 0) {
        
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            
            LDSearchHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LDSearchHeadView" forIndexPath:indexPath];
            if (indexPath.section == 0) {
                headView.titleLB.text = @"热门搜索";
            }else{
                headView.titleLB.text = @"历史记录";
            }
            return headView;
        }else{
            UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LDProductCollectionFootView" forIndexPath:indexPath];
            return footerView;
        }
    }else{
        return [UICollectionReusableView new];
    }
}


//一共有多少个区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    if (_searchBar.text.length == 0 && self.contentArr.count == 0) {
        return 2;
    }else if (_searchBar.text.length != 0 && self.contentArr.count == 0){
        return 0;
    }
    return 1;
}
//每一区有多少个cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (_searchBar.text.length == 0 && self.contentArr.count == 0) {//默认进来页面
        if (section == 0) {//热门搜索
            return 1;
        }else{              //搜索历史记录
            return 10;
        }
    }else if (_searchBar.text.length != 0 && self.contentArr.count == 0){//搜索无数据页面
        return 0;
    }else{                                                              //  搜索有数据页面
        return self.contentArr.count;
    }
    
}
//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_searchBar.text.length == 0 && self.contentArr.count == 0) {
        if (indexPath.section == 0) {
            
            CGFloat height =   [TagViewCell cellHeightTextArray:@[@"张三",@"李四",@"网为嘛子",@"淡粉色交付货物",@"的手机不会v",@"是否",@"是不是VB吧 是的v是v",@"方式VB定居点附近"] Row:0];
            return CGSizeMake(SCREEN_WIDTH,height+20);
        }else{
            return CGSizeMake(ScreenWidth ,40);
        }
        
    }else if (_searchBar.text.length != 0 && self.contentArr.count == 0){
        return  CGSizeMake(self.view.width,self.view.height);
    }
    
    return CGSizeMake(self.view.width,SIZEFIT(130));
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    if (_searchBar.text.length == 0 && self.contentArr.count == 0) {
        return UIEdgeInsetsMake(0, 10, 0, 10);//分别为上、左、下、右
    }else if (_searchBar.text.length != 0 && self.contentArr.count == 0){
        return UIEdgeInsetsMake(0, 10, 0, 10);//分别为上、左、下、右
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}

//脚部试图的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (_searchBar.text.length == 0 && self.contentArr.count == 0) {
        
        return CGSizeMake(ScreenWidth , 40);
    }
    return CGSizeMake(0, 0);
}


//脚部试图的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(0, 0);
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_searchBar.text.length == 0 && self.contentArr.count == 0) {//默认进来页面
        
        if (indexPath.section == 0) {//热门搜索栏
            TagViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TagViewCell" forIndexPath:indexPath];
            [cell setTextArray:@[@"张三",@"李四",@"网为嘛子",@"淡粉色交付货物",@"的手机不会v",@"是否",@"是不是VB吧 是的v是v",@"方式VB定居点附近"] row:0];
            return cell;
        }else{ //历史搜索记录栏
            
            LDSearchDefultCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDSearchDefultCell" forIndexPath:indexPath];
            if (indexPath.row == 9) {
                cell.itemLB.text = @"清空历史记录";
                cell.itemLB.textColor = kAppThemeColor;
                cell.itemLB.textAlignment = Center;
            }else{
                cell.itemLB.text = @"的手机不会";
                cell.itemLB.textColor = RGB(51, 51, 51);
                cell.itemLB.textAlignment = Left;
            }
            return cell;
        }
    }else {//搜索有数据页面
        //搜索有数据页面
        
        LDGoodsLisCell *listCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDGoodsLisCell" forIndexPath:indexPath];
        listCell.model = self.contentArr[indexPath.row];
        listCell.isGrid = YES;
        return listCell;
    }
}

//cell的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && _searchBar.text.length == 0 && self.contentArr.count == 0) {
        LDSearchDefultCell *cell0 = (LDSearchDefultCell *)[collectionView cellForItemAtIndexPath:indexPath];
        //        self.searchBar.text = cell0.itemLB.text;
        [self retuestMainDataWithName:cell0.itemLB.text];
    }else if (indexPath.section == 1  && _searchBar.text.length == 0 && self.contentArr.count == 0){//点击历史记录
        
        if (indexPath.row == 9) {
            
            [LDAlterView alterViewWithTitle:@"" content:@"确定清空历史记录吗?" cancel:@"取消" sure:@"确定" cancelBtClcik:^{
                
            } sureBtClcik:^{
                
            }];;
        }
        
    }else if (self.contentArr.count){//跳转到详情页
        
        LDGoodsListModel *model = self.contentArr[indexPath.row];
        //        ClassDetailViewController *vc = [[ClassDetailViewController alloc]init];
        //        vc.skuid = model.SKUID;
        //        vc.cmomodityid  = model.CommodityID;
        //        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - 实现键盘上Search按钮的方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"您点击了键盘上的Search按钮");

        [self retuestMainDataWithName:searchBar.text];
}
#pragma mark - 实现监听开始输入的方法
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    NSLog(@"开始输入搜索内容");
    return YES;
}
#pragma mark - 实现监听输入完毕的方法
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    NSLog(@"输入完毕");
    //    [self retuestMainDataWithName:searchBar.text];
    return YES;
}

-(BOOL)disablesAutomaticKeyboardDismissal{
    return NO;
}

-(void)retuestMainDataWithName:(NSString *)name
{
    [self.view endEditing:YES];
    
    [_searchBar resignFirstResponder];
    
    [self setScroll:self.aCollectionView firstPageNor:1 pageSize:30 networkCallback:^(NSInteger page, CompletionCallback completionCallback) {
        
        NSDictionary *param = @{
                                @"searchText":name,//关键字
                                @"gcId":@"",//商品分类id
                                @"orderType":@"1",//排序类型（//搜索排序类型 1：综合排序 2：销量排序 3：价格升序 4：价格降序
                                @"beginPrice":@"",//商品开始价格
                                @"endPrice":@"",//商品结束价格
                                @"cur":@(page),// 第几页（min=1)
                                @"rp":@"30",// 每页大小（min=1,max=100)
                                };
        [[APIManager sharedManager]onlineGoodsSearchWithData:param CallBack:^(id data) {
            
            RC004;
            NSArray *array = [LDGoodsListModel mj_objectArrayWithKeyValuesArray:data[@"obj"][@"rows"]];
            
            if (array) {
                completionCallback(YES,array);
            }else{
                completionCallback(YES,@[]);
            }
            
        } fail:^(NSString *errorString) {
            completionCallback(NO,@[]);
        }];
        
    } noMoreDataCallback:^(NSInteger page) {
        
    }];
    [self silenceRefresh];
}
@end
