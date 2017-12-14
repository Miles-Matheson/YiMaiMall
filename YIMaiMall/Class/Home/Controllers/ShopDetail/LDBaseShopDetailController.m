//
//  LDBaseShopDetailController.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/24.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDBaseShopDetailController.h"

////////首页商品
#import "LDShopHomeADCell.h"
#import "LDShopHomeHeaderCell.h"
#import "LDGoodsLisCell.h"
#import "LDProductCollectionHeadView.h"


////////全部商品
#import "LDCommonFilterView.h"
#import "LFButton.h"
#import "LDGoodsLisCell.h"
#import "LDProductCollectionHeadView.h"


@interface LDBaseShopDetailController ()<UICollectionViewDelegate,UICollectionViewDataSource,LDCommonFilterViewDelegate>
@property (nonatomic, assign) BOOL fingerIsTouch;

@property (nonatomic,strong)LDCommonFilterView *filterView;
@property (nonatomic,assign)NSInteger orderType;//1价格降序排      2价格升序排     3销量降序排    4销量升序排    不传综合查询）
@property (nonatomic, assign) BOOL isGrid;

@end

@implementation LDBaseShopDetailController

- (void)LDCommonFilterView:(LDCommonFilterView *)view clickBtn:(LFButton *)btn{
    
    NSArray *array = view.showBtns;
    
    if (btn.tag == 3) {
        
        [btn setImage:[UIImage imageNamed:@"store_view1"] forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:@"store_view2"] forState:UIControlStateNormal];
        
        _isGrid = !_isGrid;
        [self.aCollectionView reloadData];
    }else{
        
        for (int i = 0; i < array.count; i ++) {
            
            if (i != 3) {
                
                LFButton *button = (LFButton *)array[i];
                NSString *normalName = nil;
                NSString *selectImage = nil;
                
                if (i == 2 && btn == button) {

                    [button setTitleColor:kAppSubThemeColor forState:UIControlStateNormal];
                    [button setTitleColor:kAppSubThemeColor forState:UIControlStateSelected];
                    normalName = @"triangle_5";
                    selectImage = @"triangle_6";
                }else{
                    if (btn != button) {
                        button.selected = NO;
                        normalName = i == 0?@"triangle_3":i == 1?@"triangle_3":@"triangle_4";
                        selectImage = i == 0?@"triangle_1":i == 1?@"triangle_2":@"triangle_5";
                    }else{
                        normalName = i == 0?@"triangle_3":i == 1?@"triangle_3":@"triangle_4";
                        selectImage = i == 0?@"triangle_1":i == 1?@"triangle_2":@"triangle_6";
                    }
                    [button setTitleColor:RGB(50, 50, 50) forState:UIControlStateNormal];
                    [button setTitleColor:kAppSubThemeColor forState:UIControlStateSelected];
                }
                [button setImage:[UIImage imageNamed:normalName]  forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:selectImage]  forState:UIControlStateSelected];
            }
        }
    }
    
    if (btn.tag != 3) {
        _orderType = btn.tag+1;
        [self getOnLineStoreGoodsAllWithStoreId:_storeId?_storeId:@""];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.selectIndex == 0) {
    }else if (self.selectIndex == 1) {
        self.filterView.hidden = NO;
    }else if (self.selectIndex == 2){
        
    }

    [self setupSubViews];
    if (self.selectIndex == 0) {
        [self getOnLineStoreReferralsWithStoreId:_storeId?_storeId:@""];
    }else if (self.selectIndex == 1) {
        [self getOnLineStoreGoodsAllWithStoreId:_storeId?_storeId:@""];
    }else if (self.selectIndex == 2){
         [self getOnlineGoodsHotWithStoreId:_storeId?_storeId:@""];
    }else{
        [self getOnlineGoodsLatestWithStoreId:_storeId?_storeId:@""];
    }
    
}


-(LDCommonFilterView*)filterView{
    if (!_filterView) {
        _filterView = [[LDCommonFilterView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 44) titles:@[@"综合",@"销量",@"价格",@"    "] isShowImgs:@[@(1),@(1),@(1),@(1),] interactions:@[@(1),@(1),@(1),@(1),] imgTitleIntervals:@[@(0),@(0),@(0),@(0),] titleIntervals:@[@(0),@(0),@(0),@(0),] normalImages:@[@"triangle_3",@"triangle_3",@"triangle_4",@"store_view2",] selectImages:@[@"triangle_1",@"triangle_2",@"triangle_5",@"store_view1",]];
            _filterView.delegate = self;
        [self.view addSubview:_filterView];
    }
    return _filterView;
}

