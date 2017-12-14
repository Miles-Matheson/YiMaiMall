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
#import "LDBaseDetailController.h"

#import "ChoseView.h"
@interface LDGoodsController ()<UICollectionViewDelegate,UICollectionViewDataSource,TypeSeleteDelegete>
{
    ChoseView *choseView;
    UIView *bgview;
    CGPoint center;
    NSArray *sizearr;//型号数组
    NSArray *colorarr;//分类数组
    NSDictionary *stockarr;//商品库存量
    int goodsStock;
}
@end

@implementation LDGoodsController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initCollectionView];
}
-(void)initCollectionView
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = SIZEFIT(5);
    layout.minimumLineSpacing = 0;
    layout.headerReferenceSize = CGSizeMake(self.view.width, 40);
    layout.footerReferenceSize = CGSizeMake(0, 0);
    
    self.aCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width,self.view.bounds.size.height-64) collectionViewLayout:layout];
    self.aCollectionView.backgroundColor = BlueColor;
    //    self.aCollectionView.backgroundColor = RGB(245, 245, 245);
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
            headView.titleLab.text = [NSString stringWithFormat:@"为您推荐"];
            headView.titleClick = ^{
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
        
        return CGSizeMake(self.view.width/2.-5,SIZEFIT(216));
        
    }else if (indexPath.section == 4){
        return CGSizeMake(SCREEN_WIDTH/2.-10.,SIZEFIT(215));
    }
    return CGSizeMake(SCREEN_WIDTH,SIZEFIT(215));
}


//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return section == 4?5:0;
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            LDDetailBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDDetailBannerCell" forIndexPath:indexPath];
            
            return cell;
        }else if (indexPath.row == 1){
            //
            LDDetailTitleCell *contentCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDDetailTitleCell" forIndexPath:indexPath];
            
            return contentCell;
        }else  if (indexPath.row == 2){
            
            LDDetailPriceCell *priceCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDDetailPriceCell" forIndexPath:indexPath];
            
            return priceCell;
        }else  if (indexPath.row == 3){
            
            LDDetailSkuClickCell *skuChooseCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDDetailSkuClickCell" forIndexPath:indexPath];
            
            return skuChooseCell;
        }else{
            
            LDIdentificationCell *identificationCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDIdentificationCell" forIndexPath:indexPath];
            
            return identificationCell;
        }
    }else if(indexPath.section == 1){
        
        LDCommentShowCell *commentShowCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDCommentShowCell" forIndexPath:indexPath];
        
        return commentShowCell;
        
    }else if (indexPath.section == 2){
        
        LDDetailShopInfoCell *shopInfoCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDDetailShopInfoCell" forIndexPath:indexPath];
    
        return shopInfoCell;
    }else{
        
        LDGoodsLisCell *goodsListCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDGoodsLisCell" forIndexPath:indexPath];
        LDGoodsListModel *model = [[LDGoodsListModel alloc]init];
        model.MainPic = @"http://116.62.133.218:888/file/Pic/2017-10/63643396926687808630XI6CUUEN.jpg";
        model.Name = @"北菜园 有机茴香 250g 新鲜蔬菜";
        model.SalePrice = 56.0;
        model.Sales = 39.9;
        goodsListCell.model = model;
        
        return goodsListCell;
    }
}

//cell的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //cell被电击后移动的动画
    [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionTop];

    if (indexPath.section == 0) {
        if (indexPath.row == 3) {
            [self initTypeView];
        }
    }
    if (indexPath.section == 4) {
        [self.navigationController pushViewController:[LDBaseDetailController new] animated:YES];
    }
}

-(void)initTypeView{
    /**
     这些数据应该从服务器获得 没有服务器我就只能先写死这些数据了
     */
    sizearr = [[NSArray alloc] initWithObjects:@"S",@"M",@"L",nil];
    colorarr = [[NSArray alloc] initWithObjects:@"蓝色",@"红色",@"湖蓝色",nil];
    NSString *str = [[NSBundle mainBundle] pathForResource: @"stock" ofType:@"plist"];
    stockarr = [[NSDictionary alloc] initWithContentsOfURL:[NSURL fileURLWithPath:str]];
    
    [self initview];
}
#pragma mark-method
-(void)initview{

    [self initChoseView];
    [self btnselete];
}

