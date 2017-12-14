
//
//  LDOnlineOrderDetailHeaderView.m
//  YIMaiMall
//
//  Created by Miles on 2017/12/11.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDOnlineOrderDetailHeaderView.h"
#import "LFButton.h"

@implementation LDOnlineOrderDetailHeaderView
{
    LFButton *storeNameBtn;
    UIButton *returnButton;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
         [self initUI];
    }
    return self;
}


-(void)initUI{
    
    ws(bself);
    
    self.contentView.backgroundColor = WhiteColor;
    
    storeNameBtn = [LFButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:storeNameBtn];
    [storeNameBtn setTitleColor:BlackColor forState:UIControlStateNormal];
    
    [storeNameBtn setImage:[UIImage imageNamed:@"arrow_4"] forState:UIControlStateNormal];
    [storeNameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.centerY.offset(0);
    }];
    
    [storeNameBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
        if (bself.storeClickCallBack) {
            bself.storeClickCallBack();
        }
    }];

    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:returnButton];
    returnButton.titleLabel.font = kFont13;
    returnButton.layer.borderWidth = 1.0;
    returnButton.layer.borderColor = RGB(153, 153, 153).CGColor;
    returnButton.layer.cornerRadius = 5;
    [returnButton setTitle:@"申请退货" forState:UIControlStateNormal];
    [returnButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.offset(0);
        NSString *str = @"申请退货";
        make.size.sizeOffset(CGSizeMake(str.length +25 ,30));
    }];
}

-(void)setModel:(LDOrderDetailModel *)model{
    _model = model;
    if (_model.storeName) {
        [storeNameBtn setTitle:[NSString stringWithFormat:@"%@ ",_model.storeName] forState:UIControlStateNormal];
    }

    if (_model.orderStatus == 30 || _model.orderStatus == 49 || _model.orderStatus == 40 ) {
        returnButton.hidden = NO;
    }else{
        returnButton.hidden = YES;
    }
}

@end
