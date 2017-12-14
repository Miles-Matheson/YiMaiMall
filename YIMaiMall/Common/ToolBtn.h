//
//  ToolBtn.h
//  yt
//
//  Created by XH on 16/6/3.
//  Copyright © 2016年 PP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToolBtn : UIButton

- (void)configDataWithImageName:(NSString *)imageName title:(NSString *)title;

@property(nonatomic,copy)NSString *name;

@end
