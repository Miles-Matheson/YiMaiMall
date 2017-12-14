//
//  RegisterCell.h
//  BaseFrame
//
//  Created by Zxs on 16/12/14.
//  Copyright © 2016年 Zxs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VerifyCodeButton.h"

#define ReuseIdentifier_Code @"RegisterCell_Code"
#define ReuseIdentifier_Normal @"RegisterCell_Normal"
#define ReuseIdentifier_Address @"ReuseIdentifier_Address"
#define ReuseIdentifier_DefaultAddress @"ReuseIdentifier_DefaultAddress"
#define ReuseIdentifier_QR @"ReuseIdentifier_QR"

typedef void(^getCode)();

typedef void(^SwitchChange)(BOOL isOn);
@interface RegisterCell : UITableViewCell


@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UITextField * contentTF;
@property(nonatomic,strong)UITextView * addressTV;
@property(nonatomic,strong)UILabel * placeLabel;
@property(nonatomic,strong)VerifyCodeButton * codeButton;
@property(nonatomic,copy)getCode code;
@property(nonatomic,copy)getCode qrBlock;
@property(nonatomic,copy)SwitchChange switchChange;
@property(nonatomic,assign)BOOL isLOGIN;
@property(nonatomic,assign)BOOL isArea;

@property(nonatomic,strong)UISwitch * defaultSwitch;

@property(nonatomic,strong)UIColor * titleColor;
@property(nonatomic,assign)CGFloat titleLabelLeft;
@property(nonatomic,assign)CGFloat titleWidth;
@end
