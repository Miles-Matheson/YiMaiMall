//
//  LDProductCollectionHeadView.h
//  FullAndFresh
//
//  Created by Miles on 2017/9/7.
//  Copyright © 2017年 Miles. All rights reserved.
//

typedef enum : NSUInteger {
    
    HeaderStyleTitleOnly = 0,
    HeaderStyleLineTitle,
    HeaderStyleTitleStatus,
}HeaderStyle;

#import <UIKit/UIKit.h>
#import "LFButton.h"

@interface LDProductCollectionHeadView : UICollectionReusableView

@property (nonatomic, assign) HeaderStyle HeaderStyle;
@property (nonatomic,strong)LFButton *titleBtn;
@property (nonatomic,copy)void(^moreItemClick)(void);
@property (nonatomic,copy)void(^titleClick)(void);
@end
