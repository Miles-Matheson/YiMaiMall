//
//  ShareChooseView.h
//  BaseFrame
//
//  Created by 陈舟为 on 2017/7/13.
//  Copyright © 2017年 Zxs. All rights reserved.
//

#import "MMAlertView.h"

@interface ShareModel : NSObject

@property(nonatomic,copy)NSString *ShareContent,*SharePic,*Title,*URL;

@end


@interface ShareChooseView : MMAlertView

@property(nonatomic,strong)ShareModel *model;


@end
