     //
//  XYAutoSimplingShowView.m
//  AntsSportApp
//
//  Created by ligang on 15/7/22.
//  Copyright (c) 2015年 Xiaoyi. All rights reserved.
//

#import "XYAutoSimplingShowView.h"
#import "UIImage+Crop.h"
#define SCREEN [UIScreen mainScreen].bounds.size

@implementation XYAutoSimplingShowView

- (id)init
{
    self = [super init];
    if (self) {
        self.style = -1;
    }
    return self;
}

- (void)autoSimplingViewWithStyle:(XYSimplingStyle)style{
    self.style = style;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    switch (self.style) {
        case XYSimplingStyleOriginal:
        {
            if (self.imageArray.count == 0) return;
            float width = self.frame.size.width;
            float height = self.frame.size.height;
            UIImage *image = self.imageArray[0];
            CGRect rect;
            rect.origin.x = 0;
            rect.origin.y = 0;
            rect.size = CGSizeMake(width, height);
            [image drawInRect:rect];
        }
            break;
        case XYSimplingStyleLeftAndRight:
        {
            float width = self.frame.size.width / 2;
            float height = self.frame.size.height;
            for (int i = 0; i < self.imageArray.count; i++) {
                if (i == 2 || self.imageArray.count < 1) return;
                UIImage *image = self.imageArray[i];
                if (i == 0) {
                    image = [image imageByCroppingWithStyle:XYCropImageStyleLeft];
                } else {
                    image = [image imageByCroppingWithStyle:XYCropImageStyleRight ];
                }
                CGRect rect;
                rect.origin.x = width * (i % 2);
                rect.origin.y = height * (i / 2);
                rect.size = CGSizeMake(width, height);
                [image drawInRect:rect];
                //获得当前画板
                CGContextRef ctx = UIGraphicsGetCurrentContext();
                CGContextSetRGBFillColor(ctx, 0.0, 0.0, 0.0, 1.0);
                CGContextFillRect(ctx, CGRectMake(width - 5.0, 0.0, 10.0, height));
                CGContextStrokePath(ctx);
                [super drawRect:rect];
            }
         
        }
            break;
        case XYSimplingStyleTwoCenter:
        {
            float width = self.frame.size.width / 2;
            float height = self.frame.size.height;
            for (int i = 0; i < self.imageArray.count; i++) {
                if (i == 2 || self.imageArray.count < 2) return;
                UIImage *image = self.imageArray[i];
                image = [image imageByCroppingWithStyle:XYCropImageStyleCenter];
                CGRect rect;
                rect.origin.x = width * (i % 2);
                rect.origin.y = height * (i / 2);
                rect.size = CGSizeMake(width, height);
                [image drawInRect:rect];
            }
        }
            break;
        case XYSimplingStyleLeftCenterAndRight:
        {
            float width = self.frame.size.width / 3;
            float height = self.frame.size.height;
            for (int i = 0; i < self.imageArray.count; i++) {
                if (i == 3 || self.imageArray.count < 3) return;
                UIImage *image = self.imageArray[i];
                if (i == 0) {
                    image = [image imageByCroppingWithStyle:XYCropImageStyleLeftOneOfThird];
                } else if (i == 1) {
                    image = [image imageByCroppingWithStyle:XYCropImageStyleCenterOneOfThird ];
                } else if (i == 2) {
                    image = [image imageByCroppingWithStyle:XYCropImageStyleRightOneOfThird ];
                }
                CGRect rect;
                rect.origin.x = width * (i % 3);
                rect.origin.y = height * (i / 3);
                rect.size = CGSizeMake(width, height);
                [image drawInRect:rect];
                //获得当前画板
                CGContextRef ctx = UIGraphicsGetCurrentContext();
                CGContextSetRGBFillColor(ctx, 0.0, 0.0, 0.0, 1.0);
                CGContextFillRect(ctx, CGRectMake(width - 2.5, 0.0, 5.0, height));
                CGContextFillRect(ctx, CGRectMake(width * 2 - 2.5, 0.0, 5.0, height));
                [super drawRect:rect];
            }
  
        }
            break;
        case XYSimplingStyleThreeCenter:
        {
            float width = self.frame.size.width / 3;
            float height = self.frame.size.height;
            for (int i = 0; i < self.imageArray.count; i++) {
                if (i == 4 || self.imageArray.count < 4) return;
                UIImage *image = self.imageArray[i];
                image = [image imageByCroppingWithStyle:XYCropImageStyleCenterOneOfThird ];
                CGRect rect;
                rect.origin.x = width * (i % 3);
                rect.origin.y = height * (i / 3);
                rect.size = CGSizeMake(width, height);
                [image drawInRect:rect];
            }
        }
            break;
        case XYSimplingStyleQuarterLeftCenterAndRight:
        {
            float width = self.frame.size.width / 4;
            float height = self.frame.size.height;
            for (int i = 0; i < self.imageArray.count; i++) {
                if (i == 4 || self.imageArray.count < 4) return;
                UIImage *image = self.imageArray[i];
                if (i == 0) {
                    image = [image imageByCroppingWithStyle:XYCropImageStyleLeftQuarter];
                } else if (i == 1) {
                    image = [image imageByCroppingWithStyle:XYCropImageStyleCenterLeftQuarter ];
                } else if (i == 2) {
                    image = [image imageByCroppingWithStyle:XYCropImageStyleCenterRightQuarter ];
                } else if (i == 3) {
                    image = [image imageByCroppingWithStyle:XYCropImageStyleRightQuarter ];
                }
                CGRect rect;
                rect.origin.x = width * (i % 4);
                rect.origin.y = height * (i / 4);
                rect.size = CGSizeMake(width, height);
                [image drawInRect:rect];
            }
            //获得当前画板
            CGContextRef ctx = UIGraphicsGetCurrentContext();
            CGContextSetRGBFillColor(ctx, 0.0, 0.0, 0.0, 1.0);
            CGContextFillRect(ctx, CGRectMake(width - 2.5, 0.0, 5.0, height));
            CGContextFillRect(ctx, CGRectMake(width * 2 - 2.5, 0.0, 5.0, height));
            CGContextFillRect(ctx, CGRectMake(width * 3 - 2.5, 0.0, 5.0, height));
            [super drawRect:rect];
        }
            break;
        case XYSimplingStyleQuarterFourGeometricZoom:
        {
            float width = self.frame.size.width / 2;
            float height = self.frame.size.height / 2;
            for (int i = 0; i < self.imageArray.count; i++) {
                if (i == 4 || self.imageArray.count < 4) return;
                UIImage *image = self.imageArray[i];
                CGRect rect;
                rect.origin.x = width * (i % 2);
                rect.origin.y = height * (i / 2);
                rect.size = CGSizeMake(width, height);
                [image drawInRect:rect];
            }
        }
            break;
        default:
            break;
    }
   
}


@end
