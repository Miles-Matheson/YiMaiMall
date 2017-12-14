//
//  UIBadgeView.h
//  ylb
//
//  Created by gravel on 16/3/15.
//  Copyright © 2016年 gravel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBadgeView : UIView
@property (nonatomic, copy) NSString *badgeValue;

+ (UIBadgeView *)viewWithBadgeTip:(NSString *)badgeValue;
+ (CGSize)badgeSizeWithStr:(NSString *)badgeValue font:(UIFont *)font;

- (CGSize)badgeSizeWithStr:(NSString *)badgeValue;
@end
