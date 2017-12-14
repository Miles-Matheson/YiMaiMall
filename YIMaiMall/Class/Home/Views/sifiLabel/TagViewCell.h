//
//  TagViewCell.h
//  SQButtonTagView
//
//  Created by yangsq on 2017/9/26.
//  Copyright © 2017年 yangsq. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface TagViewCell : UICollectionViewCell

@property (nonatomic,strong)void(^itemSelectCallBack)(NSArray *selectArray);

- (void)setTextArray:(NSArray *)textArray row:(NSInteger)row;

+ (CGFloat)cellHeightTextArray:(NSArray *)textArray Row:(NSInteger)row;

@end
