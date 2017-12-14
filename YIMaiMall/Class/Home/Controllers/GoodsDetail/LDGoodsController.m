//
//  LDBaseGoodsController.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/16.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDGoodsController.h"
#import "LDProductCollectionHeadView.h"
#import "LDDetailBannerCell.h"
#import "LDDetailTitleCell.h"
#import "LDDetailPriceCell.h"
#import "LDDetailSkuClickCell.h"
#import "LDIdentificationCell.h"
#import "LDCommentShowCell.h"
#import "LDDetailShopInfoCell.h"
#import "LDGoodsLisCell.h"
#import "LDBaseGoodsDetailController.h"
#import "LDBaseShopDetailController.h"
#import "FSBaseViewController.h"
#import "LDGoodsDetailModel.h"
#import "LDGoodsSkuModel.h"
#import "XWInteractiveTransition.h"
#import "UIViewController+XWTransition.h"
#import "XWDrawerAnimator.h"
#import "LDFeatureSkuController.h"
#import "LDDetailBottomView.h"

#import "LDStatementController.h"
#import "ShopCartBaseController.h"


@interface LDGoodsController ()<UICollectionViewDelegate,UICollectionViewDataSource,LDDetailBottomViewDelegate>
{
    UIView *bgview;
    CGPoint center;
    int goodsStock;
    
}
@property (nonatomic,strong)LDGoodsDetailModel *mainDataModel;
@property (nonatomic,strong)LDGoodsSkuModel *skuModel;
@property (nonatomic,strong)NSDictionary *skuDic;
@property(nonatomic,strong)LDDetailBottomView *bottomBaseView;
@end

@implementation LDGoodsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mainDataModel = [[LDGoodsDetailModel alloc]init];
    _skuModel      = [[LDGoodsSkuModel alloc]init];
    
    [self initCollectionView];
    
    [self requestMainDataWithGoodsID:_goodsID];
    
    [self createBottomView];
}

//底部视图
-(void)createBottomView{
    
    _bottomBaseView = [[LDDetailBottomView alloc] initWithFrame:CGRectMake(0,self.aCollectionView.height, SCREEN_WIDTH, 50)];
    _bottomBaseView.backgroundColor = RGB(246, 246, 246);
    _bottomBaseView.delegate = self;
    [self.view addSubview:_bottomBaseView];
}

/********************************************************************************************************/
/*
 button.tag
 0  客服
 1  店铺
 2  购物车
 3  加入购物车
 4 立即购买
 */
- (void)LDDetailBottomView:(LDDetailBottomView*)bottomView ClickItem:(ToolBtn *)button
{
    if (button.tag == 0) {
        
    }else if (button.tag == 1){
        
        FSBaseViewController *storeVC = [[FSBaseViewController alloc]init];
        storeVC.storeId = _mainDataModel.goodsStoreId;
        [self.navigationController pushViewController:storeVC animated:YES];
        
    }else if (button.tag == 2){
        
        ShopCartBaseController *shopCartVC = [[ShopCartBaseController alloc]init];
        [self.navigationController pushViewController:shopCartVC animated:YES];
        
    }else if (button.tag == 3){
        [self showSkuViewIsBuyNow:NO];
    }else{
        [self showSkuViewIsBuyNow:YES];
    }
}


-(void)initCollectionView{
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = SIZEFIT(5);
    layout.minimumLineSpacing = 0;
    layout.headerReferenceSize = CGSizeMake(self.view.width, 40);
    layout.footerReferenceSize = CGSizeMake(0, 0);
    
    self.aCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width,self.view.bounds.size.height-64-50) collectionViewLayout:layout];
