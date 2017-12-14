//
//  SpecWindowView.h
//  HuanHuan
//
//  Created by HFL on 2016/12/8.
//  Copyright © 2016年 HFL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDGoodsSkuModel.h"
@interface SpecWindowView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIView *bgAlphaView;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *goodsDesLB;


@property (nonatomic ,copy)void(^CallBackWithCloseWindow)(NSString * type,NSString * skuIds,NSString *goodsID,NSInteger count,NSString *spec_info);//!<回调关闭弹窗的block(type:0取消，1确定，2立即购买)
@property (nonatomic ,strong)NSMutableArray <LDGoodsSkuSiftKeyModel *>* dataSource;//!<数据源
@property (nonatomic ,copy)void(^CallBackWithSiftSelected)(NSDictionary * dic);//!<回调规格选择的block
@property (nonatomic ,strong)NSMutableArray * skuResult;//!<可匹配规格
@property (nonatomic ,strong)NSMutableArray * seletedIndexPaths;//!<已经选中的规格数组
@property (nonatomic ,strong)NSMutableArray * seletedIdArray;//!<记录已选id
@property (nonatomic ,strong)NSMutableArray * seletedEnable;//!<不可选indexPath
@property (nonatomic ,strong)NSMutableArray * noSelectedHead;//!<未选中的标题
@property (nonatomic ,strong)NSString * skuIds;//!<商品属性id拼接
@property (nonatomic ,strong)NSString * goodsID;//!<商品id
@property (nonatomic ,assign)NSInteger  goodsCount;//!<商品数量
@property (nonatomic ,copy)NSString * spec_info;//!<商品属性尺码拼接

@property (nonatomic ,copy)NSString * goodsprice;//!<商品价格
@property (nonatomic ,strong)NSMutableArray * alertInfo;//!<提示信息
@property (nonatomic ,strong)NSString * currentTitle;//!<当前提示信息

@property (nonatomic ,strong)NSMutableArray * SKUResult;

@property (nonatomic ,assign)NSInteger selectGoodsCount;//已经选择商品的count



@property (nonatomic ,strong)NSDictionary * SKUdataSource;//SKU数据源

@end
