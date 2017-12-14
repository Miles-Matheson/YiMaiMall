//
//  TagViewCell.m
//  SQButtonTagView
//
//  Created by yangsq on 2017/9/26.
//  Copyright © 2017年 yangsq. All rights reserved.
//

#import "TagViewCell.h"
#import "SQButtonTagView.h"

#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface TagViewCell ()

@property (nonatomic, strong) SQButtonTagView *tagView;
@end


@implementation TagViewCell

- (void)dealloc{
    _tagView = nil;
}

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.contentView.backgroundColor = RGB(255, 255, 255);
        ws(bself);
        _tagView = [[SQButtonTagView alloc]initWithTotalTagsNum:30
                                                      viewWidth:ScreenWidth-20
                                                        eachNum:0
                                                        Hmargin:20
                                                        Vmargin:20
                                                      tagHeight:30
                                                    tagTextFont:[UIFont systemFontOfSize:13.f]
                                                   tagTextColor:RGB(51, 51, 51)
                                           selectedTagTextColor:[UIColor whiteColor]
                                        selectedBackgroundColor:kAppThemeColor];
        _tagView.maxSelectNum = 1;
        _tagView.isRadio = YES  ;
        _tagView.backgroundColor = RGB(255, 255, 255);
        [self.contentView addSubview:_tagView];
        
        [_tagView selectAction:^(SQButtonTagView * _Nonnull tagView, NSArray * _Nonnull selectArray) {
            NSLog(@"selectArray ======  %@",selectArray);
            if (selectArray.count) {
                NSString *indesString = [NSString stringWithFormat:@"%@",selectArray.firstObject];
                if (bself.itemSelectCallBack) {
                    bself.itemSelectCallBack(@[indesString]);
                }
            }
        }];
        
        _tagView.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:_tagView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:10];
        
        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:_tagView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:10];
        
        
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:_tagView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:-10];
        
        NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:_tagView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:-10];
        
        [self.contentView addConstraints:@[top,left,bottom,right]];
    }
    return self;
}

- (void)setTextArray:(NSArray *)textArray row:(NSInteger)row{
    if (row%2==0) {
        _tagView.eachNum = 0;
    }else{
        _tagView.eachNum = 3;
    }
    _tagView.tagTexts = textArray;
}


+ (CGFloat)cellHeightTextArray:(NSArray *)textArray Row:(NSInteger)row{
    CGFloat height;
    NSInteger eachNum;
    if (row%2==0) {
        eachNum = 0;
    }else{
        eachNum = 3;
    }
    
    height = [SQButtonTagView returnViewHeightWithTagTexts:textArray
                                                 viewWidth:ScreenWidth-20
                                                   eachNum:eachNum
                                                   Hmargin:10
                                                   Vmargin:10
                                                 tagHeight:30
                                               tagTextFont:[UIFont systemFontOfSize:14.f]];
    return height+20;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
@end
