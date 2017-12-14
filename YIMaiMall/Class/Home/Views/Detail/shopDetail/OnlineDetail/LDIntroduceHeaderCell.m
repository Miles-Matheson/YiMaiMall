//
//  LDIntroduceHeaderCell.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/30.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDIntroduceHeaderCell.h"

@implementation LDIntroduceHeaderCell
{
    NSMutableArray *starsArray;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [_focusButton setImage:[UIImage imageNamed:@"store_attention-"] forState:UIControlStateNormal];
    [_focusButton setImage:[UIImage imageNamed:@"store_attention-s"] forState:UIControlStateSelected];
    
    starsArray = [NSMutableArray array];
    
    for (int i = 0; i < 5; i ++) {
        UIImageView *startView = [UIImageView new];
        startView.tag = 100+i;
        startView.image = [UIImage imageNamed:@"store_grade"];
        [starsArray addObject:startView];
    }
}

-(void)setCount:(NSInteger)count{
    _count = count  ;
    
    ws(bself);
    
    for (int  i = 0; i < count; i++) {
        UIImageView *imvgView = starsArray[i];
        
        if (imvgView != [self viewWithTag:imvgView.tag]) {
            [self addSubview:imvgView];
            
            [imvgView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                if (i == 0) {
                    make.left.equalTo(_headerImageView.mas_right).offset(8);
                    make.centerY.equalTo(_headerImageView.mas_bottom).offset(-5);
                }else{
                    
                    UIView *lastImgView = [bself viewWithTag:imvgView.tag-1];
                    if (lastImgView) {
                        make.left.equalTo(lastImgView.mas_right).offset(5);
                        make.centerY.equalTo(lastImgView.mas_centerY);
                    }
                }
            }];
        }
    }
}

- (IBAction)foucsClick:(UIButton *)sender {
    
}
-(void)setModel:(LDStoreModel *)model{
    _model = model;
    
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:_model.logo] placeholderImage:[UIImage imageNamed:@"tx_def"]];
    
    _shopNameLB.text = _model.storeName;
    _focusLB.text = [NSString stringWithFormat:@"%ld",_model.favoriteCount];
    _focusButton.selected = _model.isAttention;
}

@end
