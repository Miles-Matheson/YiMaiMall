//
//  LDOnLineStoreSearchController.m
//  YIMaiMall
//
//  Created by Miles on 2017/12/8.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDOnLineStoreSearchController.h"
#import "LDSearchHeadView.h"
#import "TagViewCell.h"
#import "LDSearchDefultCell.h"
#import "PurchaseCarAnimationTool.h"
#import "LDCommonFilterView.h"
#import "LDSubbranchSelView.h"
#import "LDSearchShopCell.h"

@interface LDOnLineStoreSearchController ()<UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate>

@end

@implementation LDOnLineStoreSearchController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _searchBar.delegate  = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   self.NoMoreDataType = NoMoreDataTypeNoSearch;
    [self loadCollectionView];
}

- (void)loadCollectionView
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0.5;
    layout.minimumLineSpacing = 5;
    
    if (@available(iOS 11.0, *)) {
        self.aCollectionView.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
        self.aCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height-64-44 ) collectionViewLayout:layout];
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.aCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height-64-44 ) collectionViewLayout:layout];
    }
    
    self.aCollectionView.dataSource = self;
    self.aCollectionView.delegate = self;
    [self.view addSubview:self.aCollectionView];
    self.aCollectionView.backgroundColor = RGB(245, 245, 245);
    layout.headerReferenceSize = CGSizeMake(self.view.width, 5);
    layout.footerReferenceSize = CGSizeMake(0, 0);
    // 注册cell、sectionHeader、sectionFooter
    
    [self.aCollectionView registerClass:[TagViewCell class] forCellWithReuseIdentifier:@"TagViewCell"];
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

    return CGSizeMake(self.view.width,SIZEFIT(195));

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

            LDSearchShopCell *shopCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDSearchShopCell" forIndexPath:indexPath];
            shopCell.model = self.contentArr[indexPath.row];
            return shopCell;

    }
}

//cell的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && _searchBar.text.length == 0 && self.contentArr.count == 0) {
        LDSearchDefultCell *cell0 = (LDSearchDefultCell *)[collectionView cellForItemAtIndexPath:indexPath];

    }else if (indexPath.section == 1  && _searchBar.text.length == 0 && self.contentArr.count == 0){//点击历史记录
        
        if (indexPath.row == 9) {
            
            [LDAlterView alterViewWithTitle:@"" content:@"确定清空历史记录吗?" cancel:@"取消" sure:@"确定" cancelBtClcik:^{
                
            } sureBtClcik:^{
                
            }];;
        }
        
    }else if (self.contentArr.count){//跳转到详情页
        
      
        //        ClassDetailViewController *vc = [[ClassDetailViewController alloc]init];
        //        vc.skuid = model.SKUID;
        //        vc.cmomodityid  = model.CommodityID;
        //        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - 实现键盘上Search按钮的方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"您点击了键盘上的Search按钮");
    [self onLineStoreSearchWithName:searchBar.text];
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

-(void)onLineStoreSearchWithName:(NSString *)name{
    
    [_searchBar resignFirstResponder];
    
    [self setScroll:self.aCollectionView firstPageNor:1 pageSize:30 networkCallback:^(NSInteger page, CompletionCallback completionCallback) {
        
        NSDictionary *param = @{
                                @"storeName":name,//关键字
                                @"cur":@(page),// 第几页（min=1)
                                @"rp":@"30",// 每页大小（min=1,max=100)
                                };
        
        [[APIManager sharedManager] onlineStoreSearchWithData:param CallBack:^(id data) {
            
            RC004;
            NSArray *array = [LDShopListModel mj_objectArrayWithKeyValuesArray:data[@"obj"][@"rows"]];
            
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
