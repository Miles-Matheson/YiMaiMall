//
//  LDOnlineOrderDetailTopCell.m
//  YIMaiMall
//
//  Created by Miles on 2017/12/11.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDOnlineOrderDetailTopCell.h"

@implementation LDOnlineOrderDetailTopCell
{
    NSArray *nameArray;
    NSMutableArray *itemArray;
    NSMutableArray *titleArray;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}
-(void)initUI{
    nameArray = @[@"删除订单",@"取消订单",@"付款",@"提醒发货",@"确认收货",@"查看物流",@"取消退货",@"再次退货",@"去评价"];
    titleArray = [NSMutableArray array];
    itemArray = [NSMutableArray array];
    
    for (int i = 0; i < nameArray.count; i ++) {
        
        UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        customBtn.layer.cornerRadius = 5;
        customBtn.layer.masksToBounds = YES;
        customBtn.tag = i;
        [customBtn setTitle:nameArray[i] forState:UIControlStateNormal];
        [customBtn setTitleColor: RGB(153, 153, 153) forState:UIControlStateNormal];
        customBtn.backgroundColor = WhiteColor;
        customBtn.titleLabel.font = kFont14;
        customBtn.layer.borderColor = RGB(153, 153, 153).CGColor;
        customBtn.layer.borderWidth = 1.0;
        customBtn.hidden = YES;
        [itemArray addObject:customBtn];
        [self.contentView addSubview:customBtn];
        
        if (i == 2 || i == 3 || i ==  4 || i ==  6 || i ==  7 || i ==  8) {
            
            customBtn.layer.borderColor = kAppThemeColor.CGColor;
            [customBtn setTitleColor: WhiteColor forState:UIControlStateNormal];
            customBtn.backgroundColor = kAppThemeColor;
        }
    }
    
    CGFloat width = (SCREEN_WIDTH-45)/2.;
    CGFloat height =  width*.2395;
    
    UIView *view = [UIView new];
    view.backgroundColor = RGB(225, 225, 225);
    [self.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.height.offset(0.5);
        make.bottom.offset(-height-15-15);
    }];
    
    
    for (int i = 0; i < 10; i ++) {
        
        UILabel *titleLB = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"" textColor:RGB(102, 102, 102) textAlignment:Left font:kFont14];
        [self.contentView addSubview:titleLB];
        [titleArray addObject:titleLB];
    }
    
}

-(void)setModel:(LDOrderDetailModel *)model{
    _model = model;
    
    NSInteger indexNum = 0;
    CGFloat width = (SCREEN_WIDTH-45)/2.;
    
    NSArray *array = [LLUtils getOrderBottomStatusWithOrderStatus:_model.orderStatus];
    array =(NSMutableArray *)[[array reverseObjectEnumerator] allObjects];
    
    for (NSString *string in array) {
        
        for (UIButton *button in itemArray) {
            
            if ([button.titleLabel.text isEqualToString:string]) {
                button.hidden = NO;
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.offset(-(indexNum *(width +15))-15);
                    make.bottom.offset(-15);
                    make.size.sizeOffset(CGSizeMake(width, width*.2395));
                }];
                indexNum ++;
            }
        }
    }
    
    int top = 15;
    
    NSArray *titleArray = [LLUtils getOrderDetailTopTitlesWithOrderStatus:_model.orderStatus];
    
    for (NSString *string in titleArray) {
        
        for (UILabel *titleLB in itemArray) {

                titleLB.text = string;
                titleLB.hidden = NO;
                [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(15);
                    make.top.offset(1);
                }];
                indexNum ++;
        }
    }
    
}

@end
