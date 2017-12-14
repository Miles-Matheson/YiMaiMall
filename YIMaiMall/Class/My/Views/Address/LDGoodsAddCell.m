//
//  LDGoodsAddCell.m
//  BaseFrame
//
//  Created by Miles on 2017/6/23.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import "LDGoodsAddCell.h"
#import "AmotButton.h"

@interface LDGoodsAddCell ()

@property(nonatomic,strong)UILabel * name,* mobile,* defaultAddress,* address;
@property(nonatomic,strong)UIButton * selectButton;
@property(nonatomic,strong)AmotButton * bianji,* shanchu;
@property (nonatomic,strong)UIView * lineView;
@property (nonatomic,strong)UILabel * setDefultLab;

@end

@implementation LDGoodsAddCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    ws(bself);

    if (!_name) {
        _name=[[UILabel alloc]init];
        _name.textColor = RGB(46, 46, 46);
        _name.font = [MyAdapter lfontADapter:16];
        [self.contentView addSubview:_name];
        
        [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            
             make.top.equalTo(bself.contentView.mas_top).offset(10);
             make.left.offset([MyAdapter laDapter:15]);
             make.height.offset(20);

        }];
    }

    if (!_mobile) {
        _mobile=[[UILabel alloc]init];
        _mobile.textColor = RGB(46, 46, 46);
        _mobile.font = [MyAdapter lfontADapter:16];
        [self.contentView addSubview:_mobile];
        
        [_mobile mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bself.name);
            make.left.equalTo(bself.name.mas_right).offset([MyAdapter laDapter:15]);
            make.height.equalTo(bself.name.mas_height);
            
        }];
    }

    
    if (!_defaultAddress) {
        _defaultAddress=[[UILabel alloc]init];
        _defaultAddress.textColor = RGB(255,169,39);
        _defaultAddress.text = @"默认地址";
        _defaultAddress.font = [MyAdapter lfontADapter:16];
        [self.contentView addSubview:_defaultAddress];
        
        [_defaultAddress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset([MyAdapter laDapter:10]);
            make.right.offset([MyAdapter laDapter:-15]);
        }];
    }
    
    
    if (!_address) {
        _address=[[UILabel alloc]init];
        _address.textColor = RGB(135,135,135);
        _address.font = [MyAdapter lfontADapter:16];
        _address.numberOfLines = 0;
        [self.contentView addSubview:_address];
        
        [_address mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bself.name.mas_bottom).offset(0);
            make.left.offset([MyAdapter laDapter:15]);
            make.width.offset(SCREEN_WIDTH-[MyAdapter laDapter:30]);
            make.bottom.equalTo(bself.contentView.mas_bottom).offset(-[MyAdapter laDapter:100/2.]);
        }];
    }
    
    _lineView=[[UIView alloc]init];
    _lineView.backgroundColor=RGB(213, 213, 213);
    [self.contentView addSubview:_lineView];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bself.address.mas_bottom).offset(0);
        make.left.right.offset([MyAdapter laDapter:0]);
        make.height.offset(0.5);
    }];
    
    
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton addTarget:self action:@selector(selectAddress:) forControlEvents:UIControlEventTouchUpInside];
        [_selectButton setImage:[UIImage imageNamed:@"step_icon_n"] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"step_icon_s"] forState:UIControlStateSelected];
        [self.contentView addSubview:_selectButton];
        [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset([MyAdapter laDapter:15]);
            make.top.equalTo(bself.lineView.mas_bottom).offset([MyAdapter laDapter:15]);
            make.width.height.offset([MyAdapter laDapter:20]);
        }];
    }
    
    
    
    if (!_setDefultLab) {
        _setDefultLab = [[UILabel alloc]init];
        _setDefultLab.text = @"设为默认地址";
        _setDefultLab.textColor = RGB(135, 135, 135);
        _setDefultLab.font = [MyAdapter lfontADapter:16];
        _setDefultLab.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappp)];
        [_setDefultLab addGestureRecognizer:tap];
        [self.contentView addSubview:_setDefultLab];
        
        [_setDefultLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bself.selectButton.mas_right).offset([MyAdapter laDapter:10]);
            make.centerY.equalTo(bself.selectButton);
        }];
    }
    

    if (!_shanchu) {
        _shanchu = [[AmotButton alloc]init];
//        [_shanchu doBorderWidth:0.5 color:RGB(163, 163, 163) cornerRadius:[MyAdapter laDapter:2]];
        [_shanchu addTarget:self action:@selector(shanchuClick) forControlEvents:UIControlEventTouchUpInside];
        [_shanchu setTitleColor:RGB(58, 58, 58) forState:UIControlStateNormal];
        [_shanchu setImage:[UIImage imageNamed:@"icon_delete"] forState:UIControlStateNormal];
        [_shanchu setTitle:@"删除" forState:UIControlStateNormal];
        _shanchu.titleLabel.font = [MyAdapter lfontADapter:15];
        [self.contentView addSubview:_shanchu];
        
        [_shanchu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset([MyAdapter laDapter:-15]);
            make.centerY.equalTo(bself.setDefultLab);
            make.width.offset([MyAdapter laDapter:80]);
            make.height.offset([MyAdapter laDapter:30]);
        }];
    }
    
    if (!_bianji) {

        _bianji = [[AmotButton alloc]init];
//        [_bianji doBorderWidth:0.5 color:RGB(163, 163, 163) cornerRadius:[MyAdapter laDapter:2]];
        [_bianji addTarget:self action:@selector(bianjiClick) forControlEvents:UIControlEventTouchUpInside];
        [_bianji setTitleColor:RGB(58, 58, 58) forState:UIControlStateNormal];
        [_bianji setImage:[UIImage imageNamed:@"icon_exit"] forState:UIControlStateNormal];
        [_bianji setTitle:@"编辑" forState:UIControlStateNormal];
        _bianji.titleLabel.font = [MyAdapter lfontADapter:15];
        [self.contentView addSubview:_bianji];
        [_bianji mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(bself.shanchu.mas_left).offset([MyAdapter laDapter:-15]);
            make.centerY.equalTo(bself.setDefultLab);
            make.width.offset([MyAdapter laDapter:80]);
            make.height.offset([MyAdapter laDapter:30]);
        }];
    }
}


- (void)tappp
{
    if (_model.isDefault) {
        return;
    }
    if (self.adderssBlock) {
        self.adderssBlock(_model);
    }
}

-(void)shanchuClick{
    if (self.shanchuBlock) {
        self.shanchuBlock(_model);
    }
}
-(void)bianjiClick{
    if (self.bianjiBlock) {
        self.bianjiBlock(_model);
    }
}
-(void)selectAddress:(UIButton *)button{
    if (button.selected) {
        return;
    }
    if (self.adderssBlock) {
        self.adderssBlock(_model);
    }
}

-(void)setModel:(LDAddressListModel *)model
{
    _model=model;
    
    _defaultAddress.textColor = _model.isDefault?kAppThemeColor:RGB(158, 158, 158);
    
    self.name.text = _model.truename;
    
    self.mobile.text = _model.mobile;
    
    self.address.text = _model.areaInfo;
    
    self.selectButton.selected = _model.isDefault;
    
    self.name.top = 10;
}

+ (LDGoodsAddCell *)shareInstance{
    static LDGoodsAddCell *cellInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        cellInstance = [[self alloc]init];
    });
    return cellInstance;
}

@end
