//
//  LDHomeIndexCell.m
//  StairOrder
//
//  Created by Miles on 2017/8/15.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDCollectionIndexCell.h"
#import "CostomButton.h"
@implementation LDCollectionIndexCell
{
    NSMutableArray *itemsArray;
}


-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
        self.contentView.backgroundColor = WhiteColor;
    }
    return self;
}

- (void)initUI
{
    CGFloat width = SCREEN_WIDTH /4.;
    
    CGFloat height = SIZEFIT(186)/2.;
    
    ws(bself);
    
    itemsArray = [NSMutableArray array];

    for (int i = 0; i < 8; i ++) {
        
        CostomButton *callBtn = [[CostomButton alloc] initWithFrame:CGRectMake(width*(i%4),width *(i/4), width, height)];

        [callBtn setTitleColor:RGB(99, 99, 9) forState:0];

        [callBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
            
            if (bself.itemClickCallBack) {
                bself.itemClickCallBack(bself.models[i]);
            }
        }];
        [self.contentView addSubview:callBtn];
        
        [itemsArray addObject:callBtn];
    }
}

- (void)setModels:(NSArray *)models
{
    _models = models;
    
    for (int i =0; i < models.count; i ++) {
        
        if (i  < itemsArray.count) {
           
            CostomButton *itemBtn = (CostomButton *)itemsArray[i];
            LDClickIndexModel *model = (LDClickIndexModel *)models[i];
            
            itemBtn.imageUrl = model.imgUrl;
            itemBtn.textLable = model.name;
        }
    }
}

@end
