//
//  LDCommitImageCell.m
//  StairOrder
//
//  Created by Miles on 2017/9/13.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDCommitImageCell.h"

@interface LDCommitImageCell ()

@property (nonatomic,strong)NSMutableArray *imageViewArray;


@end


@implementation LDCommitImageCell
{
    UIView *baseView;
    UIButton *addBtn;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = 0;
        
        _imageViewArray = [NSMutableArray array];
        [self initUI];
        
    }
    return self;
}
- (void)initUI
{
    ws(bself);
    
    UILabel *lab = [ViewCreate  createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"上传图片" textColor:BlackColor textAlignment:Left font:kFont16];
    [self.contentView addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(10);
    }];
    
    
    baseView =[UIView new];
    [self.contentView addSubview:baseView];
    [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.equalTo(lab.mas_bottom).offset(10);
    }];
    
    
    CGFloat width = (SCREEN_WIDTH-80)/4;
    
    addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setImage:[UIImage imageNamed:@"add"] forState:0];
    [addBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {

        if (_addImageCallBack) {
            _addImageCallBack(YES,0);
        }
    }];
    [baseView addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.width.height.offset(width);
        make.centerY.offset(0);
    }];
}

-(void)createImage
{
    NSInteger count = _imageViewArray.count;
    
    CGFloat width = (SCREEN_WIDTH-80)/4;
    
    UIImageView *imageView = [UIImageView new];
    [baseView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(count *(width +10)+10);
        make.centerY.offset(0);
        make.width.height.offset(width);
    }];

    imageView.tag = count;
    
    [_imageViewArray addObject:imageView];
    
    _uploadImgView = imageView;
    
    [self reloadAddBtn];

    imageView.userInteractionEnabled = YES;
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTapAction:)];
    longPress.minimumPressDuration = 0.8; //定义按的时间
    longPress.numberOfTouchesRequired = 1;
    [imageView addGestureRecognizer:longPress];
}

-(void)reloadAddBtn
{
    CGFloat width = (SCREEN_WIDTH-80)/4;
    
    NSInteger count =  _imageViewArray.count;
    addBtn.hidden = count ==4?YES:NO;
    
    [baseView layoutIfNeeded];

    [UIView animateWithDuration:1.0 animations:^{
        
        [addBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.offset( 10+(count) *(width +10));
            make.centerY.offset(0);
            make.width.height.offset(width);
            [baseView layoutIfNeeded];
        }];
    }];
}

//解决办法：
- (void) longTapAction:(UILongPressGestureRecognizer *)longPress {
    
    if (longPress.state == UIGestureRecognizerStateBegan) {
        
        ws(bself);
        [LLUtils showAlterView:[LLUtils getCurrentVC] title:@"提示" message:@"确定删除该图片?" yesBtnTitle:@"确定" noBtnTitle:@"取消" yesBlock:^{
            UIImageView *touchImageView = (UIImageView *)longPress.view;
            NSInteger tag = touchImageView.tag;
            
            
            [bself.imageViewArray removeObject:touchImageView];
            [touchImageView removeFromSuperview];
            touchImageView = nil;
            
            if (_addImageCallBack) {
                _addImageCallBack(NO,tag);
            }
            
            [bself reloadAddBtn];
            
            CGFloat width = (SCREEN_WIDTH-80)/4;
            
            for (UIImageView *imageView in bself.imageViewArray) {
                
                [imageView layoutIfNeeded];
                
                if (imageView.tag > tag) {

                    [baseView layoutIfNeeded];
                    
                    [UIView animateWithDuration:1.0f animations:^{
                        
                        [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                            make.left.offset( 10+(imageView.tag -1) *(width +10));
                            make.centerY.offset(0);
                            make.width.height.offset(width);
                        }];
                        
                        [baseView layoutIfNeeded];
                        
                    }];
                    
                    imageView.tag = imageView.tag -1;;
                }
            }
            
        } noBlock:^{
            
        }];
    }else {
        NSLog(@"long pressTap state :end");
    }
    
}

@end
