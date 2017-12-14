//
//  MKJShoppingCartViewController.m
//  TaoBaoShoppingCart
//
//  Created by MKJING on 16/9/10.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "MKJShoppingCartViewController.h"
#import "shoppingCartModel.h"
#import "MKJRequestHelper.h"
#import "ShoppingCartCell.h"
#import "LDShopCartModel.h"

#import "UITableView+FDTemplateLayoutCell.h"
#import "UIViewController+KNSemiModal.h"
#import "JTSImageViewController.h"

@interface MKJShoppingCartViewController () <UITableViewDelegate,UITableViewDataSource,ShoppingCartCellDelegate,UIAlertViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) NSMutableArray *buyerLists;
@property (nonatomic,strong) UIButton *rightButton;

// 由于代理问题衍生出的来已经选择单个或者批量的数组装Cell
@property (nonatomic,strong) NSMutableArray *tempCellArray;

// 底部统计View的控件 （normal）
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *allSelectedButton;
@property (weak, nonatomic) IBOutlet UIView *normalBottomRightView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *normalBottomRightWidthConstraint;
@property (weak, nonatomic) IBOutlet UIButton *accountButton;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;

// 底部全局编辑按钮 (edit)
@property (weak, nonatomic) IBOutlet UIView *editBottomRightView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *editBottomRightWidthConstraint;
@property (weak, nonatomic) IBOutlet UIButton *editBaby;
@property (weak, nonatomic) IBOutlet UIButton *bottomDelete;
@property (weak, nonatomic) IBOutlet UIButton *storeButton;


@property (nonatomic,strong) UIView *textView;


@end


static NSString *shoppongID = @"ShoppingCartCell";
static NSString *shoppingHeaderID = @"BuyerHeaderCell";


@implementation MKJShoppingCartViewController


- (void)dealloc
{
    NSLog(@"%s____dealloc",object_getClassName(self));
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

-(void)clickRightBtn:(UIButton *)rightBtn{
    
    [rightBtn setTitle:@"完成" forState:UIControlStateSelected];
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [rightBtn setTitle:@"编辑" forState:UIControlStateDisabled];
    [rightBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn setTitleColor:kAppThemeColor forState:UIControlStateSelected];
    
    [self clickAllEdit:rightBtn];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

     self.title = @"购物车";
    
    [self setRightText:@"编辑" textColor:RGB(51, 51, 51) ImgPath:nil];
    self.rightButton = self.navigationItem.rightBarButtonItem.customView;
    
    [self initTableView];
    
    [self getShopCartListWithUserID:@""];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:LOGINSUCCESS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:ADDGOODSCOUNT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:LOGOUTSUCCESS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:ADDGOODS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:ORDERSUBMITFINISH object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:ADDGOODS object:nil];
}

-(void)initTableView{
    ws(bself);
    CGFloat bottom = 0;
    if ([self.navigationController.childViewControllers.firstObject isKindOfClass:[MKJShoppingCartViewController class]]) {
        bottom = 49;
    }
    
    self.aTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, self.view.height -64-50-bottom) style:UITableViewStyleGrouped];
    self.aTableView.delegate  = self;
    self.aTableView.dataSource  = self;
    [self.view addSubview:self.aTableView];
    
    [self.aTableView registerNib:[UINib nibWithNibName:shoppongID bundle:nil] forCellReuseIdentifier:shoppongID];
    [self.aTableView registerNib:[UINib nibWithNibName:shoppingHeaderID bundle:nil] forCellReuseIdentifier:shoppingHeaderID];
    
    if (@available (iOS 11.0,*)) {
        self.aTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets    = NO;
    }
    
    self.normalBottomRightWidthConstraint.constant = [UIScreen mainScreen].bounds.size.width * 2 / 3;
    self.editBottomRightWidthConstraint.constant = [UIScreen mainScreen].bounds.size.width * 2 / 3;
    [self.view addSubview:self.bottomView];
    self.editBottomRightView.hidden = YES;
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.offset(50);
        make.top.equalTo(bself.aTableView.mas_bottom);
    }];
    
}

-(void)reloadData{
    [self silenceRefresh];
}
#pragma mark - 点击全部编辑按钮
- (void)clickAllEdit:(UIButton *)button{
    
    button.selected = !button.selected;
    for (BuyerInfo *buyer in self.buyerLists){
        
        buyer.buyerIsEditing = button.selected;
    }
    [self.aTableView reloadData];
    self.editBottomRightView.hidden = !button.selected;
}

