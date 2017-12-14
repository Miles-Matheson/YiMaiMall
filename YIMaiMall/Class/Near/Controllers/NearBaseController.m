//
//  BaseNearController.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/18.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "NearBaseController.h"
#import "LDCustomNavView.h"
#import "LDCollectionBannerCell.h"
#import "LDCollectionIndexCell.h"
#import "LDNoticCollectionCell.h"
#import "LDOfflinePageCell.h"
//#import "LDHomeAreaCell.h"
#import "LDNearAreaCell.h"
#import "LDSellerListCell.h"
//#import "LDGoodsLisCell.h"
#import "LDProductCollectionHeadView.h"
#import "IHScanController.h"
#import "LDOnlineSearchController.h"
#import "LDBaseGoodsDetailController.h"

@interface NearBaseController ()<UICollectionViewDelegate,UICollectionViewDataSource,LDCustomNavViewDelegate>

@property (nonatomic,strong)LDCustomNavView *customNavView;

@property (nonatomic,strong)LDHomeModel *mainDataModel;
@property (nonatomic,strong)NSArray *banners;
@end

@implementation NearBaseController

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
    
    [self initCustomModel];
    
    [self initCollectionView];
    [self initNavView];
}

-(void)initCustomModel{
    
    NSMutableArray *bannerArray = [NSMutableArray array];
    
    for (int i = 0; i <4; i++) {
        
        LDBannerModel *model = [[LDBannerModel alloc]init];
        model.img = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1510802793181&di=83c994046a5905acab990c4910a8cbe7&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F12%2F54%2F52%2F52V58PICtGB.jpg";
        [bannerArray addObject:model];
    }
    _banners  = [[NSArray alloc]initWithArray:bannerArray];
    
    
    NSMutableArray *indexArray = [NSMutableArray array];
    
    for (int i = 0; i <4; i++) {
        
        LDClickIndexModel *model = [[LDClickIndexModel alloc]init];
        model.imgUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1510805106905&di=59c89eeb026b62f977fe268fbfadbd7d&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01ef2558269c8ba84a0e282bedd05c.jpg";
        model.name = @"颐脉生活馆";
        [indexArray addObject:model];
    }
    _mainDataModel.ClassList = indexArray;
    
    
    NSMutableArray *noticArray = [NSMutableArray array];
    
    for (int i = 0; i <6; i++) {
        
        LDNoticModel *model = [[LDNoticModel alloc]init];
        model.title = [NSString stringWithFormat:@"%d ====== 2",i];
        [noticArray addObject:model];
    }
    _mainDataModel.noticArray = noticArray;
}

-(void)initNavView{
    _customNavView = [[LDCustomNavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, isIPhpneX?88:64)];
    _customNavView.delegate = self;
    [self.view addSubview:_customNavView];
}

-(void)initCollectionView
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = SIZEFIT(5);
    layout.minimumLineSpacing = 0;
    
    layout.footerReferenceSize = CGSizeMake(self.view.size.width, 5);
    self.aCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0,64, self.view.frame.size.width,self.view.bounds.size.height-64) collectionViewLayout:layout];
    self.aCollectionView.backgroundColor = RGB(245, 245, 245);
    self.aCollectionView.dataSource = self;
    self.aCollectionView.delegate = self;
    [self.view addSubview:self.aCollectionView];
    
    // 注册cell、sectionHeader、sectionFooter
    [self.aCollectionView registerClass:[LDCollectionBannerCell class] forCellWithReuseIdentifier:@"LDCollectionBannerCell"];
    [self.aCollectionView registerClass:[LDCollectionIndexCell  class]  forCellWithReuseIdentifier:@"LDCollectionIndexCell"];
    [self.aCollectionView registerClass:[LDNoticCollectionCell  class]  forCellWithReuseIdentifier:@"LDNoticCollectionCell"];
    [self.aCollectionView registerClass:[LDOfflinePageCell  class]  forCellWithReuseIdentifier:@"LDOfflinePageCell"];
//    [self.aCollectionView registerClass:[LDHomeAreaCell  class]  forCellWithReuseIdentifier:@"LDHomeAreaCell"];
    
    [self.aCollectionView registerNib:[UINib nibWithNibName:@"LDNearAreaCell" bundle:nil] forCellWithReuseIdentifier:@"LDNearAreaCell"];
    
    [self.aCollectionView registerClass:[LDSellerListCell  class]  forCellWithReuseIdentifier:@"LDSellerListCell"];
    [self.aCollectionView registerClass:[LDProductCollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LDProductCollectionHeadView"];
    [self.aCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"LDProductCollectionFootView"];
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    if (section == 4) {
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
            
            NSString *title = indexPath.section == 1?@"人气热店":indexPath.section == 2?@"暖心推荐":indexPath.section == 3?@"人分享":@"";
            [headView.titleBtn setTitle:title forState:0];
            headView.HeaderStyle = HeaderStyleLineTitle;
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
    return 4;
}
//每一区有多少个cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 3;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return 1;
    }else if (section == 3){
        return 5;
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
        return CGSizeMake(self.view.width,SIZEFIT(120));
    }else if (indexPath.section == 2){
         return CGSizeMake(self.view.width,SIZEFIT(240));
    }else if (indexPath.section == 3){
        return CGSizeMake(self.view.width,SIZEFIT(115));
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
            cell.models = _banners;
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
        
        LDOfflinePageCell * pageCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDOfflinePageCell" forIndexPath:indexPath];
        
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < 6; i ++) {
            LDGoodsListModel *model = [[LDGoodsListModel alloc]init];
            model.img = @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=318587829,2264818244&fm=27&gp=0.jpg";
            model.gName = @"是否比萨v多次v";
            [array addObject:model];
        }
        pageCell.models = array;
        pageCell.itemClickCallBack = ^(LDGoodsListModel *model) {
            
        };
        return pageCell;
    }else if (indexPath.section == 2){
        
        LDNearAreaCell *areaCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDNearAreaCell" forIndexPath:indexPath];
        
        return areaCell;
  
    }else if (indexPath.section == 3){

        LDSellerListCell *sellerCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDSellerListCell" forIndexPath:indexPath];
        
        LDSellerListModel *model = [[LDSellerListModel alloc]init];
        model.BusinessPic = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1510810042905&di=c37120b87c9661c8970633684e7e35c1&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F730e0cf3d7ca7bcbb8567716b5096b63f624a8de.jpg";
        model.score = 3.5;
        model.Distance = 2500.7;
        sellerCell.model = model;
        return sellerCell;
    }
    return [UICollectionViewCell new];
}

//cell的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //cell被电击后移动的动画
    [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionTop];
    
    if (indexPath.section == 3) {
        self.navigationController.navigationBarHidden = YES;
        [self.navigationController pushViewController:[[LDBaseGoodsDetailController alloc]initWithGoodsID:@""] animated:YES];
    }
    
}

@end

