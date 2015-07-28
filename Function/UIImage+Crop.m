//
//  UIImage+Crop.m
//  AntsSportApp
//
//  Created by ligang on 15/7/24.
//  Copyright (c) 2015年 LiGang. All rights reserved.
//

#import "UIImage+Crop.h"

@implementation UIImage (Crop)

- (UIImage *)imageByCroppingWithStyle:(XYCropImageStyle)style
{
    CGRect rect;
    switch (style) {
        case XYCropImageStyleLeft:
            rect = CGRectMake(0, 0, self.size.width/2, self.size.height);
            break;
        case XYCropImageStyleCenter:
            rect = CGRectMake(self.size.width/4, 0, self.size.width/2, self.size.height);
            break;
        case XYCropImageStyleRight:
            rect = CGRectMake(self.size.width/2, 0, self.size.width/2, self.size.height);
            break;
        case XYCropImageStyleLeftOneOfThird:
            rect = CGRectMake(0, 0, self.size.width/3, self.size.height);
            break;
        case XYCropImageStyleCenterOneOfThird:
            rect = CGRectMake(self.size.width/3, 0, self.size.width/3, self.size.height);
            break;
        case XYCropImageStyleRightOneOfThird:
            rect = CGRectMake(self.size.width/3*2, 0, self.size.width/3, self.size.height);
            break;
        case XYCropImageStyleLeftQuarter:
            rect = CGRectMake(0, 0, self.size.width/4, self.size.height);
            break;
        case XYCropImageStyleCenterLeftQuarter:
            rect = CGRectMake(self.size.width/4, 0, self.size.width/4, self.size.height);
            break;
        case XYCropImageStyleCenterRightQuarter:
            rect = CGRectMake(self.size.width/4*2, 0, self.size.width/4, self.size.height);
            break;
        case XYCropImageStyleRightQuarter:
            rect = CGRectMake(self.size.width/4*3, 0, self.size.width/4, self.size.height);
            break;
        default:
            break;
    }
    CGImageRef imageRef = self.CGImage;
    CGImageRef imagePartRef = CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *cropImage = [UIImage imageWithCGImage:imagePartRef];
    CGImageRelease(imagePartRef);
    return cropImage;
}

@end
