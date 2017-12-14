//
//  MyPersonalTableViewCell.h
//  BaseFrame
//
//  Created by 陈舟为 on 2017/6/23.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPersonalTableViewCell : UITableViewCell

@property(nonatomic,weak)UITextField *messageTF;

@property(nonatomic,weak)UIImageView *imgView;

@property(nonatomic,weak)UILabel *titLab;

@property(nonatomic,assign)BOOL showPhoto;

@property(nonatomic,assign)BOOL eneble;

@property(nonatomic,strong)UIColor *tfColor;

@end
