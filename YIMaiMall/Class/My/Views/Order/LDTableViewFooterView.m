//
//  LDTableViewFooterView.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/23.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDTableViewFooterView.h"
@interface LDTableViewFooterView ()

@property (nonatomic,strong) NSMutableArray *bottomStatusArray;

@property (nonatomic,strong) UIView *bgBottomView;

@end

@implementation LDTableViewFooterView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = WhiteColor;
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    
    _bgBottomView = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH , 40)];
    _bgBottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_bgBottomView];
    
    /************************************/
    
    [self  createClickItemButtom];
}


- (void)createClickItemButtom{
    
    _bottomStatusArray = [NSMutableArray array];

    
    NSArray *arr = @[@"取消订单",@"删除订单",@"付款",@"提醒发货",@"确认收货",@"查看物流",@"取消退货",@"再次退货",@"去评价"];
    
    for (int i = 0; i < arr.count; i ++) {
        
        UIButton *button = [[UIButton alloc] init];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:RGB(92, 92, 92) forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:FONTFIT(15)];
        button.layer.cornerRadius = 5;
        button.layer.borderWidth = 1.0;
        [button setTitle:arr[i] forState:0];
        button.layer.borderColor = RGB(92, 92, 92).CGColor;
        
        [button addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgBottomView addSubview:button];

        button.tag = i;
        [_bottomStatusArray addObject:button];
        button.hidden = YES;
        if (i == 2 || i == 3 || i == 4 || i == 6 || i == 7 || i == 8) {
            [button setTitleColor:kAppSubThemeColor forState:UIControlStateNormal];
            button.layer.borderColor = kAppSubThemeColor.CGColor;
            button.backgroundColor = WhiteColor;
        }
    }
}

-(void)itemClick:(UIButton *)btn
{
    UIButton *button = (UIButton *)btn;
    if (self.statusCliackCallBack) {
        self.statusCliackCallBack(button.tag,self.model);
    }
}

-(void)setModel:(LDOrderModel *)model{
    
    
    _model = model;
    
    NSInteger indexNum = 0;
    
    CGFloat width = 90;

    //如果数组中装的是1，2，3，4经过reverseObjectEnumerator处理后，数组中各个元素会倒序排列，结果为4，3，2，1.
    
    NSArray *array = [LLUtils getOrderBottomStatusWithOrderStatus:_model.orderStatus];
    array =(NSMutableArray *)[[array reverseObjectEnumerator] allObjects];
 
    NSMutableArray *showArray = [NSMutableArray array];
    
    for (NSString *string in array) {
        
        for (UIButton *button in self.bottomStatusArray) {
            
            if (![showArray containsObject: button]) {
                button.hidden = YES;
            }
            
            if ([button.titleLabel.text isEqualToString:string]) {
                
                button.hidden = NO;
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.offset(-(indexNum *(width +10)) -10);
                    make.centerY.offset(0);
                    make.size.sizeOffset(CGSizeMake(90, 30));
                }];
                indexNum ++;
            }
            
            [showArray addObject:button];
        }
    }
    
//    if (array.count == 0) {
//        UIButton *button = self.bottomStatusArray.lastObject;
//        button.hidden = NO;
//        [button mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.offset(-10);
//            make.centerX.offset(0);
//            make.size.sizeOffset(CGSizeMake(90, 30));
//        }];
//    }
}


@end
