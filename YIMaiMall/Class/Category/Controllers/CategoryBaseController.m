//
//  OfflineBaseController.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/15.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "CategoryBaseController.h"

#import "LDCategoryCell.h"
#import "LDProductTopCell.h"
#import "LDProductIndexCell.h"
#import "LDCustomNavView.h"
#import "LDProductCollectionHeadView.h"
#import "LDHeaderFlowLayout.h"
#import "LDOnlineSearchController.h"
#import "LDBaseCategoryModel.h"
#import "LDBaseGoodsDetailController.h"

@interface CategoryBaseController ()<UITableViewDelegate, UITableViewDataSource,LDCustomNavViewDelegate,UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *rightCollectionView;
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong)LDCustomNavView *navView;

@property (nonatomic, strong)NSMutableArray *fristDataArray;
@property (nonatomic, strong)NSMutableArray *thridDataArray;

@end

@implementation CategoryBaseController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    _navView = [[LDCustomNavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    _navView.delegate = self;
    _navView.scanCodeBtn.hidden = YES;
    _navView.addTitleBtn.superview.hidden = YES;
    [self.view addSubview:_navView];
    
    
    [self createTableView];
    [self createRightCollectionView];
    
    [self requestDataWithID:@"0"];
    
    [_leftTableView  selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}

- (void)createTableView {
    
    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.sectionFooterHeight = 0.0;
    self.leftTableView.sectionHeaderHeight = 0.0;
    self.leftTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.leftTableView];
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.equalTo(_navView.mas_bottom);
        make.width.offset(SCREEN_WIDTH*0.24);
        make.bottom.offset(0);
    }];
    
    self.leftTableView.tableFooterView = [UIView new];
    
    [self.leftTableView registerClass:[LDCategoryCell class] forCellReuseIdentifier:@"LDCategoryCell"];
}

//MARK:-tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _fristDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LDCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDCategoryCell"];
    LDBaseCategoryModel *model = _fristDataArray[indexPath.row];
    cell.textLabel.text = model.classname;
    return cell;
}


//创建头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        LDProductCollectionHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LDProductCollectionHeadView" forIndexPath:indexPath];
        headView.HeaderStyle = HeaderStyleTitleOnly;
        LDBaseCategoryModel *model = _fristDataArray[indexPath.section];
        [headView.titleBtn setTitle: model.classname forState:UIControlStateNormal];
        return headView;
    }else{
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LDProductCollectionFootView" forIndexPath:indexPath];
        return footerView;
    }
}

//MARK: - 一个方法就能搞定 右边滑动时跟左边的联动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 如果是 左侧的 tableView 直接return
    if (scrollView == self.leftTableView) {
        return;
    }
    
    BOOL isUserTouch = scrollView.dragging || scrollView.tracking || scrollView.decelerating;
    if (!isUserTouch) {
        return;
    }
    
    NSArray *indexPaths = nil;
    
    if (@available(iOS 9.0, *)) {
        indexPaths= [self.rightCollectionView indexPathsForVisibleSupplementaryElementsOfKind:UICollectionElementKindSectionHeader];
    } else {
        indexPaths = [self.rightCollectionView indexPathsForVisibleItems];
    }
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    for (NSIndexPath *path in indexPaths) {
        
        NSNumber   *section = [NSNumber numberWithInteger:path.section];
        
        [array addObject:section];
    }
    
    NSNumber * min1= [array valueForKeyPath:@"@min.floatValue"];
    
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:[min1 integerValue] inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

//MARK: - 点击 cell 的代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 选中 左侧 的 tableView
    if (tableView == self.leftTableView) {
        
        [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        
        if (CurrentSystemVersion <9) {
            // 将右侧 tableView 移动到指定位置
            [self.rightCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.row] animated:YES scrollPosition:UICollectionViewScrollPositionTop];
            
            CGPoint point = self.rightCollectionView.contentOffset;
            
            point.y = point.y+40;
            
            self.rightCollectionView.contentOffset = point;
            
        }else{
            // 将右侧 tableView 移动到指定位置
            
           NSArray *array =  _thridDataArray[indexPath.row];
            if (array.count) {
                [self.rightCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.row] animated:YES scrollPosition:UICollectionViewScrollPositionTop];
            }
        }
    }
}

