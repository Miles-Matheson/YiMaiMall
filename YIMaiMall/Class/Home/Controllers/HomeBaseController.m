//
//  HomeBaseController.m
//  
//
//  Created by Miles on 2017/11/15.
//

#import "HomeBaseController.h"
#import "LDCustomNavView.h"
#import "LDCollectionBannerCell.h"
#import "LDCollectionIndexCell.h"
#import "LDNoticCollectionCell.h"
#import "LDHomeAreaCell.h"
#import "LDGoodsLisCell.h"
#import "LDProductCollectionHeadView.h"
#import "IHScanController.h"
#import "LDBaseGoodsDetailController.h"
#import "APIManager.h"
#import "LDHomeModel.h"
#import "NSData+AES256.h"

#import "LDOnlineSearchController.h"
@interface HomeBaseController ()<UICollectionViewDelegate,UICollectionViewDataSource,LDCustomNavViewDelegate>

@property (nonatomic,strong)LDCustomNavView *customNavView;
@property (nonatomic,strong)LDHomeModel *mainDataModel;

@end

@implementation HomeBaseController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark LDCustomNavViewDelegate
-(void)navClickHandel:(id)handel WithIndex:(NSInteger)index{
    WS(bself);
    if (index == 10) {//定位
        
    }else if (index == 20){//搜索
        [self.navigationController pushViewController:[LDOnlineSearchController new] animated:YES];
    }else{//二维码扫描
        
        IHScanController *scanVC = [[IHScanController  alloc] init];
        scanVC.onScanCompletion = ^(BOOL isSuccess, NSString *scanStr) {
            if (isSuccess) {  //扫描成功
                if ([scanStr hasPrefix:@"http"]||[scanStr hasPrefix:@"https"]||[scanStr hasPrefix:@"www"]) {
                    
                }
            }
            [bself dismissViewControllerAnimated:YES completion:nil];
        };
        [self presentViewController:scanVC animated:YES completion:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    _mainDataModel = [[LDHomeModel alloc]init];
    
    [self initCollectionView];
    [self initNavView];
    
    [self requestMainData];
}

-(void)initNavView{
    _customNavView = [[LDCustomNavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, isIPhpneX?88:64)];
    _customNavView.delegate = self;
    [self.view addSubview:_customNavView];
}

-(void)initCollectionView{
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = SIZEFIT(5);
    layout.minimumLineSpacing = 0;
    
    layout.footerReferenceSize = CGSizeMake(self.view.size.width, 5);
    
    CGFloat top = isIPhpneX?88:64;
    
    self.aCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0,top,SCREEN_WIDTH,self.view.size.height-top-49) collectionViewLayout:layout];
    self.aCollectionView.backgroundColor = RGB(245, 245, 245);
    self.aCollectionView.dataSource = self;
    self.aCollectionView.delegate = self;
    [self.view addSubview:self.aCollectionView];
    
    // 注册cell、sectionHeader、sectionFooter
    [self.aCollectionView registerClass:[LDCollectionBannerCell class] forCellWithReuseIdentifier:@"LDCollectionBannerCell"];
    [self.aCollectionView registerClass:[LDCollectionIndexCell  class]  forCellWithReuseIdentifier:@"LDCollectionIndexCell"];
    [self.aCollectionView registerClass:[LDNoticCollectionCell  class]  forCellWithReuseIdentifier:@"LDNoticCollectionCell"];
    [self.aCollectionView registerClass:[LDHomeAreaCell  class]  forCellWithReuseIdentifier:@"LDHomeAreaCell"];
    [self.aCollectionView registerClass:[LDGoodsLisCell  class]  forCellWithReuseIdentifier:@"LDGoodsLisCell"];
    
    [self.aCollectionView registerClass:[LDProductCollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LDProductCollectionHeadView"];
    [self.aCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"LDProductCollectionFootView"];
    
    if (@available (iOS 11.0,*)) {
        self.aCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    if (section == 2) {
        return UIEdgeInsetsMake(0, 5, 0, 5);//分别为上、左、下、右
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(0, 0);
    }else{
        return CGSizeMake(self.view.size.width, 40);
    }
}

//创建头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section != 0) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            LDProductCollectionHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LDProductCollectionHeadView" forIndexPath:indexPath];
            if (indexPath.section == 1) {
                [headView.titleBtn setTitle:@"热销市场" forState:0];
                headView.HeaderStyle = HeaderStyleTitleStatus;
            }else if (indexPath.section == 2){
                [headView.titleBtn setTitle:@"人气爆款" forState:0];
                headView.HeaderStyle = HeaderStyleLineTitle;
            };
            
            headView.titleClick = ^{
                [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionTop];
            };
            return headView;
        }else{
            UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"LDProductCollectionFootView" forIndexPath:indexPath];
            return footerView;
        }
    }
    UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"LDProductCollectionFootView" forIndexPath:indexPath];
    return footerView;
}

