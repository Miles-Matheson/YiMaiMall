//
//  PhoneAddController.h
//  MurphysLaw
//
//  Created by Miles on 2017/4/12.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface PhoneAddController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *aTableView;
@property (strong, nonatomic) IBOutlet UITableViewCell *phoneCell;
@property (nonatomic,copy)void(^itemClickCallBack)(NSString *phoneName);
@end
