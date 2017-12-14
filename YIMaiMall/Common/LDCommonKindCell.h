//
//  LDCommonKindCell.h
//  StairOrder
//
//  Created by Miles on 2017/8/19.
//  Copyright © 2017年 Miles. All rights reserved.
//

typedef enum : NSUInteger {
    LDCommonKindTypeDeulat = 0,
    LDCommonKindTypeCode,
    LDCommonKindTypeCountTF,
    LDCommonKindTypeSwitch,
} LDCommonKindType;

typedef enum : NSUInteger {
    LDCommonTFTypeDeulat = 0,
    LDCommonTFTypePrice,
    LDCommonTFTypeNumber,
    LDCommonTFTypePhone,
    LDCommonTFTypePassWord,
} LDCommonTFType;


#import <UIKit/UIKit.h>


@interface LDCommonKindCell : UITableViewCell
@property (nonatomic,strong)UITextField *countentTF;
@property (nonatomic,strong)UIButton *countDownBtn;
@property (nonatomic,assign)LDCommonKindType commonKindType;
@property (nonatomic,assign)LDCommonTFType commonTFType;
+ (instancetype)cellWithTableView:(UITableView *)tableView KindTypetype:(LDCommonKindType)kindType;

@end