-(void)getShopCartListWithUserID:(NSString *)userID{
    
    ws(bself);
    self.totalPriceLabel.text = @"合计￥0.00";
    self.allSelectedButton.selected = NO;
    self.rightButton.selected = NO;
    
    
    [self setScroll:self.aTableView firstPageNor:1 pageSize:1000 networkCallback:^(NSInteger page, CompletionCallback completionCallback) {
        
        [[APIManager sharedManager] getShopCatrListWithUserID:userID CallBack:^(id data) {
            

                [bself.buyerLists removeAllObjects];

             [bself.aTableView reloadData];
            
                NSArray *array =  [BuyerInfo mj_objectArrayWithKeyValuesArray:data[@"obj"]];
            
            bself.buyerLists = array;
                completionCallback(array?YES:NO,array?array:@[]);
            
            
        } fail:^(NSString *errorString) {
            completionCallback(NO,@[]);
        }];
        
    } noMoreDataCallback:^(NSInteger page) {
    }];
    [self silenceRefresh];
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.buyerLists.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    BuyerInfo *buyer = self.buyerLists[section];
    return buyer.goodsCarts.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:shoppongID forIndexPath:indexPath];
    
    cell.delegate = self;
    [self configCell:cell indexPath:indexPath];
    return cell;
}

// 组装cell
- (void)configCell:(ShoppingCartCell *)cell indexPath:(NSIndexPath *)indexPath{
    
    BuyerInfo *buyer = self.buyerLists[indexPath.section];
    LDShopGoodsCartsModel *product = buyer.goodsCarts[indexPath.row];
    cell.leftChooseButton.selected = product.productIsChoosed; //!< 商品是否需要选择的字段
    __weak typeof(cell)weakCell = cell;
    [cell.productImageView sd_setImageWithURL:[NSURL URLWithString:product.goods.goodsPhotoUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image && cacheType == SDImageCacheTypeNone)
        {
            weakCell.productImageView.alpha = 0;
            [UIView animateWithDuration:1.0 animations:^{
               
                weakCell.productImageView.alpha = 1.0f;
            }];
            
        }else{
            weakCell.productImageView.alpha = 1.0f;
        }
    }];
    cell.titleLabel.text = product.goods.goodsName;

    cell.sizeDetailLabel.text = @"";
    cell.editDetailView.hidden = YES;

    
    cell.priceLabel.attributedText = [[MKJRequestHelper shareRequestHelper] recombinePrice:product.cartPrice orderPrice:product.cartPrice];
    
    cell.countLabel.text = [NSString stringWithFormat:@"x%ld",(long)product.count];
    
    cell.editCountLabel.text = [NSString stringWithFormat:@"%ld",(long)product.count];
    
    
    // 正常模式下面 非编辑
    if (!buyer.buyerIsEditing){
        cell.normalBackView.hidden = NO;
        cell.editBackView.hidden = YES;
    }else{
        cell.normalBackView.hidden = YES;
        cell.editBackView.hidden = NO;
    }
}

// 高度计算
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BuyerInfo *buyer = self.buyerLists[indexPath.section];
    
    if (buyer.buyerIsEditing){
        return 100;
    }else{
        CGFloat actualHeight = [tableView fd_heightForCellWithIdentifier:shoppongID cacheByIndexPath:indexPath configuration:^(ShoppingCartCell *cell) {
            
            [self configCell:cell indexPath:indexPath];
            
        }];
        return actualHeight >= 100 ? actualHeight : 100;
    }
}

// tableView的sectionHeader加载数据
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BuyerInfo *buyer = self.buyerLists[section];
    ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:shoppingHeaderID];
    cell.headerSelectedButton.selected = buyer.buyerIsChoosed; //!< 买手是否需要勾选的字段
    cell.buyerNameLabel.text = buyer.storeName;
    cell.sectionIndex = section;
    cell.editSectionHeaderButton.selected = buyer.buyerIsEditing;
    if (self.rightButton.selected){
        cell.editSectionHeaderButton.hidden = YES;
    }else{
        cell.editSectionHeaderButton.hidden = NO;
    }
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma -
#pragma - 点击单个商品cell选择按钮
- (void)productSelected:(ShoppingCartCell *)cell isSelected:(BOOL)choosed{
    
    NSIndexPath *indexPath = [self.aTableView indexPathForCell:cell];
    BuyerInfo *buyer  = self.buyerLists[indexPath.section];
    LDShopGoodsCartsModel *product = buyer.goodsCarts[indexPath.row];
    product.productIsChoosed = !product.productIsChoosed;
    // 当点击单个的时候，判断是否该买手下面的商品是否全部选中
    __block NSInteger count = 0;
    [buyer.goodsCarts enumerateObjectsUsingBlock:^(LDShopGoodsCartsModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if (obj.productIsChoosed)
        {
            count ++;
        }
    }];
    if (count == buyer.goodsCarts.count){
        
        buyer.buyerIsChoosed = YES;
    }else{
        buyer.buyerIsChoosed = NO;
    }
    [self.aTableView reloadData];
    // 每次点击都要统计底部的按钮是否全选
    self.allSelectedButton.selected = [self isAllProcductChoosed];
    
    [self.accountButton setTitle:[NSString stringWithFormat:@"结算(%ld)",(long)[self countTotalSelectedNumber]] forState:UIControlStateNormal];
    
    self.totalPriceLabel.text = [NSString stringWithFormat:@"合计￥%.2f",[self countTotalPrice]];
}


