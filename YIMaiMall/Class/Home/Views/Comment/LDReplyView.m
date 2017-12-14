//
//  LDReplyView.m
//  BaseFrame
//
//  Created by Miles on 2017/7/3.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import "LDReplyView.h"

@interface LDReplyView ()

@property (nonatomic, strong) UIImageView *bgImageView;
@property(nonatomic,strong)UILabel *commentLab;

@end

@implementation LDReplyView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    ws(bself);
    
    _bgImageView = [UIImageView new];
    
    UIImage *bgImage = [[[UIImage imageNamed:@"LikeCmtBg"] stretchableImageWithLeftCapWidth:40 topCapHeight:30] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    _bgImageView.image = bgImage;
    _bgImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:_bgImageView];
    
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.top.offset(0);
        make.bottom.equalTo(bself.mas_bottom);
    }];

    _commentLab = [UILabel new];
    _commentLab.font = [UIFont systemFontOfSize:13];
    _commentLab.numberOfLines = 0;
    _commentLab.hidden = NO;
    [self addSubview:_commentLab];
    
    [_commentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZEFIT(8));
        make.right.offset(-SIZEFIT(5));
        make.top.offset(SIZEFIT(10));
        make.bottom.equalTo(bself.mas_bottom).offset(-SIZEFIT(5));
    }];
}

- (void)setReply:(NSString *)reply
{
    _reply = reply;

    if (_reply.length == 0){
        
        _commentLab.hidden = YES;
        
        self.height = 0;
        self.width = 0;
        
        return;
    }else{
    _commentLab.attributedText = [self generateAttributedStringWithString:[LLUtils strNilOrEmpty:_reply elseBack:@""]];
    }
}


#pragma mark - private actions

- (NSMutableAttributedString *)generateAttributedStringWithString:(NSString *)string {
    
    NSString *text;
    
    if (string.length > 0) {
        
        text = @"商家回复";
        text = [text stringByAppendingString:[NSString stringWithFormat:@"：%@", string]];
        
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
        
        UIColor *highLightColor = RGB(247, 81, 43);
        
        [attString setAttributes:@{NSForegroundColorAttributeName : highLightColor,} range:[text rangeOfString:@"商家回复"]];
        return attString;
        
    }else{
        return nil;
    }
}


@end