//一共有多少个区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
//每一区有多少个cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 3;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return self.contentArr.count;
    }
    return 0;
}
//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return CGSizeMake(self.view.width,SIZEFIT(170));
        }else if (indexPath.row == 1){
            return CGSizeMake(self.view.width,SIZEFIT(110));
        }else{
            return CGSizeMake(self.view.width,SIZEFIT(45));
        }
    }else if (indexPath.section == 1){
        return CGSizeMake(self.view.width,SIZEFIT(210));
    }else if (indexPath.section == 2){
        
        CGFloat width = (SCREEN_WIDTH-15)/2.;
        
        return CGSizeMake(width,width*1.522);
    }
    return CGSizeMake(SCREEN_WIDTH,SIZEFIT(215));
}

//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 0 || section == 1 ) {
        return 0;
    }else{
        return 5;
    }
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ws(bself);
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            LDCollectionBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDCollectionBannerCell" forIndexPath:indexPath];
            cell.bannerClick = ^(LDBannerModel *model) {
                
            };
            return cell;
        }else if (indexPath.row == 1){
            
            LDCollectionIndexCell *indexCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDCollectionIndexCell" forIndexPath:indexPath];
            indexCell.models = _mainDataModel.ClassList;
            indexCell.itemClickCallBack = ^(LDClickIndexModel *model) {
                
            };
            return indexCell;
        }else{
            LDNoticCollectionCell *noticCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDNoticCollectionCell" forIndexPath:indexPath];
            noticCell.newsModels = _mainDataModel.noticArray;
            noticCell.itemClick = ^(LDNoticModel *noticModel) {

                if (noticModel) {//跳转到具体的消息页
                    
                }else{//更多
                    [bself.tabBarController setSelectedIndex:2];//跳转到发现页
                }
            };
            return noticCell;
        }
    }else if (indexPath.section == 1){
        
        LDHomeAreaCell *areaCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDHomeAreaCell" forIndexPath:indexPath];
        areaCell.models = _mainDataModel.areaList;
        return areaCell;
        
    }else  if (indexPath.section == 2){
        
        LDGoodsLisCell *goodsListCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDGoodsLisCell" forIndexPath:indexPath];
        goodsListCell.model = self.contentArr[indexPath.row];
        return goodsListCell;
    }
    
    return [UICollectionViewCell new];
}

//cell的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //cell被电击后移动的动画
    
    if (indexPath.section == 2) {

        LDGoodsListModel *model = self.contentArr[indexPath.row];
        self.navigationController.navigationBarHidden = YES;
        [self.navigationController pushViewController:[[LDBaseGoodsDetailController alloc]initWithGoodsID:model.ID] animated:YES];
    }
}

