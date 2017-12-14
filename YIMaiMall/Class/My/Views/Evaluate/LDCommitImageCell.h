//
//  LDCommitImageCell.h
//  StairOrder
//
//  Created by Miles on 2017/9/13.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDCommitImageCell : UITableViewCell

@property (nonatomic,copy)void(^addImageCallBack)(BOOL isAddImage,NSInteger index);
@property (nonatomic,strong)UIImageView *uploadImgView;
-(void)createImage;

@end
