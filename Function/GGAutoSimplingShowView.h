//
//  GGAutoSimplingShowView.h
//  AntsSportApp
//
//  Created by ligang on 15/7/22.
//  Copyright (c) 2015年 LiGang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GGAutoSimplingShowView : UIView

typedef NS_ENUM(NSInteger, XYSimplingStyle){
    XYSimplingStyleOriginal                     =0,      // 一张图
    XYSimplingStyleLeftAndRight                 =1,      // 一半左边，一半右边
    XYSimplingStyleTwoCenter                    =2,      // 两半中间
    XYSimplingStyleLeftCenterAndRight           =3,      // 三分之一左边，三分之一中间，三分之一右边
    XYSimplingStyleThreeCenter                  =4,      // 三个三分之一中间
    XYSimplingStyleQuarterLeftCenterAndRight    =5,      // 四分之一左边，四分之一左边中间，四分之一右边中间，四分之一右边
    XYSimplingStyleQuarterFourGeometricZoom     =6,      // 四张图等比缩放
};

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, assign) XYSimplingStyle style;

- (void)autoSimplingViewWithStyle:(XYSimplingStyle)style;

@end
