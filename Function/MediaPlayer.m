//
//  MediaPlayer.m
//  iOSStrongDemo
//
//  Created by ligang on 15/11/17.
//  Copyright © 2015年 LiGang. All rights reserved.
//

#import "MediaPlayer.h"
#import "LGPlayMediaView.h"
#import "ControllerView.h"
#import <CoreMedia/CoreMedia.h>
#import "AFURLSessionManager.h"

#import "Reachability.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import <AVFoundation/AVFoundation.h>
#define Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
#define buttom_video (SCREEN.width * 9.0/16.0)

@interface MediaPlayer ()<ControllViewDelegate,UIAlertViewDelegate, NSURLConnectionDataDelegate>
@property (weak, nonatomic) UIButton *leftButton;
@property (weak, nonatomic) UISlider *sliderView;
@property (weak, nonatomic) UIButton *start;
@property (weak, nonatomic) UILabel *didPlayTimeLabel;
@property (weak, nonatomic) UILabel *willPlayTimeLabel;
@property (copy, nonatomic) NSString *didPlayTime;
@property (copy, nonatomic) NSString *willPlayTime;
@property (weak, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) NSTimer *time;
@property (assign, nonatomic) NSInteger totalTime;
@property (assign, nonatomic) NSInteger didPlaySeconds;
@property (assign, nonatomic) NSInteger willPlaySeconds;
@property (weak, nonatomic) LGPlayMediaView *playView;
@property (weak, nonatomic) UILabel *willPlayTimeLabel_s;
@property (weak, nonatomic) UILabel *didPlayTimeLabel_s;
@property (weak, nonatomic) UISlider *slider_s;
@property (weak, nonatomic) UIButton *play_pause_btn;
@property (weak, nonatomic) UIButton *fullScreen_btn;
//s时的back
@property (weak, nonatomic) UIButton *backButton;
@property (weak, nonatomic) UIButton *shareButton;


@property (weak, nonatomic) UIActivityIndicatorView *indicatorView;

@property (weak, nonatomic) UIAlertView *noInternetAlert;

@end

@implementation MediaPlayer

#pragma mark - 时间轴
- (void)setupSlider
{
    /*
     * 设置slider
     */
    UISlider *slider_s = [[UISlider alloc]initWithFrame:CGRectMake(81, buttom_video + 45, SCREEN.width - 92, 60)];
    [slider_s setThumbImage:[UIImage imageNamed:@"jindutiao_nor"] forState:UIControlStateNormal];
    slider_s.minimumTrackTintColor = Color(4, 165, 223);
    slider_s.maximumTrackTintColor = Color(99, 99, 100);
    slider_s.center = CGPointMake(SCREEN.width/2, buttom_video + 40);
    self.slider_s = slider_s;
    [self.view addSubview:slider_s];
    
    [slider_s addTarget:self action:@selector(slide:) forControlEvents:UIControlEventTouchUpInside];
    [slider_s addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchDown];
    [slider_s addTarget:self action:@selector(sliding:) forControlEvents:UIControlEventValueChanged];
    /*
     * 将要播放时间
     */
    UILabel *willPlayTimeLabel_s = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN.width - 44, buttom_video + 30, 60, 20)];
    
    self.willPlayTimeLabel_s = willPlayTimeLabel_s;
    [self.view addSubview:willPlayTimeLabel_s];
    willPlayTimeLabel_s.text = @"00:00";
    willPlayTimeLabel_s.textColor = [UIColor lightTextColor];
    willPlayTimeLabel_s.font = [UIFont systemFontOfSize:12];
    /*
     * 已经播放时间
     */
    UILabel *didPlayTimeLabel_s = [[UILabel alloc]initWithFrame:CGRectMake(16, buttom_video + 30, 60, 20)];
    self.didPlayTimeLabel_s = didPlayTimeLabel_s;
    didPlayTimeLabel_s.text = @"00:00";
    didPlayTimeLabel_s.textColor = [UIColor lightTextColor];
    didPlayTimeLabel_s.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:didPlayTimeLabel_s];
}

- (void)justHideControls_s
{
    self.backButton.hidden = YES;
    self.slider_s.hidden = YES;
    self.willPlayTimeLabel_s.hidden = YES;
    self.didPlayTimeLabel_s.hidden = YES;
    self.fullScreen_btn.hidden = YES;
    self.download_btn.hidden = YES;
    self.play_pause_btn.hidden = YES;
}

- (void)justShowControls_s
{
    self.backButton.hidden = NO;
    self.slider_s.hidden = NO;
    self.willPlayTimeLabel_s.hidden = NO;
    self.didPlayTimeLabel_s.hidden = NO;
    self.fullScreen_btn.hidden = NO;
    self.download_btn.hidden = NO;
    self.play_pause_btn.hidden = NO;
}

