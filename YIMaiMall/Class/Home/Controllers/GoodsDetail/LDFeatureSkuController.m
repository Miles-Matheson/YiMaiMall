//
//  LDFeatureSkuController.m
//  YIMaiMall
//
//  Created by Miles on 2017/12/6.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "LDFeatureSkuController.h"
#import "SpecWindowView.h"
#import "UIViewController+XWTransition.h"
@interface LDFeatureSkuController ()

@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, assign) BOOL isBuyNow;
@end

@implementation LDFeatureSkuController

-(instancetype)initWithSkuData:(NSDictionary *)dataDic isBuyNow:(BOOL)isBuyNow{
    if (self = [super init]) {
        _dataDic = dataDic;
        _isBuyNow = isBuyNow;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    KeyWindow.backgroundColor = BlackColor;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    KeyWindow.backgroundColor = WhiteColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ws(bself);
    XWInteractiveTransitionGestureDirection direction = XWInteractiveTransitionGestureDirectionDown;
    [self xw_registerBackInteractiveTransitionWithDirection:direction transitonBlock:^(CGPoint startPoint){
        [bself dismissViewControllerAnimated:YES completion:^{
            [bself dismissFeatureViewControllerWithTag:100];
        }];
    } edgeSpacing:0];
    
    SpecWindowView *  specWindowView= [[NSBundle mainBundle]loadNibNamed:@"SpecWindowView" owner:nil options:nil].firstObject;
    specWindowView.SKUdataSource = _dataDic;
    NSString *urlString = _dataDic[@"obj"][@"img"];
    [specWindowView.goodsImage sd_setImageWithURL:[NSURL URLWithString:urlString?urlString:@""] placeholderImage:[UIImage imageNamed:KplaceholderImage]];
    [self.view addSubview:specWindowView];
    specWindowView.CallBackWithCloseWindow = ^(NSString *type, NSString *skuIds, NSString *goodsID, NSInteger count, NSString *spec_info) {
    ////<(type:0取消，1确定，2立即购买)
        
        if ([type isEqualToString:@"1"]) {
            
            if (bself.isBuyNow) {

                NSDictionary *param = @{
                                        @"goods_spec_ids":skuIds?skuIds:@"",
                                        @"goods_id":goodsID?goodsID:@"",
                                        @"count":@(count),
                                        @"spec_info":spec_info?spec_info:@"",
                                        };
                
                [[APIManager sharedManager] goodsBuyNowWithData:param CallBack:^(id data) {
                    RC001;
                    if (bself.selectSkuCallBack) {
                        bself.selectSkuCallBack(spec_info);
                    }
                    
                } fail:^(NSString *errorString) {
                }];
                
            }else{
               
                [bself addGoodsToShopCartWithSkuIds:skuIds goodsIds:goodsID count:1 sizeInfo:spec_info CallBack:^(BOOL success, NSDictionary *data) {
                    RC001;
                    if (bself.selectSkuCallBack) {
                        bself.selectSkuCallBack(spec_info);
                    }
                    [bself dismissFeatureViewControllerWithTag:100];
                }];
                
            }

        }else if ([type isEqualToString:@"0"]){
            [bself dismissFeatureViewControllerWithTag:100];
        }
    };
    [specWindowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.bottom.offset(-SCREEN_HEIGHT*0.2);
    }];
}

#pragma mark - 退出当前界面
- (void)dismissFeatureViewControllerWithTag:(NSInteger)tag{

    [self dismissViewControllerAnimated:YES completion:^{

    }];
}

@end
