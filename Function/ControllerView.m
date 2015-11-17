//
//  ControllerView.m
//  iOSStrongDemo
//
//  Created by ligang on 15/11/17.
//  Copyright © 2015年 LiGang. All rights reserved.
//

#import "ControllerView.h"
#import <MediaPlayer/MediaPlayer.h>
#import "LGPlayMediaView.h"
@import MediaPlayer;
#define Length 60
#define Spacing 10

#define Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


@implementation ControllerView

#pragma mark - 初始化控件
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /*
         * clear显示视频
         */
        self.backgroundColor = [UIColor clearColor];
        /*
         * 返回
         */
        UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(Spacing, Spacing, Length, Length)];
        leftButton.center = CGPointMake(46, 36);
        [leftButton setImage:[UIImage imageNamed:@"btn_back_normal"] forState:UIControlStateNormal];
        [leftButton setImage:[UIImage imageNamed:@"btn_back_pressed"] forState:UIControlStateHighlighted];
        [self addSubview:leftButton];
#pragma mark - 用slider重写
        UISlider *sliderView = [[UISlider alloc]initWithFrame:CGRectMake(98, SCREEN.width - 72, SCREEN.height - 200, 60)];
        [sliderView setThumbImage:[UIImage imageNamed:@"jindutiao_nor"] forState:UIControlStateNormal];
        sliderView.minimumTrackTintColor = Color(4, 165, 223);
        sliderView.maximumTrackTintColor = Color(99, 99, 100);
        
        [self addSubview:sliderView];
        /*
         * 开始暂停
         */
        UIButton *start = [[UIButton alloc]initWithFrame:CGRectMake(Spacing, SCREEN.width - Spacing - Length, 50, 50)];
        start.center = CGPointMake(50, SCREEN.width - 50);
        [start setImage:[UIImage imageNamed:@"btn_content_stop_nor"] forState:UIControlStateSelected];
        [start setImage:[UIImage imageNamed:@"btn_content_play_nor"] forState:UIControlStateNormal];
        [self addSubview:start];
        start.selected = YES;

        /*
         * 已经播放时长
         */
        UILabel *didPlayTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, SCREEN.width - 80, 120, 50)];
        [self addSubview:didPlayTimeLabel];
        didPlayTimeLabel.textColor = [UIColor whiteColor];
        didPlayTimeLabel.text = @"00:00";
        didPlayTimeLabel.font = [UIFont systemFontOfSize:17];
        /*
         * 剩余时长
         */
        UILabel *willPlayTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN.height - 146, SCREEN.width - 80, 100, 50)];//00:00字体长度为43
        [self addSubview:willPlayTimeLabel];
        willPlayTimeLabel.textColor = [UIColor whiteColor];
        willPlayTimeLabel.text = @"00:00";
        willPlayTimeLabel.font = [UIFont systemFontOfSize:17];
        /*
         * 正上方title
         */
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.font = [UIFont boldSystemFontOfSize:17];
        titleLabel.bounds = CGRectMake(0, 0, 200, 50);
        titleLabel.center = CGPointMake(SCREEN.height/2, 25+17);
        [self addSubview:titleLabel];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;

        
        _leftButton = leftButton;
//        _rightButton = rightButton;
        _sliderView = sliderView;
        _start = start;
        _didPlayTimeLabel = didPlayTimeLabel;
        _willPlayTimeLabel = willPlayTimeLabel;
//        _download = download;
        _titleLabel = titleLabel;
        [self addTarget:self action:@selector(hideOrShow) forControlEvents:UIControlEventTouchDown];
        
#pragma mark - 手势控制快进
        UILabel *forward_backward = [[UILabel alloc]init];
        _forward_backward = forward_backward;
        [self addSubview:forward_backward];
        forward_backward.bounds = CGRectMake(0, 0, 200, 50);
        forward_backward.center = self.center;
        forward_backward.textColor = [UIColor whiteColor];
        forward_backward.font = [UIFont boldSystemFontOfSize:28];
        forward_backward.textAlignment = NSTextAlignmentCenter;
        
        UIImageView *forward_backward_backgroundImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"forward_backward"]];
        //这句话逻辑有问题,为什么label不用setHidden
        forward_backward_backgroundImageView.hidden = YES;
        _forward_backward_backgroundImageView = forward_backward_backgroundImageView;
        forward_backward_backgroundImageView.center = forward_backward.center;
        [self addSubview:forward_backward_backgroundImageView];
    }
    return self;
}



