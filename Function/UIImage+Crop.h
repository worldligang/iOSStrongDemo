//
//  UIImage+Crop.h
//  AntsSportApp
//
//  Created by ligang on 15/7/24.
//  Copyright (c) 2015年 LiGang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XYCropImageStyle){
    XYCropImageStyleRight               =0,      // 右半部分
    XYCropImageStyleCenter              =1,      // 中间部分
    XYCropImageStyleLeft                =2,      // 左半部分
    XYCropImageStyleRightOneOfThird     =3,      // 右侧三分之一部分
    XYCropImageStyleCenterOneOfThird    =4,      // 中间三分之一部分
    XYCropImageStyleLeftOneOfThird      =5,      // 左侧三分之一部分
    XYCropImageStyleRightQuarter        =6,      // 右侧四分之一部分
    XYCropImageStyleCenterRightQuarter  =7,      // 中间右侧四分之一部分
    XYCropImageStyleCenterLeftQuarter   =8,      // 中间左侧四分之一部分
    XYCropImageStyleLeftQuarter         =9,      // 左侧四分之一部分
};

@interface UIImage (Crop)
- (UIImage *)imageByCroppingWithStyle:(XYCropImageStyle)style;

@end
