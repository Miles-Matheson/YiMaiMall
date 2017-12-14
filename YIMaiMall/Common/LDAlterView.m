//
//  LDAlterView.m
//  FullAndFresh
//
//  Created by Miles on 2017/9/11.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDAlterView.h"

@interface  LDAlterView()
@property(nonatomic,retain)UIView *alterView;
@property(nonatomic,retain)UILabel *titleLb;
@property(nonatomic,retain)UILabel *contentLb;
@property(nonatomic,retain)UIButton *cancelBt;
@property(nonatomic,retain)UIButton *sureBt;

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *cancel;
@property(nonatomic,copy)NSString *sure;
@property (nonatomic,strong)UIView *baseView;

@end

@implementation LDAlterView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        ws(bself);
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
        
        _baseView = [UIView new];
        [self addSubview:_baseView];

        _baseView.backgroundColor = WhiteColor;
        _baseView.layer.masksToBounds = YES;
        _baseView.layer.cornerRadius = 10;

        UIImageView *imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:@"img_li"];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.centerY.equalTo(_baseView.mas_top);
        }];

        _titleLb = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"" textColor:RGB(45, 45, 45) textAlignment:Center font:kFont15];
        [_baseView addSubview:_titleLb];
        
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.equalTo(imageView.mas_bottom).offset(10);
            make.left.offset(SIZEFIT(20));
            make.right.offset(-SIZEFIT(20));
        }];

        //内容
        _contentLb = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"" textColor:RGB(116, 116, 116) textAlignment:Center font:kFont11];
        [_baseView addSubview:_contentLb];
        _contentLb.numberOfLines = 0;
        [_contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLb.mas_bottom).offset(9);
            make.left.offset(SIZEFIT(20));
            make.right.offset(-SIZEFIT(20));
        }];
        
        UIView *bottomHLine = [ViewCreate createLineFrame:CGRectMake(0, 0, 20, 0) backgroundColor:RGB(222, 222, 222)];
        [_baseView addSubview:bottomHLine];
        [bottomHLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(0.6);
            make.centerX.offset(0);
            make.bottom.offset(0);
            make.height.offset(SIZEFIT(40));
        }];
        
        UIView *bottomVLine = [ViewCreate createLineFrame:CGRectMake(0, 0, 20, 0) backgroundColor:RGB(222, 222, 222)];
        [_baseView addSubview:bottomVLine];
        
        [bottomVLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.height.offset(0.6);
            make.bottom.offset(-SIZEFIT(40));
        }];
        
        //取消按钮
        _cancelBt = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"" titleColor: RGB(75, 75, 75) font:kFont16 backgroundColor:WhiteColor touchUpInsideEvent:^(UIButton *sender) {
            [bself cancelBtClick];
        }];
        [_baseView addSubview:_cancelBt];
        [_cancelBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.offset(0);
            make.top.equalTo(bottomVLine.mas_bottom);
            make.right.equalTo(bottomHLine.mas_left);
        }];
        
        //确定按钮
        _sureBt = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"" titleColor:WhiteColor font:kFont16 backgroundColor:kAppThemeColor touchUpInsideEvent:^(UIButton *sender) {
            [bself sureBtClick];
        }];
        
        [_baseView addSubview:_sureBt];
        [_sureBt mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.bottom.offset(0);
            make.top.equalTo(bottomVLine.mas_bottom);
            make.left.equalTo(bottomHLine.mas_right);
        }];
        
        
        UIImage *image = [UIImage imageNamed:@"img_li"];
        
        CGFloat height1 = image.size.height/2.;
        
        CGFloat height2 = [LLUtils getStringSize:_titleLb.text font:15 width:SCREEN_WIDTH-SIZEFIT(195)].height +9;
        
        CGFloat height3 = [LLUtils getStringSize:_contentLb.text font:11 width:SCREEN_WIDTH-SIZEFIT(195)].height +SIZEFIT(20);
        
        if (height3<SIZEFIT(47)) {
            height3 = SIZEFIT(47);
        }
        
        CGFloat height4 = SIZEFIT(35);

        [UIView animateWithDuration:0.5 animations:^{
            
            [_baseView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.offset(0);
                make.centerY.offset(0);
                make.left.offset(SIZEFIT(70));
                make.right.offset(-SIZEFIT(70));
                make.height.offset(height1 +height2+height3+height4 +SIZEFIT(10));
            }];
            
        }];
    }
    return self;
}

#pragma mark----实现类方法
+(instancetype)alterViewWithTitle:(NSString *)title content:(NSString *)content cancel:(NSString *)cancel sure:(NSString *)sure cancelBtClcik:(cancelBlock)cancelBlock sureBtClcik:(sureBlock)sureBlock{
  
    LDAlterView *alterView=[[LDAlterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    alterView.title=title;
    alterView.content=content;
    
    if (cancel) {
         alterView.cancel=cancel;
    }else{
        [alterView.sureBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.offset(0);
            make.height.offset(SIZEFIT(40));
        }];
    }
    if (sure) {
         alterView.sure=sure;
    }
    if (cancelBlock) {
         alterView.cancel_block=cancelBlock;
    }
    if (sureBlock) {
         alterView.sure_block=sureBlock;
    }
    [KeyWindow addSubview:alterView];
    
    return alterView;
}
#pragma mark--给属性重新赋值
-(void)setTitle:(NSString *)title{
    
    _titleLb.text=title;
}
-(void)setContent:(NSString *)content{
    
    _contentLb.text=content;
}
-(void)setSure:(NSString *)sure{
    
    [_sureBt setTitle:sure forState:UIControlStateNormal];
}
-(void)setCancel:(NSString *)cancel{
    
    [_cancelBt setTitle:cancel forState:UIControlStateNormal];
}
#pragma mark----取消按钮点击事件
-(void)cancelBtClick{
    
    [_baseView removeFromSuperview];
    _baseView = nil;
    [self removeFromSuperview];
    if (self.cancel_block) {
        self.cancel_block();
    }
}
#pragma mark----确定按钮点击事件
-(void)sureBtClick{
    
    [_baseView removeFromSuperview];
    _baseView = nil;
    [self removeFromSuperview];
    if (self.sure_block) {
        self.sure_block();
    }
}

@end
