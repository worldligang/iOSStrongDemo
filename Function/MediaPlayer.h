//
//  MediaPlayer.h
//  iOSStrongDemo
//
//  Created by ligang on 15/11/17.
//  Copyright © 2015年 LiGang. All rights reserved.
//
#import <UIKit/UIKit.h>



@interface MediaPlayer : UIViewController
@property (copy, nonatomic) NSString *urlString;

@property (weak, nonatomic) UIButton *download_btn;
@property (weak, nonatomic) UIButton *rightButton;



@property (strong, nonatomic) NSString *shareUrlString;
@property (strong, nonatomic) NSString *sharePictureUrlString;
@property (assign, nonatomic) BOOL isLocal;
@end
