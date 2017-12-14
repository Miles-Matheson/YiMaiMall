//
//  LDRegisterCell.h
//  FullAndFresh
//
//  Created by Miles on 2017/9/26.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDRegisterCell : UITableViewCell


@property (nonatomic,strong) UITextField *yaoQingCodeTextFild;
@property (nonatomic,strong) UITextField *phoneTextFild;
@property (nonatomic,strong) UITextField *ZFcodeTextFild;
@property (nonatomic,strong) UITextField *pswTextFild;
@property (nonatomic,strong) UITextField *rePswTextFild;


/*
 0 获取验证码
 1 注册
 2 用户协议
 */
@property (nonatomic,copy)void(^registerItemClick)(NSInteger index,LDRegisterCell *cell);

- (void)timeDown:(NSInteger)timeNum;
@end
