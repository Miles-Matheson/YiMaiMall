//
//  LDMineHeadView.h
//  StairOrder
//
//  Created by Miles on 2017/8/15.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDMineHeadView : UIView
@property (nonatomic,copy)void(^clickHeadBtnLogin)(void);
@property (nonatomic,copy)NSString *headImageUrl;
@property (nonatomic,copy)NSString *nameStr;
@property (nonatomic,copy)NSString *phoneStr;
@end
