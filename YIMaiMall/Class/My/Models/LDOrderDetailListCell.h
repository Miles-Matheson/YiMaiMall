//
//  LDOrderDetailListCell.h
//  YIMaiMall
//
//  Created by Miles on 2017/12/11.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDOrderDetailModel.h"
@interface LDOrderDetailListCell : UITableViewCell

@property (nonatomic, assign) LDOrderGoodsListModel *listModel;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *godsNameLB;
@property (weak, nonatomic) IBOutlet UILabel *goodsDesLB;
@property (weak, nonatomic) IBOutlet UILabel *priceLB;
@property (weak, nonatomic) IBOutlet UILabel *countLB;

@end
