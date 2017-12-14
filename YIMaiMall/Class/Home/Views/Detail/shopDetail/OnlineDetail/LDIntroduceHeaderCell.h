//
//  LDIntroduceHeaderCell.h
//  YIMaiMall
//
//  Created by Miles on 2017/11/30.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDStoreModel.h"
@interface LDIntroduceHeaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLB;
@property (weak, nonatomic) IBOutlet UILabel *focusLB;
@property (weak, nonatomic) IBOutlet UIButton *focusButton;

@property (nonatomic,strong)LDStoreModel *model;

@property (nonatomic, assign) NSInteger count;

@end