//    self.aCollectionView.backgroundColor = BlueColor;
    self.aCollectionView.backgroundColor = RGB(245, 245, 245);
    self.aCollectionView.dataSource = self;
    self.aCollectionView.delegate = self;
    [self.view addSubview:self.aCollectionView];
    
    // 注册cell、sectionHeader、sectionFooter
    [self.aCollectionView registerClass:[LDDetailBannerCell class] forCellWithReuseIdentifier:@"LDDetailBannerCell"];
    [self.aCollectionView registerClass:[LDDetailTitleCell  class]  forCellWithReuseIdentifier:@"LDDetailTitleCell"];
    [self.aCollectionView registerClass:[LDDetailPriceCell  class]  forCellWithReuseIdentifier:@"LDDetailPriceCell"];
    [self.aCollectionView registerClass:[LDDetailSkuClickCell  class]  forCellWithReuseIdentifier:@"LDDetailSkuClickCell"];
    [self.aCollectionView registerClass:[LDIdentificationCell  class]  forCellWithReuseIdentifier:@"LDIdentificationCell"];
    [self.aCollectionView registerClass:[LDCommentShowCell  class]  forCellWithReuseIdentifier:@"LDCommentShowCell"];
    [self.aCollectionView registerClass:[LDDetailShopInfoCell  class]  forCellWithReuseIdentifier:@"LDDetailShopInfoCell"];
    [self.aCollectionView registerClass:[LDGoodsLisCell class] forCellWithReuseIdentifier:@"LDGoodsLisCell"];
    
    [self.aCollectionView registerClass:[LDProductCollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LDProductCollectionHeadView"];
    [self.aCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LDProductCollectionFootView"];
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    if (section == 4) {
        return UIEdgeInsetsMake(0, 5, 0, 5);//分别为上、左、下、右
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}

//创建头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
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
}

//一共有多少个区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 5;
}
//每一区有多少个cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 5;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return 1;
    }else if (section == 3){
        return 0;
    }else if (section == 4){
        return self.contentArr.count;
    }
    return 0;
}

//定义每一个区头的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(0,0);
    }else if(section == 1){
        return CGSizeMake(self.view.width, 9);
    }else if(section == 3){
        return CGSizeMake(self.view.width, 40);
    }else if(section == 4){
        return CGSizeMake(self.view.width, 9);
    }else{
        return CGSizeMake(self.view.width, 0);
    }
}
//定义每一个区尾的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(0,0);
    }else if(section == 1){
        return CGSizeMake(self.view.width, 9);
    }else if(section == 2){
        return CGSizeMake(self.view.width, 9);
    }else if(section == 3){
        return CGSizeMake(self.view.width, 0);
    }else{
        return CGSizeMake(self.view.width, 0);
    }
}

//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return CGSizeMake(self.view.width,SIZEFIT(350));
        }else if (indexPath.row == 1){
            return CGSizeMake(self.view.width,85);
        }else if (indexPath.row == 2){
            return CGSizeMake(self.view.width,70);
        }else  if (indexPath.row == 3){
            return CGSizeMake(self.view.width,50);
        }else{
            return CGSizeMake(self.view.width,50);
        }
    }else if (indexPath.section == 1){
        return CGSizeMake(self.view.width,50);
    }else if (indexPath.section == 2){
        
        return CGSizeMake(self.view.width,SIZEFIT(180));
        
    }else if (indexPath.section == 3){

         return CGSizeMake(0,0);
    }else if (indexPath.section == 4){
        
        CGFloat width = (SCREEN_WIDTH-15)/2.;
        return CGSizeMake(width,width*1.522);
    }
    return CGSizeMake(SCREEN_WIDTH,SIZEFIT(215));
}


