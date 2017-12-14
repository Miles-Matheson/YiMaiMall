//
//  LDShopHomeController.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/25.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDShopHomeController.h"
#import "LDGoodsLisCell.h"
#import "LDProductCollectionHeadView.h"
@interface LDShopHomeController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation LDShopHomeController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initCollectionView];
}

-(void)initCollectionView{
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = SIZEFIT(5);
    layout.minimumLineSpacing = 0;
    layout.headerReferenceSize = CGSizeMake(self.view.width, 40);
    layout.footerReferenceSize = CGSizeMake(0, 0);
    
    self.aCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0,44, self.view.frame.size.width,self.view.bounds.size.height-64) collectionViewLayout:layout];
    self.aCollectionView.backgroundColor = BlueColor;
    //    self.aCollectionView.backgroundColor = RGB(245, 245, 245);
    self.aCollectionView.dataSource = self;
    self.aCollectionView.delegate = self;
    [self.view addSubview:self.aCollectionView];
    
    // 注册cell、sectionHeader、sectionFooter
//    [self.aCollectionView registerClass:[LDDetailBannerCell class] forCellWithReuseIdentifier:@"LDDetailBannerCell"];
//    [self.aCollectionView registerClass:[LDDetailTitleCell  class]  forCellWithReuseIdentifier:@"LDDetailTitleCell"];
//    [self.aCollectionView registerClass:[LDDetailPriceCell  class]  forCellWithReuseIdentifier:@"LDDetailPriceCell"];
//    [self.aCollectionView registerClass:[LDDetailSkuClickCell  class]  forCellWithReuseIdentifier:@"LDDetailSkuClickCell"];
//    [self.aCollectionView registerClass:[LDIdentificationCell  class]  forCellWithReuseIdentifier:@"LDIdentificationCell"];
//    [self.aCollectionView registerClass:[LDCommentShowCell  class]  forCellWithReuseIdentifier:@"LDCommentShowCell"];
//    [self.aCollectionView registerClass:[LDDetailShopInfoCell  class]  forCellWithReuseIdentifier:@"LDDetailShopInfoCell"];
    [self.aCollectionView registerClass:[LDGoodsLisCell class] forCellWithReuseIdentifier:@"LDGoodsLisCell"];
//
//    [self.aCollectionView registerClass:[LDProductCollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LDProductCollectionHeadView"];
    [self.aCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LDProductCollectionFootView"];
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
        return 30;
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
    
//    if (indexPath.section == 0) {
//        if (indexPath.row == 0) {
//            return CGSizeMake(self.view.width,SIZEFIT(350));
//        }else if (indexPath.row == 1){
//            return CGSizeMake(self.view.width,85);
//        }else if (indexPath.row == 2){
//            return CGSizeMake(self.view.width,70);
//        }else  if (indexPath.row == 3){
//            return CGSizeMake(self.view.width,50);
//        }else{
//            return CGSizeMake(self.view.width,50);
//        }
//    }else if (indexPath.section == 1){
//        return CGSizeMake(self.view.width,50);
//    }else if (indexPath.section == 2){
//
//        return CGSizeMake(self.view.width,SIZEFIT(180));
//
//    }else if (indexPath.section == 3){
//
//        return CGSizeMake(self.view.width/2.-5,SIZEFIT(216));
//
//    }else if (indexPath.section == 4){
//        return CGSizeMake(SCREEN_WIDTH/2.-10.,SIZEFIT(215));
//    }
    return CGSizeMake(SCREEN_WIDTH,SIZEFIT(215));
}


//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return section == 4?5:0;
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ws(bself);

        
        LDGoodsLisCell *goodsListCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDGoodsLisCell" forIndexPath:indexPath];
        LDGoodsListModel *model = [[LDGoodsListModel alloc]init];
        model.MainPic = @"http://116.62.133.218:888/file/Pic/2017-10/63643396926687808630XI6CUUEN.jpg";
        model.Name = @"北菜园 有机茴香 250g 新鲜蔬菜";
        model.SalePrice = 56.0;
        model.Sales = 39.9;
        goodsListCell.model = model;
        
        return goodsListCell;
 
}

//cell的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //cell被电击后移动的动画
    [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionTop];
    
 
}

@end

