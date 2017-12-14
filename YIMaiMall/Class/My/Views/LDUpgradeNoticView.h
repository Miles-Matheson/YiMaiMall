//
//  LDUpgradeNoticView.h
//  YIMaiMall
//
//  Created by Miles on 2017/11/30.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDUpgradeNoticView : UIView
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (nonatomic, copy) void (^agreeItemClick)(void);
@end
