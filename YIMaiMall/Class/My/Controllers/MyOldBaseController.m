//
//  MyBaseController.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/15.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "MyOldBaseController.h"
#import "LDAddressListController.h"
#import "MyFloorIndexCell.h"
#import "LDMineHeadView.h"
#import "LDOrderObLineBaseController.h"
#import "LDProductCollectionHeadView.h"
#import "LDFloorIndexModel.h"
#import "LLUMengManager.h"
@interface MyOldBaseController ()<UICollectionViewDelegate,UICollectionViewDataSource>{

    UIView *customNavView;
    NSArray *titleArray;
    NSMutableArray *indexArray;
}

@property (nonatomic,strong)LDMineHeadView *headView;

@end

@implementation MyOldBaseController

-(LDMineHeadView *)headView{
    if (!_headView) {
        _headView  = [[LDMineHeadView alloc]initWithFrame:CGRectMake(0,-SIZEFIT(163), SCREEN_WIDTH, SIZEFIT(163))];
    }
    return _headView;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navBackgroundImageView.alpha = 0;

    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setBarTintColor:WhiteColor];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navBackgroundImageView.alpha = 1;
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor blackColor]}];
    [self.navigationController.navigationBar setBarTintColor:WhiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"个人中心";
    [self setRightText:nil textColor:nil ImgPath:@""];
    
    [self initUIData];

    [self initTableView];
    [self createNavView];
}
-(void)clickRightBtn:(UIButton *)rightBtn{
    
}

-(void)initUIData{
    titleArray = @[@"我的订单",@"账户管理",@"推广中心",@"我的权益",@"必备工具",@"文章",];
    indexArray = [NSMutableArray array];
    
    for (int i = 0; i < titleArray.count; i ++) {
        NSMutableArray *array = [NSMutableArray array];
        if (i == 0) {
            for (int a = 0; a < 4; a++) {
                LDFloorIndexModel *model = [[LDFloorIndexModel alloc]init];
                model.iconName = @"pay_3";
                model.name = a==0?@"兑换专区":a==1?@"线下消费":a==2?@"线上消费":@"我的评价";
                [array addObject:model];
            }
        }else if (i == 1){
            for (int a = 0; a < 3; a++) {
                LDFloorIndexModel *model = [[LDFloorIndexModel alloc]init];
                model.iconName = @"pay_3";
                model.name = a==0?@"充值中心":a==1?@"我的钱包":@"萧客账号";
                [array addObject:model];
            }
        }else if (i == 2){
            for (int a = 0; a < 4; a++) {
                LDFloorIndexModel *model = [[LDFloorIndexModel alloc]init];
                model.iconName = @"pay_3";
                model.name = a==0?@"业绩统计":a==1?@"收益中心":a==2?@"资金记录":@"我的分享";
                [array addObject:model];
            }
        }else if(i == 3){
            for (int a = 0; a < 2; a++) {
                LDFloorIndexModel *model = [[LDFloorIndexModel alloc]init];
                model.iconName = @"pay_3";
                model.name = a==0?@"商户管理中心":@"我要升级";
                [array addObject:model];
            }
        }else if (i == 4){
            for (int a = 0; a < 4; a++) {
                LDFloorIndexModel *model = [[LDFloorIndexModel alloc]init];
                model.iconName = @"pay_3";
                model.name = a==0?@"我要咨询":a==1?@"公众账号":a==2?@"帮助中心":@"自助申请";
                [array addObject:model];
            }
        }else if (i ==5){
            for (int a = 0; a < 3; a++) {
                LDFloorIndexModel *model = [[LDFloorIndexModel alloc]init];
                model.iconName = @"pay_3";
                model.name = a==0?@"分类":a==1?@"分享":@"收藏";
                [array addObject:model];
            }
        }
        if (array) {
            [indexArray addObject:array];
        }
    }
}
- (void)createNavView
{
    customNavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, isIPhpneX?88:64)];
    customNavView.backgroundColor = kAppThemeColor;
    customNavView.alpha = 0;
    [self.view addSubview:customNavView];
}

