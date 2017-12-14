//
//  LDCategoryCell.m
//  FullAndFresh
//
//  Created by Miles on 2017/9/7.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDCategoryCell.h"

@implementation LDCategoryCell
{
    UIView *line;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.textLabel.font = kFont13;
        
        [self initUI]; 
    }
    return self;
}
- (void)initUI
{
    line = [UIView new];
    line.backgroundColor = kAppThemeColor;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0.5);
        make.top.offset(5);
        make.bottom.offset(-5);
        make.width.offset(2);
    }];
}


-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    ws(bself);
    [UIView animateWithDuration:0.4 animations:^{
         line.backgroundColor = selected?kAppThemeColor:ClearColor;
         bself.textLabel.textColor =selected?kAppThemeColor:BlackColor;
    }];
}

@end
