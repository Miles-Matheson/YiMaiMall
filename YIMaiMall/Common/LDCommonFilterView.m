//
//  LDCommonFilterView.m
//  MerchantCenter
//
//  Created by kevin on 2017/2/24.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

#import "LDCommonFilterView.h"

@interface LDCommonFilterView ()

@property (nonatomic, strong) UIView *btnBgView;

@property (nonatomic, strong) NSArray *titles;       //标题
@property (nonatomic, strong) NSArray *isShowImgs;   //是否显示下拉图片
@property (nonatomic, strong) NSArray *interactions; //是否可以交互
@property (nonatomic, assign) NSArray *imgTitleIntervals;//图片文字间隔
@property (nonatomic, assign) NSArray *titleIntervals;//图片文字间隔

@property (nonatomic, assign) NSArray *normalImages;//普通状态图片
@property (nonatomic, assign) NSArray *selectImages;//选中状态图片
@end

@implementation LDCommonFilterView

- (id)initWithFrame:(CGRect)frame titles:(NSArray *)titles isShowImgs:(NSArray *)isShowImgs interactions:(NSArray *)interactions imgTitleIntervals:(NSArray *)imgTitleIntervals titleIntervals:(NSArray *)titleIntervals normalImages:(NSArray<NSString*>*)normalImages selectImages:(NSArray<NSString *>*)selectImages {
    
    if (self = [super initWithFrame:frame]) {
        _titles = titles;
        _isShowImgs = isShowImgs;
        _interactions = interactions;
        _imgTitleIntervals = imgTitleIntervals;
        _titleIntervals   = titleIntervals;
        _selectImages = selectImages;
        _normalImages = normalImages;
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    _btnBgView = [UIView new];
    [self addSubview:_btnBgView];
    _btnBgView.frame = self.bounds;
    CGRect frame = _btnBgView.frame;
    frame.origin.x -= 10;
    _btnBgView.frame = frame;
    
    UIView *lineView = [UIView new];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(0.5f);
    }];
    lineView.backgroundColor = kLineColor;
    
    int row = 1; //总行数
    int col = (int)_titles.count; //总列数
    
    CGFloat btnWidth = kScreenWidth /col;
    CGFloat btnHeight = CGRectGetHeight(_btnBgView.frame);
    
    if (isEmptyArr(_titles)) {
        return;
    }
    NSArray *btnNameArr = @[_titles
                            ];
    
    for (int i = 0; i < row; i++) {
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (int j = 0; j < col; j++) {
            
            LFButton *aBtn = [LFButton buttonWithType:UIButtonTypeCustom];
            [self.btnBgView addSubview:aBtn];
            
            aBtn.frame = CGRectMake(10+j*btnWidth, i*btnHeight, btnWidth, btnHeight);
            [aBtn setTitle:btnNameArr[i][j] forState:UIControlStateNormal];
            [aBtn setTitleColor:[UIColor colorWithWhite:50/255.0 alpha:1] forState:UIControlStateNormal];
            aBtn.titleLabel.font = [UIFont systemFontOfSize:FONTFIT(15)];
            aBtn.tag = i*col+j;
            
//            CGFloat interval = -10+(_titleIntervals?[_titleIntervals[i*col+j] floatValue]:0);
//            aBtn.titleEdgeInsets = UIEdgeInsetsMake(0,interval, 0, -interval);

            aBtn.userInteractionEnabled = _interactions?[_interactions[i*col+j] boolValue]:YES;
            [aBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            NSString *normalName = _normalImages[j];
            NSString *selectName = _selectImages[j];
            if (normalName) {
                [aBtn setImage:[UIImage imageNamed:normalName] forState:UIControlStateNormal];
            }
            if (selectName) {
                [aBtn setImage:[UIImage imageNamed:selectName] forState:UIControlStateSelected];
            }
            
            [array addObject:aBtn];
        }
        
        _showBtns = [[NSArray alloc]initWithArray:array];
    }
}

- (void)clickBtn:(LFButton *)btn{
    
    if (_lastSelBtn != btn && _lastSelBtn.selected) {
//        _lastSelBtn.selected = NO;
        [self rotateArrow:_lastSelBtn];
    }
    
    btn.selected = !btn.selected;
    _lastSelBtn = btn;
    
    [self rotateArrow:btn];
    
    if (_delegate && [_delegate respondsToSelector:@selector(LDCommonFilterView:clickBtn:)]) {
        [_delegate LDCommonFilterView:self clickBtn:btn];
    }
}

- (void)rotateArrow:(LFButton *)btn{
    

}
- (void)rotateArrow{//:(UIButton *)btn{
    

}
@end