/**
 *  初始化弹出视图
 */
-(void)initChoseView{
    
    //选择尺码颜色的视图
    choseView = [[ChoseView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:choseView];
    
    //尺码
    choseView.sizeView = [[TypeView alloc] initWithFrame:CGRectMake(0, 0, choseView.frame.size.width, 50) andDatasource:sizearr :@"尺码"];
    choseView.sizeView.delegate = self;
    [choseView.mainscrollview addSubview:choseView.sizeView];
    choseView.sizeView.frame = CGRectMake(0, 0, choseView.frame.size.width, choseView.sizeView.height);
    //颜色分类
    choseView.colorView = [[TypeView alloc] initWithFrame:CGRectMake(0, choseView.sizeView.frame.size.height, choseView.frame.size.width, 50) andDatasource:colorarr :@"颜色分类"];
    choseView.colorView.delegate = self;
    [choseView.mainscrollview addSubview:choseView.colorView];
    choseView.colorView.frame = CGRectMake(0, choseView.sizeView.frame.size.height, choseView.frame.size.width, choseView.colorView.height);
    //购买数量
    choseView.countView.frame = CGRectMake(0, choseView.colorView.frame.size.height+choseView.colorView.frame.origin.y, choseView.frame.size.width, 50);
    choseView.mainscrollview.contentSize = CGSizeMake(self.view.frame.size.width, choseView.countView.frame.size.height+choseView.countView.frame.origin.y);
    
    choseView.lb_price.text = @"¥100";
    choseView.lb_stock.text = @"库存100000件";
    choseView.lb_detail.text = @"请选择 尺码 颜色分类";
    [choseView.bt_cancle addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [choseView.bt_sure addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    //点击黑色透明视图choseView会消失
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [choseView.alphaiView addGestureRecognizer:tap];
    //点击图片放大图片
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigImage:)];
    choseView.img.userInteractionEnabled = YES;
    [choseView.img addGestureRecognizer:tap1];
}
/**
 *  此处嵌入浏览图片代码
 */
-(void)showBigImage:(UITapGestureRecognizer *)tap
{
    NSLog(@"放大图片");
}
/**
 *  点击按钮弹出
 */
-(void)btnselete{
    
    [UIView animateWithDuration: 0.35 animations: ^{
        bgview.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
        bgview.center = CGPointMake(self.view.center.x, self.view.center.y-50);
        choseView.center = self.view.center;
        choseView.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    } completion: nil];
}
/**
 *  点击半透明部分或者取消按钮，弹出视图消失
 */
-(void)dismiss
{
    center.y = center.y+self.view.frame.size.height;
    [UIView animateWithDuration: 0.35 animations: ^{
        choseView.frame =CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        
        bgview.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
        bgview.center = self.view.center;
    } completion: nil];
    
}
#pragma mark-typedelegete
-(void)btnindex:(int)tag
{
    //通过seletIndex是否>=0来判断尺码和颜色是否被选择，－1则是未选择状态
    if (choseView.sizeView.seletIndex >=0&&choseView.colorView.seletIndex >=0) {
        //尺码和颜色都选择的时候
        NSString *size =[sizearr objectAtIndex:choseView.sizeView.seletIndex];
        NSString *color =[colorarr objectAtIndex:choseView.colorView.seletIndex];
        choseView.lb_stock.text = [NSString stringWithFormat:@"库存%@件",[[stockarr objectForKey: size] objectForKey:color]];
        choseView.lb_detail.text = [NSString stringWithFormat:@"已选 \"%@\" \"%@\"",size,color];
        choseView.stock =[[[stockarr objectForKey: size] objectForKey:color] intValue];
        
        [self reloadTypeBtn:[stockarr objectForKey:size] :colorarr :choseView.colorView];
        [self reloadTypeBtn:[stockarr objectForKey:color] :sizearr :choseView.sizeView];
        NSLog(@"%d",choseView.colorView.seletIndex);
        choseView.img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",choseView.colorView.seletIndex+1]];
    }else if (choseView.sizeView.seletIndex ==-1&&choseView.colorView.seletIndex == -1){
        //尺码和颜色都没选的时候
        choseView.lb_price.text = @"¥100";
        choseView.lb_stock.text = @"库存100000件";
        choseView.lb_detail.text = @"请选择 尺码 颜色分类";
        choseView.stock = 100000;
        //全部恢复可点击状态
        [self resumeBtn:colorarr :choseView.colorView];
        [self resumeBtn:sizearr :choseView.sizeView];
        
    }else if (choseView.sizeView.seletIndex ==-1&&choseView.colorView.seletIndex >= 0){
        //只选了颜色
        NSString *color =[colorarr objectAtIndex:choseView.colorView.seletIndex];
        //根据所选颜色 取出该颜色对应所有尺码的库存字典
        NSDictionary *dic = [stockarr objectForKey:color];
        [self reloadTypeBtn:dic :sizearr :choseView.sizeView];
        [self resumeBtn:colorarr :choseView.colorView];
        choseView.lb_stock.text = @"库存100000件";
        choseView.lb_detail.text = @"请选择 尺码";
        choseView.stock = 100000;
        
        choseView.img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",choseView.colorView.seletIndex+1]];
    }else if (choseView.sizeView.seletIndex >= 0&&choseView.colorView.seletIndex == -1){
        //只选了尺码
        NSString *size =[sizearr objectAtIndex:choseView.sizeView.seletIndex];
        //根据所选尺码 取出该尺码对应所有颜色的库存字典
        NSDictionary *dic = [stockarr objectForKey:size];
        [self resumeBtn:sizearr :choseView.sizeView];
        [self reloadTypeBtn:dic :colorarr :choseView.colorView];
        choseView.lb_stock.text = @"库存100000件";
        choseView.lb_detail.text = @"请选择 颜色分类";
        choseView.stock = 100000;
        
        //        for (int i = 0; i<colorarr.count; i++) {
        //            int count = [[dic objectForKey:[colorarr objectAtIndex:i]] intValue];
        //            //遍历颜色字典 库存为零则改尺码按钮不能点击
        //            if (count == 0) {
        //                UIButton *btn =(UIButton *) [choseView.colorView viewWithTag:100+i];
        //                btn.enabled = NO;
        //            }
        //        }
    }
}
//恢复按钮的原始状态
-(void)resumeBtn:(NSArray *)arr :(TypeView *)view
{
    for (int i = 0; i< arr.count; i++) {
        UIButton *btn =(UIButton *) [view viewWithTag:100+i];
        btn.enabled = YES;
        btn.selected = NO;
        [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        if (view.seletIndex == i) {
            btn.selected = YES;
            [btn setBackgroundColor:kAppThemeColor];
        }
    }
}
//根据所选的尺码或者颜色对应库存量 确定哪些按钮不可选
-(void)reloadTypeBtn:(NSDictionary *)dic :(NSArray *)arr :(TypeView *)view
{
    for (int i = 0; i<arr.count; i++) {
        int count = [[dic objectForKey:[arr objectAtIndex:i]] intValue];
        UIButton *btn =(UIButton *)[view viewWithTag:100+i];
        btn.selected = NO;
        [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
        //库存为零 不可点击
        if (count == 0) {
            btn.enabled = NO;
            [btn setTitleColor:[UIColor lightGrayColor] forState:0];
        }else
        {
            btn.enabled = YES;
            [btn setTitleColor:[UIColor blackColor] forState:0];
        }
        //根据seletIndex 确定用户当前点了那个按钮
        if (view.seletIndex == i) {
            btn.selected = YES;
            [btn setBackgroundColor:kAppThemeColor];
        }
    }
}

@end
