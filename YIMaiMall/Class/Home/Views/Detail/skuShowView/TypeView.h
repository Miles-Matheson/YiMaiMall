//
//  TypeView.h
//  AddShoppingCart
//
//  Created by 主用户 on 16/3/23.
//  Copyright © 2016年 江萧. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDGoodsSkuModel.h"


@class TypeView;
@protocol TypeSeleteDelegete <NSObject>

-(void)typeViewView:(TypeView *)typeView SelectFloorIndex:(NSInteger )index itemClickIndex:(NSInteger )itemClickIndex;
@end


@interface TypeView : UIView
@property(nonatomic)float height;
@property(nonatomic)int seletIndex;
@property (nonatomic,retain) id<TypeSeleteDelegete> delegate;

-(instancetype)initWithFrame:(CGRect)frame andDatasource:(NSArray <LDGoodsSkustandarLowerModel*>*)models :(NSString *)typename;
@end
