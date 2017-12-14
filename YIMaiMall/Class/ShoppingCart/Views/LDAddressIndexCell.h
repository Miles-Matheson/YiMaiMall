//
//  LDAddressIndexCell.h
//  YIMaiMall
//
//  Created by Miles on 2017/11/21.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDAddressListModel.h"

@interface LDAddressIndexCell : UITableViewCell

@property (nonatomic,strong)UILabel *tostLB;

@property (nonatomic,strong)LDAddressListModel *model;

@property (weak, nonatomic) IBOutlet UILabel *addressNameLB;
@property (weak, nonatomic) IBOutlet UILabel *addressNumberLB;
@property (weak, nonatomic) IBOutlet UILabel *addressContentLB;

@end