- (void)setupSubViews{

    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    
    layout.headerReferenceSize = CGSizeMake(self.view.width, 10);

    CGFloat height = self.selectIndex == 1?40:0;
    
    self.aCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0,height, self.view.frame.size.width,self.view.bounds.size.height-64-50-height) collectionViewLayout:layout];
    self.aCollectionView.backgroundColor = BlueColor;
    self.aCollectionView.dataSource = self;
    self.aCollectionView.delegate = self;
    [self.view addSubview:self.aCollectionView];

    [self.aCollectionView registerClass:[LDShopHomeADCell class]forCellWithReuseIdentifier:@"LDShopHomeADCell"];
    [self.aCollectionView registerClass:[LDShopHomeHeaderCell class] forCellWithReuseIdentifier:@"LDShopHomeHeaderCell"];
    [self.aCollectionView registerClass:[LDGoodsLisCell class] forCellWithReuseIdentifier:@"LDGoodsLisCell"];
    
    [self.aCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LDProductCollectionFootView"];
    
    [self insertRowAtBottom];
}

- (void)insertRowAtBottom{
    ws(bself);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [bself.aCollectionView reloadData];
    });
}

#pragma mark Setter
- (void)setIsRefresh:(BOOL)isRefresh{
    _isRefresh = isRefresh;
    [self insertRowAtTop];
}
- (void)insertRowAtTop{
    
    ws(bself);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [bself.aCollectionView reloadData];
    });
}

//创建头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (self.selectIndex == 1) {
        if (indexPath.section == 3) {
            if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
                LDProductCollectionHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LDProductCollectionHeadView" forIndexPath:indexPath];
                [headView.titleBtn setTitle:@"为您推荐" forState:0];
                headView.moreItemClick  = ^{
                    [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionTop];
                };
                return headView;
            }else{
                UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LDProductCollectionFootView" forIndexPath:indexPath];
                return footerView;
            }
        }else{
            UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LDProductCollectionFootView" forIndexPath:indexPath];
            return footerView;
        }
    }else if (self.selectIndex == 2){
        
    }else{
 
    }
    UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LDProductCollectionFootView" forIndexPath:indexPath];
    return footerView;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    if (self.selectIndex == 0) {
        if (section == 2) {
            return UIEdgeInsetsMake(0, 5, 0, 5);//分别为上、左、下、右
        }
        return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
    }else if (self.selectIndex == 1){
        if (section == 0 && !_isGrid) {
            return UIEdgeInsetsMake(0, 5, 0, 5);//分别为上、左、下、右
        }
        return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
    }else{
        return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
    }
}
//一共有多少个区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (self.selectIndex == 0) {
        return 3;
    }else if (self.selectIndex == 1){
        return 1;
    }else if(self.selectIndex == 2){
        return 1;
    }else{
        return 1;
    }
}
//每一区有多少个cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.selectIndex == 0) {
        if (section == 2) {
            return self.contentArr.count;
        }else{
            return 1;
        }
    }else if (self.selectIndex == 1){
        return self.contentArr.count;
    }else if (self.selectIndex == 2){
        return self.contentArr.count;
    }else{
        return self.contentArr.count;
    }
     return 10;
}

//定义每一个cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (self.selectIndex == 0) {
        return 5;
    }else if (self.selectIndex == 1 && !_isGrid){
        return 5;
    }else{
        return 0;
    }
}

//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    if (self.selectIndex == 0) {
        return section == 2?5:0;
    }else if (self.selectIndex == 1){
        return _isGrid?0.5:5;
    }else {
        return  0;
    }
}
//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (self.selectIndex == 0) {
        if (indexPath.section == 0) {
            return CGSizeMake(self.view.width,SIZEFIT(140));
        }else if(indexPath.section == 1){
            return CGSizeMake(self.view.width,SIZEFIT(45));
        }else{
            return CGSizeMake(self.view.width/2.-15,SIZEFIT(216));
        }
    }else if (self.selectIndex == 1){
        CGFloat width = _isGrid?SCREEN_WIDTH:(SCREEN_WIDTH-15)/2.;
         return _isGrid?CGSizeMake(width,SIZEFIT(130)):CGSizeMake(width,width*1.522);
    }else{
      return   CGSizeMake(self.view.width/2,SIZEFIT(216));
    }
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (self.selectIndex == 0) {
        if (indexPath.section == 0) {
            LDShopHomeADCell *shopADImageCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDShopHomeADCell" forIndexPath:indexPath];
            [shopADImageCell.shopADImageView sd_setImageWithURL:[NSURL URLWithString:@"http://116.62.133.218:888/file/Pic/2017-10/63643396926687808630XI6CUUEN.jpg"] placeholderImage:[UIImage imageNamed:KplaceholderImage]];
            return shopADImageCell;
        }else if (indexPath.section == 1){
            LDShopHomeHeaderCell *headerCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDShopHomeHeaderCell" forIndexPath:indexPath];
            return headerCell;
        }else{
            LDGoodsLisCell *goodsListCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDGoodsLisCell" forIndexPath:indexPath];
            goodsListCell.model = self.contentArr[indexPath.row];
            return goodsListCell;
        }
    }else if (self.selectIndex == 1){
        LDGoodsLisCell *goodsListCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDGoodsLisCell" forIndexPath:indexPath];
        goodsListCell.model = self.contentArr[indexPath.row];
        goodsListCell.isGrid = _isGrid;
        return goodsListCell;
    }else{
        LDGoodsLisCell *goodsListCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDGoodsLisCell" forIndexPath:indexPath];
        goodsListCell.model = self.contentArr[indexPath.row];;
        return goodsListCell;
    }
}