-(void)requestMainData{
    
    ws(bself);
    [self setScroll:self.aCollectionView firstPageNor:1 pageSize:10 networkCallback:^(NSInteger page, CompletionCallback completionCallback) {
        
        if (bself.aCollectionView.contentOffset.y <= 0) {

            [bself getBannerDataRequestCallBack:^(BOOL isSuccess) {

            }];
            [bself getHomeClassListCallBack:^(BOOL isSuccess) {

            }];
            [bself getHomeMallMesssageListCallBack:^(BOOL isSuccess) {

            }];

            [bself getHomeHotmarketListCallBack:^(BOOL isSuccess) {

            }];
        }
        
        [bself getHomeGoodsPopularListWithPage:page row:10 CallBack:^(BOOL isSuccess,NSArray *resultArray) {
            completionCallback(isSuccess,resultArray);
        }];
        
    } noMoreDataCallback:^(NSInteger page) {

    }];
    
    [self refreshScroll];
}
-(void)getBannerDataRequestCallBack:(void(^)(BOOL isSuccess))callBack{
    
    ws(bself);
    [[APIManager sharedManager] getHomeBannerListDataCallBack:^(id data) {
        
        NSArray *array =  [LDBannerModel mj_objectArrayWithKeyValuesArray:data[@"obj"]];
        
        if (array) {
            LDCollectionBannerCell *cell = (LDCollectionBannerCell*)[bself.aCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            cell.models = array;
            [bself.aCollectionView reloadData];
        }
        callBack(YES);
    } fail:^(NSString *errorString) {
        callBack(NO);
    }];
}

-(void)getHomeClassListCallBack:(void(^)(BOOL isSuccess))callBack{
    
    ws(bself);
    [[APIManager sharedManager] getHomeClassListCallBack:^(id data) {
        
        NSArray *array = [LDClickIndexModel mj_objectArrayWithKeyValuesArray:data[@"obj"]];
        if (array) {
             _mainDataModel.ClassList = array;
            [bself.aCollectionView  reloadData];
        }
        callBack(YES);
    } fail:^(NSString *errorString) {
         callBack(NO);
    }];
}
-(void)getHomeMallMesssageListCallBack:(void(^)(BOOL isSuccess))callBack{
    
    ws(bself);
    [[APIManager sharedManager] getHomeMallMesssageListCallBack:^(id data) {
        
        NSArray *array = [LDNoticModel mj_objectArrayWithKeyValuesArray:data[@"obj"]];
        if (array) {
            bself.mainDataModel.noticArray = array;
            [bself.aCollectionView  reloadData];
        }
        callBack(YES);
    } fail:^(NSString *errorString) {
         callBack(NO);
    }];
}

-(void)getHomeHotmarketListCallBack:(void(^)(BOOL isSuccess))callBack{
    
    ws(bself);
    [[APIManager sharedManager] getHomeHotmarketListCallBack:^(id data) {
        
        NSArray *array = [LDHomeAreaModel mj_objectArrayWithKeyValuesArray:data[@"obj"]];
        if (array) {
            bself.mainDataModel.areaList = array;
            [bself.aCollectionView  reloadData];
        }
        callBack(YES);
    } fail:^(NSString *errorString) {
         callBack(NO);
    }];
}

//cur：当前第几页（从1开始）
//rp：每页多少条（1~100）

-(void)getHomeGoodsPopularListWithPage:(NSInteger)page row:(NSInteger)row  CallBack:(void(^)(BOOL isSuccess,NSArray *resultArray))callBack{

    NSDictionary *param = @{
                            @"cur":@(page),
                            @"rp":@(row),
                            };
    
    [[APIManager sharedManager] getHomeGoodsPopularListWithData:param CallBack:^(id data) {
        
      NSArray *array =  [LDGoodsListModel mj_objectArrayWithKeyValuesArray:data[@"obj"][@"rows"]];
      
        if (array) {
            callBack(YES,array);
        }else{
            callBack(NO,@[]);
        }

    } fail:^(NSString *errorString) {
        callBack(NO,@[]);
    }];
}

@end
