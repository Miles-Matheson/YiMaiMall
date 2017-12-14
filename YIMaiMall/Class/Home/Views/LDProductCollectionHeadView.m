//
//  LDProductCollectionHeadView.m
//  FullAndFresh
//
//  Created by Miles on 2017/9/7.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDProductCollectionHeadView.h"


@interface LDProductCollectionHeadView ()
{
    UIView *lineH;
    UIView *bottomLine;
}
@property (nonatomic, strong) LFButton *moreeBtn;
@end

@implementation LDProductCollectionHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initUI];
        self.backgroundColor = WhiteColor;
    }
    return self;
}

-(void)initUI{
    
    ws(bself);
    
    lineH = [UIView new];
    [self addSubview:lineH];
    lineH.backgroundColor = kAppThemeColor;
    [lineH mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.width.offset(2);
        make.height.offset(15);
        make.centerY.offset(0);
    }];
    
    bottomLine = [UIView new];
    [self addSubview:bottomLine];
    bottomLine.backgroundColor = RGB(225, 225, 225);
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.offset(0.5);
    }];
    
    
    _titleBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"" titleColor:RGB(51, 51, 51) font:kFont16 backgroundColor:WhiteColor touchUpInsideEvent:^(UIButton *sender) {
        if (bself.titleClick) {
            bself.titleClick();
        }
    }];
    
    [self addSubview:_titleBtn];
    [_titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.offset(0);
        make.left.equalTo(lineH.mas_right).offset(5);
    }];
    
    _moreeBtn = [LFButton buttonWithType:UIButtonTypeCustom];
    _moreeBtn.titleLabel.font = kFont13;
    [_moreeBtn setTitleColor:RGB(153, 153, 153) forState:0];
    [self addSubview:_moreeBtn];
    [_moreeBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
        if (bself.moreItemClick) {
            bself.moreItemClick();
        }
    }];
    [_moreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.offset(0);
    }];
}

-(void)setHeaderStyle:(HeaderStyle)HeaderStyle{
    
    _HeaderStyle = HeaderStyle;
    
    if (_HeaderStyle == HeaderStyleTitleOnly) {
        bottomLine.hidden = _moreeBtn.hidden = lineH.hidden = YES;
        _titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _titleBtn.userInteractionEnabled = NO;
    }else if (_HeaderStyle == HeaderStyleLineTitle){
        bottomLine.hidden = _moreeBtn.hidden = lineH.hidden = NO;
        [_moreeBtn setImage:[UIImage imageNamed:@"arrow_2"] forState:0];
        [_moreeBtn setTitle:@"更多" forState:0];
        _titleBtn.userInteractionEnabled = NO;
        _titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }else if (_HeaderStyle  == HeaderStyleTitleStatus){
        bottomLine.hidden = _moreeBtn.hidden = lineH.hidden = NO;
        [_titleBtn setImage:[UIImage imageNamed:@"arrow_2"] forState:0];
        _titleBtn.userInteractionEnabled = YES;
        _titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
}

@end
