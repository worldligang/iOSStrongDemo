//
//  XYAutoSimplingShowView.h
//  AntsSportApp
//
//  Created by ligang on 15/7/22.
//  Copyright (c) 2015年 Xiaoyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYAutoSimplingShowView : UIView

typedef NS_ENUM(NSInteger, XYSimplingStyle){
    XYSimplingStyleLeftAndRight                 =0,      // 一半左边，一半右边
    XYSimplingStyleTwoCenter                    =1,      // 两半中间
    XYSimplingStyleLeftCenterAndRight           =2,      // 三分之一左边，三分之一中间，三分之一右边
    XYSimplingStyleThreeCenter                  =3,      // 三个三分之一中间
    XYSimplingStyleQuarterLeftCenterAndRight    =4,      // 四分之一左边，四分之一左边中间，四分之一右边中间，四分之一右边
};

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, assign) XYSimplingStyle style;

- (void)autoSimplingViewWithStyle:(XYSimplingStyle)style;

@end