//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return section == 4?5:0;
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ws(bself);
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            LDDetailBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDDetailBannerCell" forIndexPath:indexPath];
            cell.foucsClick = ^(LDGoodsDetailModel *model) {
                [bself foucsWithGoodsID:model.ID];
            };
            cell.model = _mainDataModel;
            return cell;
        }else if (indexPath.row == 1){
            LDDetailTitleCell *contentCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDDetailTitleCell" forIndexPath:indexPath];
            contentCell.model = _mainDataModel;
            return contentCell;
        }else  if (indexPath.row == 2){
            
            LDDetailPriceCell *priceCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDDetailPriceCell" forIndexPath:indexPath];
            
            priceCell.model = _mainDataModel;
            return priceCell;
        }else  if (indexPath.row == 3){
            
            LDDetailSkuClickCell *skuChooseCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDDetailSkuClickCell" forIndexPath:indexPath];
        
            if (skuChooseCell.titleLB.text.length == 0) {
                NSString *   spe_info = [self getDefultSpec_info];
                if (spe_info.length>0) {
                    skuChooseCell.titleLB.text = [NSString stringWithFormat:@"请选择:%@",spe_info];
                }
            }
            
            return skuChooseCell;
        }else{
            LDIdentificationCell *identificationCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDIdentificationCell" forIndexPath:indexPath];
            return identificationCell;
        }
    }else if(indexPath.section == 1){
        
        LDCommentShowCell *commentShowCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDCommentShowCell" forIndexPath:indexPath];
        commentShowCell.model = _mainDataModel;
        return commentShowCell;
        
    }else if (indexPath.section == 2){
        
        LDDetailShopInfoCell *shopInfoCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDDetailShopInfoCell" forIndexPath:indexPath];
        shopInfoCell.model = _mainDataModel;
        shopInfoCell.shopInfoClick = ^(NSInteger selectIndex) {
            if (selectIndex) {
                
                FSBaseViewController *storeVC = [[FSBaseViewController alloc]init];
                storeVC.storeId = _mainDataModel.goodsStoreId;
                [bself.navigationController pushViewController:storeVC animated:YES];
            }
        };
        return shopInfoCell;
    }else{
        
        LDGoodsLisCell *goodsListCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDGoodsLisCell" forIndexPath:indexPath];
        goodsListCell.model = self.contentArr[indexPath.row];
        return goodsListCell;
    }
}

//cell的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 3) {
           
            [self showSkuViewIsBuyNow:NO];
        }
    }
    if (indexPath.section == 4) {
        [self.navigationController pushViewController:[[LDBaseGoodsDetailController alloc]initWithGoodsID:@""] animated:YES];
    }
}


-(void)showSkuViewIsBuyNow:(BOOL)isBuyNow{
    WS(bself);
    [self getSkuInfoCallBack:^(NSDictionary *skuData) {
        [bself initChoseViewWithData:skuData isBuyNow:isBuyNow];
    }];
}

