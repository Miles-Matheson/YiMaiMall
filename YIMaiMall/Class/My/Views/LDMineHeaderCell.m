//
//  LDMineHeaderCell.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/28.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDMineHeaderCell.h"

@implementation LDMineHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSeparatorStyleNone;
    
    [self.clickBtn addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.bgImageView.backgroundColor = kAppThemeColor;
    
    NSString *string = @"馆主:绿地赢海店";
    
    CGSize size =  [LLUtils getStringSize:string font:13 width:300];
    
    _roleLB.text = string;
    _roleLB.layer.masksToBounds = YES;
    _roleLB.layer.cornerRadius = 10;
    _roleLB.textAlignment = Center;
    
    [_roleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(size.width+15);
        make.height.offset(25);
    }];
 
}

-(void)itemClick:(UIButton *)btn{
    
    if (_headerClick) {
        _headerClick(btn);
    }
}

- (IBAction)bottomButtonClick:(UIButton *)sender {
    if (_bottomClick) {
        UIButton *view = (UIButton *)sender;
        _bottomClick(view.tag);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
