//
//  PswInputView.h
//  PayPasswordDemo
//
//  Created by Miles on 2017/8/30.
//  Copyright © 2017年 高磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PswInputViewDelegate <NSObject>

- (void)PswInputView:(id)inputView textFiled:(UITextField *)textfield;

@end



@interface PswInputView : UIView

- (void)cleanPassword;

@property (nonatomic,assign)id <PswInputViewDelegate> delegate;

@end