#pragma mark - 点击buer选择按钮回调
- (void)buyerSelected:(NSInteger)sectionIndex{
    
    BuyerInfo *buyer = self.buyerLists[sectionIndex];
    buyer.buyerIsChoosed = !buyer.buyerIsChoosed;
    [buyer.goodsCarts enumerateObjectsUsingBlock:^(LDShopGoodsCartsModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.productIsChoosed = buyer.buyerIsChoosed;
    }];
    [self.aTableView reloadData];
    // 每次点击都要统计底部的按钮是否全选
    self.allSelectedButton.selected = [self isAllProcductChoosed];
    
    [self.accountButton setTitle:[NSString stringWithFormat:@"结算(%ld)",(long)[self countTotalSelectedNumber]] forState:UIControlStateNormal];
    
    self.totalPriceLabel.text = [NSString stringWithFormat:@"合计￥%.2f",[self countTotalPrice]];
}

#pragma mark - 点击buyer编辑按钮回调
- (void)buyerEditingSelected:(NSInteger)sectionIdx{
    
    BuyerInfo *buy = self.buyerLists[sectionIdx];
    buy.buyerIsEditing = !buy.buyerIsEditing;
    [self.aTableView reloadData];
}

#pragma mark - 点击编辑详情回调
- (void)clickEditingDetailInfo:(ShoppingCartCell *)cell{

}


#pragma mark - 点击图片展示Show
- (void)clickProductIMG:(ShoppingCartCell *)cell
{
    NSIndexPath *indexpath = [self.aTableView indexPathForCell:cell];
    BuyerInfo *buyer = self.buyerLists[indexpath.section];
    LDShopGoodsCartsModel *product = buyer.goodsCarts[indexpath.row];
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    NSString *imageURLStr = product.goods.goodsPhotoUrl;
    imageInfo.imageURL  = [NSURL URLWithString:imageURLStr];
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                           initWithImageInfo:imageInfo
                                           mode:JTSImageViewControllerMode_Image
                                           backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
    [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOffscreen];
}

#pragma mark -增加或者减少商品
- (void)plusOrMinusCount:(ShoppingCartCell *)cell tag:(NSInteger)tag
{
    NSIndexPath *indexpath = [self.aTableView indexPathForCell:cell];
    BuyerInfo *buyer = self.buyerLists[indexpath.section];
    LDShopGoodsCartsModel *product = buyer.goodsCarts[indexpath.row];
    
    if (tag == 555)
    {
        if (product.count <= 1) {
            
        }
        else
        {
            product.count --;
        }
    }
    else if (tag == 666)
    {
        product.count ++;
    }
    self.totalPriceLabel.text = [NSString stringWithFormat:@"合计￥%.2f",[self countTotalPrice]];
    [self.aTableView reloadData];
}

#pragma mark - 点击单个商品删除回调
- (void)productGarbageClick:(ShoppingCartCell *)cell
{
    [self.tempCellArray removeAllObjects];
    [self.tempCellArray addObject:cell];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认删除？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 101;
    alert.delegate = self;
    [alert show];
}

// alert的代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // 单个删除
    if (alertView.tag == 101) {
        if (buttonIndex == 1)
        {
            NSIndexPath *indexpath = [self.aTableView indexPathForCell:self.tempCellArray.firstObject];
            BuyerInfo *buyer = self.buyerLists[indexpath.section];
            LDShopGoodsCartsModel *product = buyer.goodsCarts[indexpath.row];
            if (buyer.goodsCarts.count == 1) {
                [self.buyerLists removeObject:buyer];
            }else{
                [buyer.goodsCarts removeObject:product];
            }
            // 这里删除之后操作涉及到太多东西了，需要
            [self updateInfomation];
        }
    }
    else if (alertView.tag == 102) // 多个或者单个
    {
        if (buttonIndex == 1)
        {
            NSMutableArray *buyerTempArr = [[NSMutableArray alloc] init];
            for (BuyerInfo *buyer in self.buyerLists)
            {
                if (buyer.buyerIsChoosed)
                {
                    [buyerTempArr addObject:buyer];
                }
                else
                {
                    NSMutableArray *productTempArr = [[NSMutableArray alloc] init];
                    for (ProductInfo *product in buyer.goodsCarts)
                    {
                        if (product.productIsChoosed)
                        {
                            [productTempArr addObject:product];
                        }
                    }
                    if (productTempArr.count){
                        [buyer.goodsCarts removeObjectsInArray:productTempArr];
                    }
                }
            }
            [self.buyerLists removeObjectsInArray:buyerTempArr];
            [self updateInfomation];
        }
    }
    
}

