//
//  SpecAddCountButtonCell.h
//  YIMaiMall
//
//  Created by Miles on 2017/12/12.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PPNumberButton/PPNumberButton.h>
@interface SpecAddCountButtonCell : UICollectionViewCell<PPNumberButtonDelegate>
@property (nonatomic, strong)PPNumberButton *addNumberBtn;
@property (nonatomic, assign)NSInteger maxCount;
@property (nonatomic, copy) void(^changeCountClick)(NSInteger currentCount);

@end
