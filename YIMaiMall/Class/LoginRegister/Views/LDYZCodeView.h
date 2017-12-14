//
//  LDYZCodeView.h
//  FullAndFresh
//
//  Created by Miles on 2017/9/26.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>

//取消按钮点击事件
typedef void(^cancelBlock)();
//确定按钮点击事件
typedef void(^sureBlock)();

@interface LDYZCodeView : UIView

@property(nonatomic,strong)UIImage *codeImage;
@property(nonatomic,strong)UITextField *codeTextFiled;

@property(nonatomic,copy)void(^sureBlock)(NSString *code);
@property(nonatomic,copy)void(^selectImageCallBack)(void);
@end