//cell的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //cell被电击后移动的动画
   
}


#pragma mark UIScrollView
//判断屏幕触碰状态
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"接触屏幕");
    self.fingerIsTouch = YES;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    NSLog(@"离开屏幕");
    self.fingerIsTouch = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.vcCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    if (scrollView.contentOffset.y <= 0) {
        
        self.vcCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTop" object:nil];//到顶通知父视图改变状态
    }
    self.aCollectionView.showsVerticalScrollIndicator = _vcCanScroll?YES:NO;
}

-(void)getOnLineStoreReferralsWithStoreId:(NSString *)storeId{

    [self setScroll:self.aCollectionView firstPageNor:1 pageSize:10 networkCallback:^(NSInteger page, CompletionCallback completionCallback) {

        NSDictionary *param = @{
                                @"storeId":storeId,
                                @"currentPage":@(page),
                                @"pageSize":@"15",
                                };
        
        [[APIManager sharedManager] onlineStoreReferralsWithData:param CallBack:^(id data) {
            NSArray *array = [LDGoodsListModel mj_objectArrayWithKeyValuesArray:data[@"obj"][@"rows"]];
            completionCallback(array?YES:NO,array?array:@[]);
        } fail:^(NSString *errorString) {
            completionCallback(NO,@[]);
        }];
    } noMoreDataCallback:^(NSInteger page) {
    }];
    [self refreshScroll];
}

//online/store/goods/all
-(void)getOnLineStoreGoodsAllWithStoreId:(NSString *)storeId{

    ws(bself);
    [self setScroll:self.aCollectionView firstPageNor:1 pageSize:10 networkCallback:^(NSInteger page, CompletionCallback completionCallback) {
        
        NSDictionary *param = @{
                                @"storeId":storeId,
                                @"orderType":@(bself.orderType),//（1价格降序排      2价格升序排     3销量降序排    4销量升序排    不传综合查询）
                                @"currentPage":@(page),
                                @"pageSize":@"15",
                                };
        [[APIManager sharedManager] onlineStoreGoodsAllWithData:param CallBack:^(id data) {
            NSArray *array = [LDGoodsListModel mj_objectArrayWithKeyValuesArray:data[@"obj"][@"rows"]];
            completionCallback(array?YES:NO,array?array:@[]);
        } fail:^(NSString *errorString) {
            completionCallback(NO,@[]);
        }];
        
    } noMoreDataCallback:^(NSInteger page) {
    }];
    [self refreshScroll];
}

-(void)getOnlineGoodsHotWithStoreId:(NSString *)storeId{
    
    [self setScroll:self.aCollectionView firstPageNor:1 pageSize:10 networkCallback:^(NSInteger page, CompletionCallback completionCallback) {
        
        NSDictionary *param = @{
                                @"storeId":storeId,
                                @"currentPage":@(page),
                                @"pageSize":@"15",
                                };
        [[APIManager sharedManager] onlineGoodsHotWithData:param CallBack:^(id data) {
            NSArray *array = [LDGoodsListModel mj_objectArrayWithKeyValuesArray:data[@"obj"][@"rows"]];
            completionCallback(array?YES:NO,array?array:@[]);
        } fail:^(NSString *errorString) {
             completionCallback(NO,@[]);
        }];
        
    } noMoreDataCallback:^(NSInteger page) {
    }];
    [self refreshScroll];
}

-(void)getOnlineGoodsLatestWithStoreId:(NSString *)storeId{
    
    [self setScroll:self.aCollectionView firstPageNor:1 pageSize:10 networkCallback:^(NSInteger page, CompletionCallback completionCallback) {
        NSDictionary *param = @{
                                @"storeId":storeId,
                                @"currentPage":@(page),
                                @"pageSize":@"15",
                                };
        [[APIManager sharedManager] onlineGoodsLatestWithData:param CallBack:^(id data) {
            NSArray *array = [LDGoodsListModel mj_objectArrayWithKeyValuesArray:data[@"obj"][@"rows"]];
            completionCallback(array?YES:NO,array?array:@[]);
        } fail:^(NSString *errorString) {
            completionCallback(NO,@[]);
        }];
        
    } noMoreDataCallback:^(NSInteger page) {
    }];
    [self refreshScroll];
}

@end
