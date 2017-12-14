//
//  ShopCartBottomView.m
//  BaseFrame
//
//  Created by 陈舟为 on 2017/6/27.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import "LDStatmentBottomView.h"

@interface LDStatmentBottomView ()
{
    UILabel *priceLab ;
    UIButton *statmentBtn;
}
@end

@implementation LDStatmentBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        
        self.backgroundColor = RGB(247, 247, 247);
        
        [self initUI];
    }
    
    return self;
}

-(void)initUI{
    
    statmentBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    [statmentBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [statmentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    statmentBtn.titleLabel.font = [UIFont systemFontOfSize:FONTFIT(13)];
    [statmentBtn setBackgroundColor:[UIColor lightGrayColor]];
    [statmentBtn addTarget:self action:@selector(settleButtonAction) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:statmentBtn];
    [statmentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.offset(0);
        make.width.equalTo(@100);
    }];
    
    priceLab = [[UILabel alloc]init];
    [self addSubview:priceLab];
    
    [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(statmentBtn.mas_left).offset(-10);
        make.centerY.offset(0);
    }];
}

-(void)setPrice:(CGFloat)price count:(NSInteger)count
{
    _price = price;
    _count = count;
    
//    NSString *string = [NSString stringWithFormat:@"预付款 ¥%.2f",_price];
//
//    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:string];
//
//    [att addAttributes:@{
//                         NSForegroundColorAttributeName:RGB(153, 153, 153),
//                         NSFontAttributeName:kFont13,
//                         }
//                 range:NSMakeRange(0, 3)];
//
//    [att addAttributes:@{
//                         NSForegroundColorAttributeName:kAppThemeColor,
//                         NSFontAttributeName:kFont13,
//                         }
//                 range:NSMakeRange(3, att.length-3)];
//
//    priceLab.attributedText = att;
    
        NSString *countString = [NSString stringWithFormat:@"共%ld件",_count];
        NSString *priceString = [NSString stringWithFormat:@"总金额 ¥%.2f",_price];
        NSString *string = [NSString stringWithFormat:@"%@,%@",countString,priceString];
    
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:string];
    
        [att addAttributes:@{
                             NSForegroundColorAttributeName:RGB(153, 153, 153),
                             NSFontAttributeName:kFont13,
                             }
                     range:NSMakeRange(0, countString.length+5)];
    
        [att addAttributes:@{
                             NSForegroundColorAttributeName:kAppSubThemeColor,
                             NSFontAttributeName:kFont13,
                             }
                     range:NSMakeRange(countString.length+5, att.length-countString.length-5)];
    
        priceLab.attributedText = att;
    

    if (_price == 0) {
        
        statmentBtn.backgroundColor = [UIColor lightGrayColor];
        statmentBtn.userInteractionEnabled = NO;
        
    }else{
        statmentBtn.backgroundColor = kAppThemeColor;
        statmentBtn.userInteractionEnabled = YES;
    }
}

- (void)settleButtonAction {
    if (_statmentClick) {
        _statmentClick();
    }
}

@end
