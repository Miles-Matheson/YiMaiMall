//
//  LDSubbranchSelView.m
//  MerchantCenter
//
//  Created by kevin on 2017/2/22.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

#define kSubbranchTag 1122

#import "LDSubbranchSelView.h"

@interface LDSubbranchSelView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, assign) CGRect tableFrame;

@property (nonatomic, strong) NSArray <NSDictionary *> *dataSource;

@end

@implementation LDSubbranchSelView


+ (void)showInView:(UIView *)superView frame:(CGRect)frame SubbranchStatus:(SubbranchStatus)satus delegate:(id)delegate dataSource:(NSArray <NSDictionary *> *)dataSource object:(id)object lastSelIndex:(NSInteger)lastSelIndex{
    
    [LDSubbranchSelView dismissFromView:superView];
    LDSubbranchSelView *view = [[LDSubbranchSelView alloc] initWithFrame:frame dataSource:dataSource];
    
    [superView addSubview:view];
    view.object = object;
    view.delegate = delegate;
    view.lastSelIndex = lastSelIndex;
    view.subbranchStatus   = satus;
}

- (id)initWithFrame:(CGRect)frame dataSource:(NSArray <NSDictionary *> *)dataSource{
    if (self = [super initWithFrame:CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame), kScreenHeight-CGRectGetMinY(frame))]) {
        self.tag = kSubbranchTag;
        _tableFrame = frame;
        _dataSource = dataSource;
        [self setUI];
    }
    return self;
}

- (void)setUI{
    self.layer.masksToBounds = YES;

    _coverView = [UIView new];
    [self addSubview:_coverView];
    _coverView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));

    }];
    [_coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCoverView)]];
    _coverView.alpha = 0;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.tableFooterView = [UIView new];
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(-CGRectGetHeight(self.tableFrame));
        make.left.right.offset(0);
        make.height.offset(CGRectGetHeight(self.tableFrame));
    }];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];

//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:5.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _coverView.alpha = 1;
        _tableView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(self.tableFrame));
    } completion:nil];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section   {
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSDictionary *dic  =  _dataSource[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.font = Font14;
    
    if (_subbranchStatus == SubbranchStatusDefulat) {
        
        cell.accessoryType = _lastSelIndex == indexPath.row ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
        
        cell.textLabel.text = dic[@"Name"];
        
    }else if (_subbranchStatus == SubbranchStatusImageAndLeft){//有图标显示 且字体颜色跟着改变

        cell.textLabel.textColor = _lastSelIndex == indexPath.row ? RGB(57, 136, 251):BlackColor;
        cell.textLabel.text = dic[@"Name"];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"ICON"]] placeholderImage:[UIImage imageNamed:KplaceholderImage]];
        cell.separatorInset = UIEdgeInsetsMake(-50, 0, 0, 0);

        cell.imageView.image =  [LLUtils OriginImage:cell.imageView.image scaleToSize:CGSizeMake(30, 30)];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    _lastSelIndex = indexPath.row;
    if (_delegate && [_delegate respondsToSelector:@selector(LDSubbranchSelView:selectedIndex:)]) {
        [_delegate LDSubbranchSelView:self selectedIndex:indexPath.row];
    }
}

- (void)tapCoverView{
    [LDSubbranchSelView dismissFromView:self.superview];
}

+ (void)dismissFromView:(UIView *)superView{
    LDSubbranchSelView *view = [superView viewWithTag:kSubbranchTag];
    if(view){
        if (view.delegate && [view.delegate respondsToSelector:@selector(LDSubbranchSelViewDismiss:)]) {
            [view.delegate LDSubbranchSelViewDismiss:view];
        }
        view.tag = 0; //复位view tag
        [UIView animateWithDuration:0.5 animations:^{
            view.tableView.transform = CGAffineTransformIdentity;
            view.coverView.alpha = 0;
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
