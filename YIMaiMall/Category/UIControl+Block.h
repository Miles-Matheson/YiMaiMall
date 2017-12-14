//
//  UIControl+BlocksKit.h
//  BlocksKit
//

#import <UIKit/UIKit.h>

@interface UIControl (Block)

- (void)handleControlEvent:(UIControlEvents)controlEvents withBlock:(void (^)(id sender))handler;

@end
