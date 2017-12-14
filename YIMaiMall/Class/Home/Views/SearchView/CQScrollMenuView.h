//
//  CQScrollMenuView.h
//  flApp
//
//  Created by XP on 2017/10/30.
//  Copyright © 2017年 -SZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CQScrollMenuView;
@protocol CQScrollMenuViewDelegate /**
                                    菜单按钮点击时回调
                                    
                                    @param scrollMenuView 带单view
                                    @param index 所点按钮的index
                                    */
- (void)scrollMenuView:(CQScrollMenuView *)scrollMenuView clickItemAtIndex:(NSInteger)index;

@end

@interface CQScrollMenuView : UIScrollView
@property (nonatomic,weak) id  menuButtonClickedDelegate;
/** 菜单标题数组 */
@property (nonatomic,strong) NSArray *titleArray;
/** 当前选择的按钮的index */
@property (nonatomic,assign) NSInteger currentButtonIndex;
@end
