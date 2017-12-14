//
//  LDErrorInfo.h
//  StairOrder
//
//  Created by Miles on 2017/8/23.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDErrorInfo : NSObject

+ (NSString*)getErrorInfo:(NSError *)error;

@end