#pragma mark - 删除之后一些列更新操作
- (void)updateInfomation
{
    // 会影响到对应的买手选择
    for (BuyerInfo *buyer in self.buyerLists) {
        NSInteger count = 0;
        for (ProductInfo *product in buyer.goodsCarts) {
            if (product.productIsChoosed) {
                count ++;
            }
        }
        if (count == buyer.goodsCarts.count) {
            buyer.buyerIsChoosed = YES;
        }
    }
    // 再次影响到全部选择按钮
    self.allSelectedButton.selected = [self isAllProcductChoosed];
    
    self.totalPriceLabel.text = [NSString stringWithFormat:@"合计￥%.2f",[self countTotalPrice]];
    
    [self.accountButton setTitle:[NSString stringWithFormat:@"结算(%ld)",(long)[self countTotalSelectedNumber]] forState:UIControlStateNormal];
    
    [self.aTableView reloadData];
    
    // 如果删除干净了
    if (self.buyerLists.count == 0) {
        [self clickAllEdit:self.rightButton];
        self.rightButton.enabled = NO;
    }
   
    
}


#pragma mark - 判断是否全部选中了
- (BOOL)isAllProcductChoosed
{
    if (self.buyerLists.count == 0) {
        return NO;
    }
    NSInteger count = 0;
    for (BuyerInfo *buyer in self.buyerLists) {
        if (buyer.buyerIsChoosed) {
            count ++;
        }
    }
    return (count == self.buyerLists.count);
}

#pragma mark - 点击底部全选按钮
- (IBAction)clickAllProductSelected:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    for (BuyerInfo *buyer in self.buyerLists) {
        buyer.buyerIsChoosed = sender.selected;
        for (ProductInfo *product in buyer.goodsCarts) {
            product.productIsChoosed = buyer.buyerIsChoosed;
        }
    }
    [self.aTableView reloadData];
    
    CGFloat totalPrice = [self countTotalPrice];
    self.totalPriceLabel.text = [NSString stringWithFormat:@"合计￥%.2f",totalPrice];
    [self.accountButton setTitle:[NSString stringWithFormat:@"结算(%ld)",(long)(long)[self countTotalSelectedNumber]] forState:UIControlStateNormal];
    
}


#pragma -
#pragma mark - 计算选出商品的总价
- (CGFloat)countTotalPrice{
    
    CGFloat totalPrice = 0.0;
    for (BuyerInfo *buyer in self.buyerLists) {
        if (buyer.buyerIsChoosed) {
            for (ProductInfo *product in buyer.goodsCarts) {
                totalPrice += product.cartPrice * product.count;
            }
        }else{
            for (ProductInfo *product in buyer.goodsCarts) {
                if (product.productIsChoosed) {
                    totalPrice += product.cartPrice * product.count;
                }
            }
            
        }
    }
    return totalPrice;
}

#pragma mark - 计算商品被选择了数量
- (NSInteger)countTotalSelectedNumber
{
    NSInteger count = 0;
    for (BuyerInfo *buyer in self.buyerLists) {
        for (ProductInfo *product in buyer.goodsCarts) {
            if (product.productIsChoosed) {
                count ++;
            }
        }
    }
    return count;
}

// 分享
- (IBAction)share:(id)sender {
    NSLog(@"分享宝贝");
}

// 移动到收藏夹
- (IBAction)store:(id)sender {
    NSLog(@"移动到收藏夹");
}

// 底部多选删除也可单选删除
- (IBAction)deleteMultipleOrSingfle:(id)sender {
    
    // 这个大的是用来过滤buyer的 没有就是nil，从商品数组中删除
    [self.tempCellArray removeAllObjects];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认删除？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 102;
    alert.delegate = self;
    [alert show];
}



- (NSMutableArray *)buyerLists{
    if (_buyerLists == nil) {
        _buyerLists = [[NSMutableArray alloc] init];
    }
    return _buyerLists;
}

- (NSMutableArray *)tempCellArray{
    
    if (_tempCellArray == nil) {
        _tempCellArray = [[NSMutableArray alloc] init];
    }
    return _tempCellArray;
}


@end