#pragma mark - 在适当的时机，给delegate对象发消息，传参数。
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    /*
     * 把这些控件传到MediaPlayer这个controller中
     */
    
    [self.delegate_ControllView controllerView:self WithLeftButton:_leftButton RightButton:_rightButton sliderView:_sliderView start:_start download:_download didPlayTimeLabel:_didPlayTimeLabel willPlayTimeLabel:_willPlayTimeLabel titleLabel:_titleLabel];
    
}


#pragma mark - 点击屏幕显示所有控件
- (void)hideOrShow
{
    if ([self.subviews[0] alpha] > 0.2) {
        for (int i = 0; i < self.subviews.count-GestureControlsCount; i++) {
            id object = self.subviews[i];
            [object setAlpha:0];
        }
    } else {
        for (int i = 0; i < self.subviews.count-GestureControlsCount; i++) {
            id object = self.subviews[i];
            [object setAlpha:1];
        }
    }
}

- (void)justShow
{
    for (int i = 0; i < self.subviews.count-GestureControlsCount; i++) {
        id object = self.subviews[i];
        [object setAlpha:1];
    }
}

#pragma mark - 手势控制进度
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    self.firstPoint = [touch locationInView:self];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    //确立第二点
    self.secondPoint = [touch locationInView:self];
    
    //如果为水平移动
    if (fabs(self.firstPoint.x - self.secondPoint.x) > fabs(self.firstPoint.y - self.secondPoint.y)) {
        
        if (_direction == None || _direction == Vertical) {
            //确立水平移动,不受垂直移动干扰
            _direction = Vertical;
            //进度条的值随着手势变化
            self.sliderView.value += -(self.firstPoint.x - self.secondPoint.x)/500.0;
            //屏幕中间的label变化
            NSTimeInterval totalTime = LGPlayMediaView.sharedManager.duration;
            NSString *didPlayTime = [NSString stringWithFormat:@"%02ld:%02ld",(long)(self.sliderView.value * totalTime)/60, (long)((self.sliderView.value) *totalTime)%60];
            NSString *totalPlayTime = [NSString stringWithFormat:@"%02ld:%02ld",(long)[LGPlayMediaView sharedManager].duration/60,(long)[LGPlayMediaView sharedManager].duration%60];
            NSString *forward_backwardText = [NSString stringWithFormat:@"%@/%@",didPlayTime,totalPlayTime];
            _forward_backward.text = forward_backwardText;
            _forward_backward.hidden = NO;
            _forward_backward_backgroundImageView.hidden = NO;
            
            //关闭计时器,防止slider闪烁的bug
            [self.time setFireDate:[NSDate distantFuture]];
        }
    }
    //如果为垂直移动
    else {
        _firstPointX = self.firstPoint.x;
            if (_direction == None || _direction == HorizontalRight)
            {
                _direction = HorizontalRight;
                //调整音量
                MPVolumeView *volumeView = [[MPVolumeView alloc] init];
                UISlider* volumeViewSlider = nil;
                for (UIView *view in [volumeView subviews])
                {
                    if ([view.class.description isEqualToString:@"MPVolumeSlider"])
                    {
                        volumeViewSlider = (UISlider*)view;
                        break;
                    }
                }
                
                float systemVolume = volumeViewSlider.value;
                
                [volumeViewSlider setValue:systemVolume + (self.firstPoint.y - self.secondPoint.y)/500 animated:NO];
                
//                [MPMusicPlayerController applicationMusicPlayer].volume += (self.firstPoint.y - self.secondPoint.y)/500;
            }
    }
    //刷新第一点
    self.firstPoint = self.secondPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //解决与UIControlEventTouchDown的冲突
    if (fabs(self.firstPoint.x - self.secondPoint.x) > 0.0 && fabs(self.firstPoint.y - self.secondPoint.y) > 0.0) {//诡异的逻辑，其实大于0就可以了
        [self hideOrShow];
    }else {
        NSLog(@"end时候的________%d",_direction);
        if (_direction == Vertical) {
            [LGPlayMediaView sharedManager].currentPlaybackTime = self.sliderView.value * (NSInteger)[LGPlayMediaView sharedManager].duration;
        } else if (_direction == HorizontalLeft) {
            NSLog(@"horizontalLeft");
        } else if (_direction == HorizontalRight) {
            NSLog(@"horizontalRight");
        } else {
            NSLog(@"touchesEnd方向出错");
        }
        
    }
    self.firstPoint = self.secondPoint = CGPointZero;
    
    _forward_backward.hidden = YES;
    _forward_backward_backgroundImageView.hidden = YES;
    [self.time setFireDate:[NSDate distantPast]];
    _direction = None;
}



@end
