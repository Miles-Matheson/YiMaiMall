//
//  LDSendInfoCell.m
//  BaseFrame
//
//  Created by Miles on 2017/6/23.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import "LDSendInfoCell.h"

@implementation LDSendInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self initUI];
    }
    
    return self;
}

- (void)initUI
{
    ws(bself);
    _sendBtn = [ViewCreate  createButtonFrame:CGRectMake(22,SIZEFIT(10), SCREEN_WIDTH-44, SIZEFIT(50)) title:@"确定" titleColor:WhiteColor font:kFont17 backgroundColor:kAppThemeColor touchUpInsideEvent:^(UIButton *sender) {
        if (bself.sendBtnClick) {
            bself.sendBtnClick();
        }
    }];
    
//    _sendBtn.userInteractionEnabled   = NO;
    _sendBtn.layer.masksToBounds = YES;
    _sendBtn.layer.cornerRadius = SIZEFIT(25);
    [self.contentView addSubview:_sendBtn];
    
    [_sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(SIZEFIT(35/2.));
        make.width.mas_equalTo(SCREEN_WIDTH -SIZEFIT(35));
        make.height.mas_equalTo(SIZEFIT(50));
    }];
    
}
@end
