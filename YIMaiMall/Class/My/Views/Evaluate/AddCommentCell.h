//
//  AddCommentCell.h
//  StairOrder
//
//  Created by Miles on 2017/9/13.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrdersModel.h"
@interface AddCommentCell : UITableViewCell

@property (nonatomic,strong)OrdersDetailModel *model;
@property (nonatomic,copy)void(^startTouckClick)(NSInteger count);
@end
