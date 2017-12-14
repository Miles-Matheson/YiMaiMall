//
//  MKJRequestHelper.m
//  AutoLayoutShowTime
//
//  Created by MKJING on 16/8/19.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "MKJRequestHelper.h"
#import "shoppingCartModel.h"

@implementation MKJRequestHelper


static MKJRequestHelper *_requestHelper;

static id _requestHelp;

+ (instancetype)shareRequestHelper
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _requestHelp = [[self alloc] init];
    });
    return _requestHelp;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _requestHelp = [super allocWithZone:zone];
    });
    return _requestHelp;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _requestHelp;
}

- (NSAttributedString *)recombinePrice:(CGFloat)CNPrice orderPrice:(CGFloat)unitPrice
{
    NSMutableAttributedString *mutableAttributeStr = [[NSMutableAttributedString alloc] init];
    NSAttributedString *string1 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%.f",unitPrice] attributes:@{NSForegroundColorAttributeName : [UIColor redColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:12]}];
    NSAttributedString *string2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%.f",CNPrice] attributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:11],NSStrikethroughStyleAttributeName :@(NSUnderlineStyleSingle),NSStrikethroughColorAttributeName : [UIColor lightGrayColor]}];
    [mutableAttributeStr appendAttributedString:string1];
    [mutableAttributeStr appendAttributedString:string2];
    return mutableAttributeStr;
}

@end
