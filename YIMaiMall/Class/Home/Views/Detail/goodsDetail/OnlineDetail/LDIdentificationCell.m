//
//  LDIdentificationCell.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/17.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDIdentificationCell.h"
@interface LDIdentificationCell ()

@property (nonatomic,strong)  UILabel *chooseSkuLB;
@property (nonatomic,strong)  UILabel *titleLB;

@end
@implementation LDIdentificationCell


-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self initUI];
        self.contentView.backgroundColor = WhiteColor;
    }
    return self;
}

-(void)initUI{
    
    NSMutableArray *array = [NSMutableArray array];
    
    NSArray *titleArr = @[@"100%全球正品",@"七天无理由退换货",@"专业物流包装配送",];
    for (int i = 0; i < titleArr.count; i ++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@""] forState:0];
        [btn setTitle:titleArr[i] forState:0];
        [btn setTitleColor:RGB(102, 102, 102) forState:0];
        btn.titleLabel.font = kFont11;
        [self.contentView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.offset(0);
            if (i == 0) {
                make.left.offset(12);
            }else if (i == 2){
                make.centerX.offset(0);
            }else{
                make.right.offset(-12);
            }
        }];
        [array addObject:btn];
    }
}

@end
