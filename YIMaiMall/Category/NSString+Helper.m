//
//  NSString+Helper.m
//  ylb
//
//  Created by gravel on 16/3/14.
//  Copyright © 2016年 gravel. All rights reserved.
//

#import "NSString+Helper.h"

@implementation NSString(Helper)

-(NSString*)globalLanguage{
    return NSLocalizedString(self, self);
}
@end
