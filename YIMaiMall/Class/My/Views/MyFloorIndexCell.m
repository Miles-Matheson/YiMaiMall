//
//  MyFloorIndex2Cell.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/23.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "MyFloorIndexCell.h"

@implementation MyFloorIndexCell
{
    CostomButton *itemButtom;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
-(id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.contentView.backgroundColor = WhiteColor;
        itemButtom = [[CostomButton alloc]init];
        itemButtom.userInteractionEnabled = NO;
        [self.contentView addSubview:itemButtom];
        [itemButtom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.offset(0);
            make.top.offset(10);
            make.bottom.offset(-10);
            make.width.equalTo(itemButtom.mas_height);
        }];
    }
    return self;
}

-(void)setModel:(LDFloorIndexModel *)model{
    _model = model;
    
    itemButtom.textLable = _model.name;
    itemButtom.imageName = _model.iconName;
}

@end
