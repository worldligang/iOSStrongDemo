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
        case XYSimplingStyleLeftAndRight:
        {
            for (int i = 0; i < self.imageArray.count; i++) {
                if (i == 2) return;
                UIImage *image = self.imageArray[i];
                if (i == 0) {
                    image = [image imageByCroppingWithStyle:XYCropImageStyleLeft];
                }else{
                    image = [image imageByCroppingWithStyle:XYCropImageStyleRight ];
                }
                CGRect rect;
                float width = self.frame.size.width / 2;
                float height = self.frame.size.height;
                rect.origin.x = width * (i % 2);
                rect.origin.y = height * (i / 2);
                rect.size = CGSizeMake(width, height);
                [image drawInRect:rect];
                
                //获得当前画板
                CGContextRef ctx = UIGraphicsGetCurrentContext();
                CGContextSetRGBStrokeColor(ctx, 0.0, 0.0, 0.0, 1.0);
                CGContextSetLineWidth(ctx, 10.0);
                /*画矩形*/
                CGContextStrokeRect(ctx,CGRectMake(width - 5.0, 0.0, 10.0, height));//画方框
                CGContextStrokePath(ctx);
                [super drawRect:rect];
            }
        }
            break;
        case XYSimplingStyleTwoCenter:
        {
            for (int i = 0; i < self.imageArray.count; i++) {
                if (i == 2) return;
                UIImage *image = self.imageArray[i];
                if (i == 0) {
                    image = [image imageByCroppingWithStyle:XYCropImageStyleCenter];
                }else{
                    image = [image imageByCroppingWithStyle:XYCropImageStyleCenter ];
                }
                CGRect rect;
                float width = self.frame.size.width / 2;
                float height = self.frame.size.height;
                rect.origin.x = width * (i % 2);
                rect.origin.y = height * (i / 2);
                rect.size = CGSizeMake(width, height);
                [image drawInRect:rect];
            }
        }
            break;
        case XYSimplingStyleLeftCenterAndRight:
        {
            
        }
            break;
        case XYSimplingStyleThreeCenter:
        {
            
        }
            break;
        case XYSimplingStyleQuarterLeftCenterAndRight:
        {
            
        }
            break;
        default:
            break;
    }
   
}


@end