#pragma mark - 转场动画弹出控制器
- (void)setUpAlterViewControllerWith:(UIViewController *)vc WithDistance:(CGFloat)distance WithDirection:(XWDrawerAnimatorDirection)vcDirection WithParallaxEnable:(BOOL)parallaxEnable WithFlipEnable:(BOOL)flipEnable{
    
    ws(bself);
    
    [self dismissViewControllerAnimated:YES completion:nil]; //以防有控制未退出
    XWDrawerAnimatorDirection direction = vcDirection;
    XWDrawerAnimator *animator = [XWDrawerAnimator xw_animatorWithDirection:direction moveDistance:distance];
    animator.parallaxEnable = parallaxEnable;
    animator.flipEnable = flipEnable;
    [self xw_presentViewController:vc withAnimator:animator];
    
    [animator xw_enableEdgeGestureAndBackTapWithConfig:^{
        [bself selfAlterViewback];
    }];
}
#pragma 退出界面
- (void)selfAlterViewback{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  初始化弹出视图
 */
-(void)initChoseViewWithData:(NSDictionary *)dataDic isBuyNow:(BOOL)isbuyNow{
    ws(bself);
    LDFeatureSkuController *skuVC = [[LDFeatureSkuController alloc]initWithSkuData:dataDic isBuyNow:isbuyNow];
    skuVC.selectSkuCallBack = ^(NSString *skuInfo) {
        
        if (isbuyNow) {
            
            LDStatementController *statementVC = [[LDStatementController alloc]init];
//            statementVC.modelList =
            
            [bself.navigationController pushViewController:statementVC animated:YES];
            
        }else{
            [bself.view showCenterToast:@"加入购物车成功!"];
        }
        
        LDDetailSkuClickCell *cell = (LDDetailSkuClickCell*)[bself.aCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
        cell.titleLB.text = [NSString stringWithFormat:@"已选择: %@",skuInfo?skuInfo:@""];
 
    };
    [self setUpAlterViewControllerWith:skuVC WithDistance:SCREEN_HEIGHT * 0.8 WithDirection:XWDrawerAnimatorDirectionBottom WithParallaxEnable:YES WithFlipEnable:YES];
}

-(void)requestMainDataWithGoodsID:(NSString *)goodsID{
    
    ws(bself);
    
    [self setScroll:self.aCollectionView firstPageNor:1 pageSize:10 networkCallback:^(NSInteger page, CompletionCallback completionCallback) {
        
        if (self.aCollectionView.contentOffset.y<=0) {
            [bself getGoodsBaseInfo];
        }
        [bself getOnlineGoodsReferralsWithGoodsID:bself.goodsID CallBack:^(BOOL isSuccess, NSArray *array) {
            completionCallback(isSuccess,array);  
        }];
        
    } noMoreDataCallback:^(NSInteger page) {
        
    }];
    [self silenceRefresh];
}

-(void)getGoodsBaseInfo{
    
    ws(bself);
    [[APIManager sharedManager] getGoodsBaseInfoWithGoodsID:_goodsID CallBack:^(id data) {
        bself.mainDataModel =  [LDGoodsDetailModel mj_objectWithKeyValues:data[@"obj"]];
        [bself.aCollectionView reloadData];
    } fail:^(NSString *errorString) {
        
    }];
}

-(void)getOnlineGoodsReferralsWithGoodsID:(NSString *)goodsID CallBack:(void(^)(BOOL isSuccess,NSArray*array))callBack{
    
    [[APIManager sharedManager] getGoodsReferralsWithGoodsID:goodsID CallBack:^(id data) {
        
        NSArray *array = [LDGoodsListModel mj_objectArrayWithKeyValuesArray:data[@"obj"]];
        if (array) {
            callBack(YES,array);
        }else{
            callBack(NO,@[]);
        }
    } fail:^(NSString *errorString) {
        callBack(NO,@[]);
    }];
}

-(void)foucsWithGoodsID:(NSString *)goodsID{
    ws(bself);
    [[APIManager sharedManager] foucsOrCancelGoodsWithGoodsID:goodsID isFoucs:!_mainDataModel.isCollect CallBack:^(id data) {
        RC001;
        BOOL isFoucs = [data[@"obj"] boolValue];
        
        bself.mainDataModel.isCollect = isFoucs;
        [bself.aCollectionView reloadData];
        [bself.view showCenterToast:isFoucs?@"关注商品成功!":@"取消关注成功!"];
        
    } fail:^(NSString *errorString) {
    }];
}

-(void)getSkuInfoCallBack:(void(^)(NSDictionary *skuData))callBack{

    ws(bself);
    if ( self.skuDic) {
        callBack(self.skuDic);
    }else{
       
        [[APIManager sharedManager] getGoodsSKUInfoWithGoodsID:_goodsID?_goodsID:@"" CallBack:^(id data) {
            bself.skuDic = (NSDictionary *)data;
            bself.skuModel = [LDGoodsSkuModel mj_objectWithKeyValues:data[@"obj"]];
            callBack(bself.skuDic);
            
        } fail:^(NSString *errorString) {
            
        }];
    }
}

-(NSString *)getDefultSpec_info{

    NSMutableArray *array = [NSMutableArray array];
    
    for (LDGoodsSkuSiftKeyModel *skuSiftKeyModel in _skuModel.siftKey) {
        
        if (skuSiftKeyModel.standardListName) {
             [array addObject:skuSiftKeyModel.standardListName];
        }
    }
    NSString *spec_info = [array componentsJoinedByString:@","];//--分隔符
    return spec_info?spec_info:@"";
}

@end