- (void)setupThreeButtons
{
    UIButton *play_pause_btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    self.play_pause_btn = play_pause_btn;
    play_pause_btn.center = CGPointMake(SCREEN.width/2, buttom_video + 245 - 80);
    [self.view addSubview:play_pause_btn];
    [play_pause_btn setImage:[UIImage imageNamed:@"btn_content_play_nor"] forState:UIControlStateNormal];
    [play_pause_btn setImage:[UIImage imageNamed:@"btn_content_stop_nor"] forState:UIControlStateSelected];
    [play_pause_btn addTarget:self action:@selector(startPlaying) forControlEvents:UIControlEventTouchUpInside];
    play_pause_btn.selected = YES;
}

- (void)startPlaying
{
    if ([LGPlayMediaView sharedManager].playbackState == MPMoviePlaybackStatePlaying) {
        [[LGPlayMediaView sharedManager]pause];
    } else {
        [[LGPlayMediaView sharedManager]play];
    }
    
    [_time setFireDate:[NSDate distantPast]];
}

//警告后,让用户选择是否继续消耗流量
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == _noInternetAlert) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        //不继续
        if (buttonIndex == 1) {
            [self.navigationController popViewControllerAnimated:YES];
            //继续,且加载内容
        } else if (buttonIndex == 0) {
            [self theContent];
        }
    }
}
//加载内容
- (void)theContent
{
#pragma mark - 初始化控件
    LGPlayMediaView *playView = [[LGPlayMediaView alloc] initPlayer];
    _playView = playView;
    playView.frame = CGRectMake(0, 0, SCREEN.width, SCREEN.width * 9.0/16.0);
    playView.backgroundColor = [UIColor blackColor];
    [LGPlayMediaView sharedManager].shouldAutoplay = YES;
    [LGPlayMediaView sharedManager].view.frame = playView.frame;
    [LGPlayMediaView sharedManager].controlStyle = MPMovieControlStyleNone;
    [playView addSubview:[LGPlayMediaView sharedManager].view];
    [self.view addSubview:playView];
    [self setupSlider];
    [self setupThreeButtons];
    for (int i = 0; i < playView.controls.subviews.count-GestureControlsCount; i++) {
        [playView.controls.subviews[i] setHidden:YES];
    }
    
    /*
     * 遵守ControllViewDelegate,为了把控件的触发效果写到这个.m文件
     */
    playView.controls.delegate_ControllView = self;
    
    /*
     * 初始状态有控件,渐渐消失
     */
    _time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timePassing) userInfo:nil repeats:YES];
    //传值到ControllerView中,使ControllerView中完成手势控制进度
    _playView.controls.time = _time;
    /*
     * 添加通知
     */
    [self addNotification];
    /*
     * 播放
     */
    [playView startPlayback:_urlString];
    
#pragma mark - 缓冲
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [indicatorView startAnimating];
    _indicatorView = indicatorView;
    [[LGPlayMediaView sharedManager].view addSubview:indicatorView];
    _indicatorView.center = [LGPlayMediaView sharedManager].view.center;
    _indicatorView.hidden = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self theContent];
}


#pragma mark - 添加通知
- (void)addNotification
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    //    [nc addObserver:self selector:@selector(stateChanged) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    [nc addObserver:self selector:@selector(stateChanged) name:nil object:nil];
    [nc addObserver:self selector:@selector(loadStateChanged) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - 判断是否缓冲
- (void)loadStateChanged
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([LGPlayMediaView sharedManager].loadState == (MPMovieLoadStatePlayable | MPMovieLoadStatePlaythroughOK | MPMovieLoadStateUnknown)) {
            self.indicatorView.hidden = YES;
        } else {
            self.indicatorView.hidden = NO;
        }
    });
}

