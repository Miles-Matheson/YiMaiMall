//
//  LDChooseExpressView.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/21.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDChooseExpressView.h"
#import "LDChooseExpressCell.h"
@interface LDChooseExpressView()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation LDChooseExpressView
{
    UITableView *aTableView;

}

+(LDChooseExpressView*)showInSubView:(UIViewController *)controller Frame:(CGRect)rect dataSource:(NSArray*)dataSource {
    
    LDChooseExpressView *expressView = [[LDChooseExpressView alloc]initWithFrame:KeyWindow.bounds];
    [controller.view addSubview:expressView];
    expressView.dataSource = dataSource;
    expressView.delegate = controller;
    return expressView;
}

-(void)tapClick:(UITapGestureRecognizer *)tap{

    [self removeFromSuperview];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        ws(bself);
        UIView *bgView = [[UIView alloc]init];
        bgView.backgroundColor = WhiteColor;
        bgView.userInteractionEnabled = YES;
        [self addSubview:bgView];
        
        bgView.frame = CGRectMake(0,frame.size.height/2., frame.size.width,frame.size.height/2.);
        
        [UIView animateWithDuration:0.5 animations:^{
            
            [bgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_centerY);
                make.left.right.bottom.offset(0);
            }];
             [self layoutIfNeeded];
        }];
        
        _titleLB = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"配送方式" textColor:BlackColor textAlignment:Center font:kFont15];
        [bgView addSubview:_titleLB];
        [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.offset(0);
            make.height.offset(50);
        }];
        
        aTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,0, 0)style:UITableViewStyleGrouped];
        aTableView.delegate = self;
        aTableView.dataSource = self;
        aTableView.tableFooterView = [UIView new];
        aTableView.sectionFooterHeight = CGFLOAT_MIN;
        aTableView.sectionHeaderHeight = CGFLOAT_MIN;
        aTableView.backgroundColor = WhiteColor;
        [bgView addSubview:aTableView];
        [self registerCustomCell];
        [aTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLB.mas_bottom);
            make.left.right.offset(0);
            make.bottom.offset(-50);
        }];
        
        UIButton *closeBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"关闭" titleColor:WhiteColor font:kFont15 backgroundColor:kAppThemeColor touchUpInsideEvent:^(UIButton *sender) {
            [bself removeFromSuperview];
        }];
        [bgView addSubview:closeBtn];
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.offset(0);
            make.height.offset(50);
        }];
        
        UIView *shadowView = [UIView new];
        [self addSubview:shadowView];
        shadowView.backgroundColor =  [UIColor colorWithWhite:0.8 alpha:0.3];
        [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.top.offset(0);
            make.bottom.equalTo(bgView.mas_top);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [shadowView addGestureRecognizer:tap];
        
        [self registerCustomCell];
    }
    return self;
}

- (void)registerCustomCell
{
    [aTableView registerClass:[LDChooseExpressCell class] forCellReuseIdentifier:@"LDChooseExpressCell"];
}


#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDChooseExpressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDChooseExpressCell"];
    cell.titleLB.text = [NSString stringWithFormat:@"====%ld",indexPath.section];
    if (_selectIndex && (indexPath.row ==_selectIndex) ) {
        cell.isSelectCell = YES;
    }
    return [UITableViewCell new];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([_delegate respondsToSelector:@selector(expressViewShow:SelectIndex:)]) {
        [_delegate expressViewShow:self SelectIndex:indexPath.row];
        [self removeFromSuperview];
    }
}
@end
