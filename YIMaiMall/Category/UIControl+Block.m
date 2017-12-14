//
//  UIControl+BlocksKit.m
//  BlocksKit
//

#import "UIControl+Block.h"
#import "BlocksKit+UIKit.h"

@implementation UIControl (Block)

- (void)handleControlEvent:(UIControlEvents)controlEvents withBlock:(void (^)(id sender))handler
{
    [self bk_addEventHandler:handler forControlEvents:controlEvents];
}

@end
