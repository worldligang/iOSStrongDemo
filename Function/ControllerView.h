//
//  ControllerView.h
//  iOSStrongDemo
//
//  Created by ligang on 15/11/17.
//  Copyright © 2015年 LiGang. All rights reserved.
//
#define GestureControlsCount 2
#import <UIKit/UIKit.h>

#pragma mark - 定义委托,声明delegate
@class ControllerView;
@protocol ControllViewDelegate <NSObject>

- (void)controllerView:(ControllerView *)controllerView
        WithLeftButton:(UIButton *)leftButton
           RightButton:(UIButton *)rightButton
            sliderView:(UISlider *)sliderView
                 start:(UIButton *)start
              download:(UIButton *)download
      didPlayTimeLabel:(UILabel *)didPlayTimeLabel
     willPlayTimeLabel:(UILabel *)willPlayTimeLabel
            titleLabel:(UILabel *)titleLabel;

@end



@interface ControllerView : UIControl

@property (weak, nonatomic) id <ControllViewDelegate> delegate_ControllView;
/*
 * 下面这些可以写.m里,为了让drawRect里能拥有button
 */
@property (weak, nonatomic) UIButton *leftButton;
@property (weak, nonatomic) UIButton *rightButton;
@property (weak, nonatomic) UISlider *sliderView;
@property (weak, nonatomic) UIButton *start;
@property (weak, nonatomic) UIButton *download;
@property (weak, nonatomic) UILabel *didPlayTimeLabel;
@property (weak, nonatomic) UILabel *willPlayTimeLabel;
@property (weak, nonatomic) UILabel *titleLabel;

/*
 * 为了让MediaPlayer调这个方法
 */
- (void)hideOrShow;

@property (nonatomic,assign)CGPoint firstPoint;
@property (nonatomic,assign)CGPoint secondPoint;

#pragma mark - 手势控制进度
@property (nonatomic, weak) UILabel *forward_backward;
@property (nonatomic, weak) UIImageView *forward_backward_backgroundImageView;
@property (nonatomic, strong) NSTimer *time;

typedef enum{
    None = 0,
    Vertical,
    HorizontalLeft,
    HorizontalRight
}GestureDirection;
@property (nonatomic, assign) GestureDirection direction;
@property (nonatomic, assign) NSInteger firstPointX;

@property (weak, nonatomic) UISlider *volumeSlider;


@end
