//
//  LDChooseExpressCell.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/21.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDChooseExpressCell.h"

@implementation LDChooseExpressCell
{
    UIImageView *selectImgView;
}
- (void)awakeFromNib {
    [super awakeFromNib];

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        
        selectImgView.image = [UIImage imageNamed:@""];
        selectImgView.backgroundColor = BlueColor;
        
        _titleLB = [[UILabel alloc]init];
        _titleLB.font = kFont15;
        _titleLB.textColor = RGB(51, 51, 51);
        [self.contentView addSubview:_titleLB];
        [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.offset(15);
        }];
        
        UIView *line = [UIView new];
        line.backgroundColor = RGB(225, 225, 225);
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.offset(0);
            make.height.offset(0.8);
        }];
    }
    return self;
}
-(void)setIsSelectCell:(BOOL)isSelectCell{
    _isSelectCell = isSelectCell;
     selectImgView.backgroundColor = _isSelectCell?kAppThemeColor:BlueColor;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    selectImgView.backgroundColor = selected?kAppThemeColor:BlueColor;
}

@end