#pragma mark - 开始键的状态
- (void)stateChanged
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MPMoviePlaybackState state = [LGPlayMediaView sharedManager].playbackState;
        switch (state) {
            case MPMoviePlaybackStatePlaying:
            {
                self.play_pause_btn.selected = YES;
                self.playView.controls.start.selected = YES;
                break;
            }
            case MPMoviePlaybackStateSeekingBackward:
                break;
            case MPMoviePlaybackStateSeekingForward:
                break;
            case MPMoviePlaybackStatePaused:
            {
                self.play_pause_btn.selected = NO;
                self.playView.controls.start.selected = NO;
                break;
            }
            case MPMoviePlaybackStateStopped:
            {
                self.play_pause_btn.selected = NO;
                self.playView.controls.start.selected = NO;
            }
            case MPMoviePlaybackStateInterrupted:
            {
                self.play_pause_btn.selected = NO;
                self.playView.controls.start.selected = NO;
            }
            default:
                break;
        }
    });
}
#pragma mark - 每秒渐渐消失
- (void)timePassing
{
    _totalTime = (NSInteger)[LGPlayMediaView sharedManager].duration;
    _didPlaySeconds = (NSInteger)[LGPlayMediaView sharedManager].currentPlaybackTime;
    _willPlaySeconds = _totalTime - _didPlaySeconds;
    _didPlayTime = [NSString stringWithFormat:@"%02ld:%02ld",(long)_didPlaySeconds/60,(long)_didPlaySeconds%60];
    _willPlayTime = [NSString stringWithFormat:@"%02ld:%02ld",(long)_willPlaySeconds/60,(long)_willPlaySeconds%60];
    _didPlayTimeLabel.text = _didPlayTime;
    _willPlayTimeLabel.text = _willPlayTime;
    
    self.slider_s.value = (float)_didPlaySeconds/_totalTime;
    self.sliderView.value = (float)_didPlaySeconds/_totalTime;
    
#pragma mark - 如果视频放完了,视频返回未开始播放状态
    if (_slider_s.value == 1 || _sliderView.value == 1) {
        _sliderView.value = 0;
        _didPlaySeconds = 0;
        [_time setFireDate:[NSDate distantFuture]];
        _didPlayTime = @"00:00";
        _willPlayTime = [NSString stringWithFormat:@"%02ld:%02ld",(long)_totalTime/60,(long)_totalTime%60];
        _slider_s.value = 0;
        _sliderView.value = 0;
        [LGPlayMediaView sharedManager].currentPlaybackTime = 0.0;
        [[LGPlayMediaView sharedManager] pause];
        for (int i = 0; i < _playView.controls.subviews.count-GestureControlsCount; i++) {
            [_playView.controls.subviews[i] setAlpha:1.0];
        }
    }
    /*
     * 外面的控件按照里面的控件来变化
     */
    self.willPlayTimeLabel_s.text = self.willPlayTimeLabel.text;
    self.didPlayTimeLabel_s.text = self.didPlayTimeLabel.text;
}


#pragma mark - 把controllView中的控件传过来
- (void)controllerView:(ControllerView *)controllerView
        WithLeftButton:(UIButton *)leftButton
           RightButton:(UIButton *)rightButton
            sliderView:(UISlider *)sliderView
                 start:(UIButton *)start
              download:(UIButton *)download
      didPlayTimeLabel:(UILabel *)didPlayTimeLabel
     willPlayTimeLabel:(UILabel *)willPlayTimeLabel
            titleLabel:(UILabel *)titleLabel

{
    _leftButton = leftButton;
    _rightButton = rightButton;
    _sliderView = sliderView;
    _start = start;
    _download_btn = download;
    _didPlayTimeLabel = didPlayTimeLabel;
    _willPlayTimeLabel = willPlayTimeLabel;
    _titleLabel = titleLabel;
    [start addTarget:self action:@selector(startPlaying) forControlEvents:UIControlEventTouchUpInside];
#pragma mark - 重写触发事件
    [_sliderView addTarget:self action:@selector(slide:) forControlEvents:UIControlEventTouchUpInside];
    [_sliderView addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchDown];
    [_sliderView addTarget:self action:@selector(sliding:) forControlEvents:UIControlEventValueChanged];
    titleLabel.text = self.title;
}



#pragma mark - 滑动slider的触发事件
- (void)sliding:(UISlider *)slider
{
    [_time setFireDate:[NSDate distantFuture]];
    _didPlaySeconds = slider.value * _totalTime;
    _willPlaySeconds = (1 - slider.value) * _totalTime;
    _didPlayTime = [NSString stringWithFormat:@"%02ld:%02ld",(long)_didPlaySeconds/60,(long)_didPlaySeconds%60];
    _willPlayTime = [NSString stringWithFormat:@"%02ld:%02ld",(long)_willPlaySeconds/60,(long)_willPlaySeconds%60];
    _didPlayTimeLabel.text = _didPlayTime;
    _willPlayTimeLabel.text = _willPlayTime;
    
    _didPlayTimeLabel_s.text = _didPlayTimeLabel.text;
    _willPlayTimeLabel_s.text = _willPlayTimeLabel.text;
    
}

/*
 * 只要一碰屏幕,控件就停止消失
 */
- (void)touch:(UISlider *)slider
{
    [_time setFireDate:[NSDate distantFuture]];
    
}

- (void)slide:(UISlider *)slider
{
    [_time setFireDate:[NSDate distantPast]];
    [LGPlayMediaView sharedManager].currentPlaybackTime = slider.value * (NSInteger)[LGPlayMediaView sharedManager].duration;
}

#pragma mark - 退出时停止播放
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [[LGPlayMediaView sharedManager]stop];
    [_indicatorView removeFromSuperview];
    [LGPlayMediaView sharedManager].contentURL = nil;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"要下载的文件大小%lld",response.expectedContentLength);
}

@end