#pragma mark - 懒加载 tableView -

// MARK: - 右边的 tableView
- ( void)createRightCollectionView {
    
    //此处必须要有创见一个UICollectionViewFlowLayout的对象
    UICollectionViewFlowLayout *layout  = nil;

    layout = [[UICollectionViewFlowLayout alloc]init];
    if (@available(iOS 9.0, *)) {
        layout.sectionHeadersPinToVisibleBounds = YES;
    } else {
         layout = (LDHeaderFlowLayout *)[[LDHeaderFlowLayout alloc]init];
    }

    layout.minimumInteritemSpacing = SIZEFIT(5);//同一行相邻两个cell的最小间距
    layout.minimumLineSpacing = 0;//最小两行之间的间距

    if (@available(iOS 9.0, *)) {
        layout.sectionHeadersPinToVisibleBounds = YES;
    }
    layout.headerReferenceSize = CGSizeMake(self.view.width, 40);
    layout.footerReferenceSize = CGSizeMake(0, 0);
    
    _rightCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH *0.25, 64, SCREEN_WIDTH *0.75, SCREEN_HEIGHT-49-64) collectionViewLayout:layout];
    _rightCollectionView.backgroundColor =  WhiteColor;
    _rightCollectionView.dataSource = self;
    _rightCollectionView.delegate = self;
    _rightCollectionView.showsVerticalScrollIndicator =   NO;
    [self.view addSubview:_rightCollectionView];
    
    // 注册cell、sectionHeader、sectionFooter
    [_rightCollectionView registerClass:[LDProductTopCell class] forCellWithReuseIdentifier:@"LDProductTopCell"];
    [_rightCollectionView registerClass:[LDProductIndexCell class] forCellWithReuseIdentifier:@"LDProductIndexCell"];
    [_rightCollectionView registerClass:[LDProductCollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LDProductCollectionHeadView"];
    [_rightCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LDProductCollectionFootView"];
}

//一共有多少个区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _thridDataArray.count;
}
//每一区有多少个cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSArray *array = _thridDataArray[section];
    return  array.count;
}

//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width =  SCREEN_WIDTH *0.76/3.-10;
    return CGSizeMake(width, width+20);
}
//脚部试图的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(0, 0);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 5, 0, 5);//分别为上、左、下、右
}
- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *array = _thridDataArray[indexPath.section];
    
    LDCategoryThirdChildModel *model = array[indexPath.row];
    
    LDProductIndexCell *indexCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDProductIndexCell" forIndexPath:indexPath];
    indexCell.imageUrlString = model.iconUrl;
    indexCell.nameString = model.classname;
    return indexCell;
}

//cell的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row != 0) {
        
        NSArray *secArray = _thridDataArray[indexPath.section];
        LDCategoryThirdChildModel *thirdChildModel = secArray[indexPath.row];
        
        [self.navigationController pushViewController:[[LDBaseGoodsDetailController alloc]initWithGoodsID:@""] animated:YES];
    }
}


- (void)requestDataWithID:(NSString *)ID
{
    WS(bself);
    
    
    [[APIManager sharedManager] getClassTabDataCallBack:^(id data) {
        
        NSArray *array = [LDBaseCategoryModel mj_objectArrayWithKeyValuesArray:data[@"obj"][@"childs"]];
        bself.fristDataArray = [[NSMutableArray alloc]initWithArray:array];
        
        bself.thridDataArray = [NSMutableArray array];
        
        for (LDBaseCategoryModel *model in bself.fristDataArray) {
            
            NSMutableArray *array = [NSMutableArray array];
            for (LDCategorySecondChildModel *secondModel in model.childs) {
     
                    [array addObjectsFromArray:secondModel.childs];
            }
            [bself.thridDataArray addObject:array];
        }
        [bself.leftTableView reloadData];
        [bself.rightCollectionView reloadData];
        [bself.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        
    } fail:^(NSString *errorString) {
        
    }];
    
}

@end

