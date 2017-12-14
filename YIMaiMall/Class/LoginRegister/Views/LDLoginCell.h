//
//  LDLoginCell.h
//  FullAndFresh
//
//  Created by Miles on 2017/9/22.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDLoginCell : UITableViewCell
@property (nonatomic,strong)UITextField *phoneTextFild;
@property (nonatomic,strong)UITextField *pswTextFild;
@property (nonatomic,strong)UIButton *phoneBtn;
/*
 0 登录
 1 忘记密码
 2 去注册
 3 qq登录
 4 微信登录
 5 微博登录
 */
@property (nonatomic,copy)void(^loginItemClick)(NSInteger index,LDLoginCell *cell);

@end
