//
//  LDCommentCell.m
//  BaseFrame
//
//  Created by Miles on 2017/7/3.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import "LDCommentCell.h"
#import "LDStarView.h"
#import "LDCommentImageView.h"
#import "LDReplyView.h"

@interface LDCommentCell ()

@property (nonatomic,strong)UIImageView *iconView;
@property (nonatomic,strong)UILabel *nameLable;
@property (nonatomic,strong)LDStarView *starView;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)LDCommentImageView *replyImgView;
@property (nonatomic,strong)LDReplyView *replyView;

@end

@implementation LDCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = 0;
        [self initUI];
        
    }
    return self;
}
- (void)initUI
{
    ws(bself);
    _iconView = [UIImageView new];
    _iconView.layer.masksToBounds = YES;
    _iconView.layer.cornerRadius = SIZEFIT(20);
    [self.contentView addSubview:_iconView];
    
    _starView = [[LDStarView alloc]initWithFrame:CGRectMake(SIZEFIT(40) +20 , 0, 100, 20)];
    _starView.bottom = SIZEFIT(40) +15;
    [self.contentView addSubview:_starView];
    
    _nameLable = [UILabel new];
    _nameLable.font = [UIFont systemFontOfSize:12];
    _nameLable.textColor =RGB(50, 50, 50); 
    [self.contentView addSubview:_nameLable];

    _contentLabel = [UILabel new];
    _contentLabel.font = [UIFont systemFontOfSize:13];
    _contentLabel.numberOfLines = 0;
    _contentLabel.textColor = RGB(110, 110, 110);

    [self.contentView addSubview:_contentLabel];
    
    
    _replyImgView = [LDCommentImageView new];
    [self.contentView addSubview:_replyImgView];
    
    _replyView = [LDReplyView new];
    [self.contentView addSubview:_replyView];

    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZEFIT(15));
        make.top.offset(SIZEFIT(15));
        make.height.offset(SIZEFIT(40));
        make.width.offset(SIZEFIT(40));
    }];
    
    [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bself.iconView.mas_right).offset(8);
        make.right.offset(0);
        make.top.equalTo(bself.iconView.mas_top);
        make.height.offset(SIZEFIT(18));
    }];

    [_starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bself.iconView.mas_right).offset(8);
        make.bottom.equalTo(bself.iconView.mas_bottom);
        make.height.offset(SIZEFIT(20));
        make.width.offset(SIZEFIT(100));
    }];

    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLable.mas_left);
        make.right.offset(-SIZEFIT(15));
        make.top.equalTo(bself.iconView.mas_bottom).offset(SIZEFIT(10));
    }];

    [_replyImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLable.mas_left);
        make.right.offset(-SIZEFIT(15));
        make.top.equalTo(bself.contentLabel.mas_bottom).offset(SIZEFIT(10));
    }];
    
    [_replyView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(bself.replyImgView.mas_bottom);
        make.left.equalTo(bself.contentLabel.mas_left);
        make.right.offset(-SIZEFIT(10));
    }];
}

- (void)setModel:(LDCommentModel *)model
{
    _model = model;
    
    ws(bself);
    
     [_iconView sd_setImageWithURL:[NSURL URLWithString:model.headimgurl] placeholderImage:[UIImage imageNamed:KplaceholderImage]];
    
    _nameLable.text = model.userName;
    
     _starView.starCount = _model.evaluateBuyerVal;
    _contentLabel.attributedText = [LLUtils setLineSpacing:3 string:model.evaluateInfo];
    
    if (model.Reply.length != 0) {
        _replyView.reply = model.Reply;
    }else{
        _replyView.height = 0;
    }
    
    if (_model.imgs.count == 0 ) {
        
        _replyImgView.hidden = YES;
        
    }else{
         _replyImgView.hidden = NO;
         _replyImgView.contentImgs =_model.imgs;
        
        _replyImgView.backgroundColor = RedColor;
        [_replyImgView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(bself.contentLabel.mas_bottom).offset(SIZEFIT(10));
            
            CGFloat cha = 0;
            CGFloat height = 0;
            
            if (_model.imgs.count == 1) {
                height =   (SCREEN_WIDTH-68)/2.;
            }else if (_model.imgs.count > 1){
                height =   (SCREEN_WIDTH-68)/3.;
            }
            if (_model.imgs.count>3) {
                cha = 10;
            }
            
            int indexRow = _model.imgs.count/3;
            CGFloat bottom = indexRow*(height+cha);
            make.height.offset(bottom);

        }];
    }
    
    if (_model.Reply.length == 0) {
        _replyView.hidden = YES;
    }else{
        [_replyView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(bself.replyImgView.mas_bottom);
//            商家回复
            NSString *str = [NSString stringWithFormat:@"商家回复: %@",bself.model.Reply];
            CGSize size =   [LLUtils getStringSize:str font:13 width:SCREEN_WIDTH-SIZEFIT(60)-8];
            make.height.offset(size.height +25);
        }];
    }
}


@end
