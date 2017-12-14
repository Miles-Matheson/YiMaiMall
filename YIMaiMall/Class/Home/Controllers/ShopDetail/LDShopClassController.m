//
//  LDShopClassController.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/30.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDShopClassController.h"
#import "LDProductCollectionHeadView.h"
#import "LDBaseGoodsDetailController.h"

#import "LDShopClassListCell.h"
#import "LDOnLineGoodsClassModel.h"

@interface LDShopClassController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)NSArray *dataArray;
@end

@implementation LDShopClassController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCollectionView];
    [self getAllGoodsClassList];
}

-(void)initCollectionView{
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = SIZEFIT(5);
    layout.minimumLineSpacing = 5;
    
    layout.footerReferenceSize = CGSizeMake(self.view.size.width, 5);
    self.aCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width,self.view.bounds.size.height) collectionViewLayout:layout];
    self.aCollectionView.backgroundColor = WhiteColor;
    self.aCollectionView.dataSource = self;
    self.aCollectionView.delegate = self;
    [self.view addSubview:self.aCollectionView];
    
    // 注册cell、sectionHeader、sectionFooter
    //LDShopClassListCell
    
    [self.aCollectionView registerClass:[LDShopClassListCell class] forCellWithReuseIdentifier:@"LDShopClassListCell"];
    
    [self.aCollectionView registerClass:[LDProductCollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LDProductCollectionHeadView"];
    [self.aCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"LDProductCollectionFootView"];
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 5, 0, 5);//分别为上、左、下、右
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

    return CGSizeMake(self.view.size.width, 40);
}

//创建头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            LDProductCollectionHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LDProductCollectionHeadView" forIndexPath:indexPath];
            LDOnLineGoodsClassModel *model = _dataArray[indexPath.section];
            [headView.titleBtn setTitle:model.className forState:0];
            headView.HeaderStyle = HeaderStyleTitleOnly;

            return headView;
        }else{
            UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"LDProductCollectionFootView" forIndexPath:indexPath];
            return footerView;
        }
}

//一共有多少个区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArray.count;
}
//每一区有多少个cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    LDOnLineGoodsClassModel *model = _dataArray[section];
    return model.lowerLevel.count;
}
//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake((SCREEN_WIDTH-15)/2,SIZEFIT(45));
}

//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
   return 5;
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LDShopClassListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDShopClassListCell" forIndexPath:indexPath];

    LDOnLineGoodsClassModel *model = _dataArray[indexPath.section];
    LDOnLineGoodsClassSonModel *sonModel = model.lowerLevel[indexPath.row];
    cell.titleLB.text = sonModel.className;
    return cell;
}

//cell的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //cell被电击后移动的动画
    
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:[[LDBaseGoodsDetailController alloc]initWithGoodsID:@""] animated:YES];
}

-(void)getAllGoodsClassList{
    
    ws(bself);
    [[APIManager sharedManager] onlineGoodsCatClassListWithData:@{@"storeId":_storeId?_storeId:@""} CallBack:^(id data) {
        RC001;
       NSArray *array =  [LDOnLineGoodsClassModel mj_objectArrayWithKeyValuesArray:data[@"obj"]];
        bself.dataArray   = [[NSArray alloc]initWithArray:array];
        [bself.aCollectionView reloadData];
        
    } fail:^(NSString *errorString) {
        
    }];
}

@end
