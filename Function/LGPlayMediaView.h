//
//  LGPlayMediaView.h
//  iOSStrongDemo
//
//  Created by ligang on 15/11/17.
//  Copyright © 2015年 LiGang. All rights reserved.
//
#define SCREEN [UIScreen mainScreen].bounds.size
#import <UIKit/UIKit.h>
@import MediaPlayer;
@class ControllerView;
@interface LGPlayMediaView : UIControl

@property (nonatomic, strong) ControllerView *controls;
@property (strong, nonatomic) NSTimer *hideTimer;
- (id)initPlayer;


- (void)startPlayback:(NSURL *)path;

+ (MPMoviePlayerController *)sharedManager;

@end
