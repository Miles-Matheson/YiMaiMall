//
//  LDAlterView.h
//  FullAndFresh
//
//  Created by Miles on 2017/9/11.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>

//取消按钮点击事件
typedef void(^cancelBlock)();

//确定按钮点击事件
typedef void(^sureBlock)();

@interface LDAlterView : UIView

@property(nonatomic,copy)cancelBlock cancel_block;
@property(nonatomic,copy)sureBlock sure_block;
/**
 *  @param title       标题
 *  @param content     内容
 *  @param cancel      取消按钮内容
 *  @param sure        确定按钮内容
 *  @param cancelBlock 取消按钮点击事件
 *  @param sureBlock   确定按钮点击事件
 *
 *  @return SZKAlterView
 */
+(instancetype)alterViewWithTitle:(NSString *)title
                          content:(NSString *)content
                           cancel:(NSString *)cancel
                             sure:(NSString *)sure
                    cancelBtClcik:(cancelBlock)cancelBlock
                      sureBtClcik:(sureBlock)sureBlock;

@end