-(void)initTableView
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = SIZEFIT(0);
    layout.minimumLineSpacing = 0;
    
    layout.footerReferenceSize = CGSizeMake(self.view.size.width, 5);
    self.aCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0,-64, self.view.frame.size.width,self.view.bounds.size.height) collectionViewLayout:layout];
    self.aCollectionView.backgroundColor = RGB(225, 225, 225);
    self.aCollectionView.dataSource = self;
    self.aCollectionView.delegate = self;
    [self.view addSubview:self.aCollectionView];
    
    [self.aCollectionView addSubview:self.headView];
    self.aCollectionView.contentInset = UIEdgeInsetsMake(SIZEFIT(163), 0, 0, 0);
    
    [self.aCollectionView registerClass:[MyFloorIndexCell class] forCellWithReuseIdentifier:@"MyFloorIndexCell"];
    [self.aCollectionView registerClass:[LDProductCollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LDProductCollectionHeadView"];
    [self.aCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"LDProductCollectionFootView"];
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(1, 1, 1, 1);//分别为上、左、下、右
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

    return CGSizeMake(self.view.size.width-10, 40);
}

//创建头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            LDProductCollectionHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LDProductCollectionHeadView" forIndexPath:indexPath];
            headView.backgroundColor = WhiteColor;
            headView.HeaderStyle = HeaderStyleTitleOnly;
            headView.titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [headView.titleBtn setTitle:titleArray[indexPath.section] forState:UIControlStateNormal];
            return headView;
        }else{
            UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"LDProductCollectionFootView" forIndexPath:indexPath];
            return footerView;
        }
}

//一共有多少个区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return titleArray.count;
}
//每一区有多少个cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSArray *array = indexArray[section];
    return array.count;
}
//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(self.view.frame.size.width/4-1,self.view.width/4);
    }else if (indexPath.section == 1){
        return CGSizeMake(self.view.frame.size.width/3-1,self.view.width/4);
    }else if (indexPath.section == 2){
        return CGSizeMake(self.view.frame.size.width/4-1,self.view.width/4);
    }else if (indexPath.section == 3){
        return CGSizeMake(self.view.frame.size.width/2-1,self.view.width/4);
    }else if (indexPath.section == 4){
        return CGSizeMake(self.view.frame.size.width/4-1,self.view.width/4);
    }
    return CGSizeMake(self.view.frame.size.width/3-1,self.view.width/4);
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
 
    MyFloorIndexCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyFloorIndexCell" forIndexPath:indexPath];
    
    cell.model = indexArray[indexPath.section][indexPath.row];
    return cell;
}

//cell的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        
         [self.navigationController pushViewController:[LDOrderObLineBaseController new] animated:YES];
        
    }else{
        [self login];
    }

//    [[LLUMengManager sharedInstance]showShareMenuView:@"墨菲定律" content:@"墨菲定律一个正经的APP 每日答题，海量现金大奖等你拿" img:[UIImage imageNamed:@"choose1"]  redirectURL:@"www.baidu.com" CompletionHandler:^(BOOL isSuccess) {
//        if (isSuccess) {
//
//        }}];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self setnavColor];
}

-(void)setnavColor{
    ws(bself);
    CGFloat offsetY = self.aCollectionView.contentOffset.y +SIZEFIT(163)+64;
    
    CGFloat alpha = (offsetY ) / (64*2);
    
    customNavView.alpha = alpha;
    
    if (offsetY < 0) {
        self.headView.frame = CGRectMake(offsetY/2., 0, kScreenWidth - offsetY, offsetY - SIZEFIT(163));
        
    }else{
        self.headView.frame = CGRectMake(0, 0, kScreenWidth, offsetY - SIZEFIT(163));
    }
    
    if (offsetY > 20) {
        [UIView animateWithDuration:1.0 animations:^{
            bself.navigationItem.title = @"个人中心";
        }];
    }else{
        bself.navigationItem.title = nil;
    }
    
}

- (void)reloadHeadView
{
//    if (_dataModel) {
//        headView.headImageUrl = _dataModel.Head;
//        headView.nameStr = _dataModel.NickName;

//    }else{
//        headView.headImageUrl = @"";
//        headView.nameStr = @"请登录";
        //        headView.phoneStr = @"请登录";
//    }
}
@end
