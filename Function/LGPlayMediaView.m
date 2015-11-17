//
//  LGPlayView.m
//  iOSStrongDemo
//
//  Created by ligang on 15/11/17.
//  Copyright © 2015年 LiGang. All rights reserved.
//

#import "LGPlayMediaView.h"
#import "ControllerView.h"
//#import "MBProgressHUD+MJ.h"
@interface LGPlayMediaView ()

@end
@implementation LGPlayMediaView

static MPMoviePlayerController *cbberPlayerController = nil;

//单例方法
+ (MPMoviePlayerController *)sharedManager
{
    //线程同步块
    @synchronized(cbberPlayerController)
    {
        //如果没有对象创建，有的话直接返回
        if(!cbberPlayerController)
        {
            cbberPlayerController = [[MPMoviePlayerController alloc] init];
        }
    }
    return cbberPlayerController;
}

- (id)initPlayer
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        /*
         * 初始化控件,这个initWithFrame方法有重写
         */
        ControllerView *controls = [[ControllerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN.width, SCREEN.width * 9.0/16.0)];
        _controls = controls;
        for (int i = 0; i < controls.subviews.count - GestureControlsCount; i++) {
            [controls.subviews[i] setAlpha:0.0];
        }
        [self addSubview:_controls];
        
#pragma mark - 计时器:一开始有控件,每秒控件渐渐透明
        
        self.hideTimer = [NSTimer scheduledTimerWithTimeInterval:.55 target:self selector:@selector(hideSlowly) userInfo:nil repeats:YES];
        [_controls.sliderView addTarget:self action:@selector(sliderViewTouched:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchDown|UIControlEventValueChanged];
        [_controls.start addTarget:self action:@selector(startTouched) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}


#pragma mark - 如果sliderView或者start被摸了,计时器停止,控件不透明,计时器重新计时
- (void)sliderViewTouched:(UISlider *)slider
{
    [self.hideTimer setFireDate:[NSDate distantFuture]];
    for (int i = 0 ; i < _controls.subviews.count-GestureControlsCount; i++) {
        id object = _controls.subviews[i];
        [object setAlpha:1.0];
    }
    [self.hideTimer setFireDate:[NSDate distantPast]];
}

- (void)startTouched
{
    [_hideTimer setFireDate:[NSDate distantFuture]];
    for (int i = 0 ; i < _controls.subviews.count-GestureControlsCount; i++) {
        id object = _controls.subviews[i];
        [object setAlpha:1.0];
    }
    [self.hideTimer setFireDate:[NSDate distantPast]];
}

#pragma mark - 每秒控件渐渐透明
- (void)hideSlowly
{
    for (int i = 0 ; i < _controls.subviews.count-GestureControlsCount; i++) {
        id object = _controls.subviews[i];
        [object setAlpha:([object alpha] - 0.04)];
    }
}

//初始化视频
- (void)startPlayback:(NSURL *)path
{
    [[LGPlayMediaView sharedManager] setContentURL:path];
    [[LGPlayMediaView sharedManager] play];
}
@end
