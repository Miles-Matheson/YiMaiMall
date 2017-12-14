//
//  LDSearchShopCell.h
//  YIMaiMall
//
//  Created by Miles on 2017/11/21.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDShopListModel.h"

@interface LDSearchShopCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *desLB;
@property (weak, nonatomic) IBOutlet UIImageView *indexImageView;
@property (weak, nonatomic) IBOutlet UILabel *ZiYingLB;

@property (nonatomic,strong)LDShopListModel *model;

@end
