//
//  LDBaseShopDetailController.h
//  YIMaiMall
//
//  Created by Miles on 2017/11/24.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDBaseViewController.h"

@interface LDBaseShopDetailController : LDBaseViewController

@property (nonatomic, strong)UICollectionView *baseCollectionView;

@property (nonatomic, copy) NSString *storeId;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, assign) BOOL vcCanScroll;
@property (nonatomic, assign) BOOL isRefresh;
@end
