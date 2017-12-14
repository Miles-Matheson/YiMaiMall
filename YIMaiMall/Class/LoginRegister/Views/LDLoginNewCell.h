//
//  LGLoginNewCell.h
//  YIMaiMall
//
//  Created by Miles on 2017/12/7.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDLoginNewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *chooseCountryButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *pswTF;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

/*
 0 登录
 1 忘记密码
 2 去注册
 3 qq登录
 4 微信登录
 5 微
 6 获取国家地区
 */
@property (nonatomic,copy)void(^loginItemClick)(NSInteger index,LDLoginNewCell *cell);

@end
