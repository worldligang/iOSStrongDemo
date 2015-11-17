//
//  GGAccelerometerViewController.m
//  iOSStrongDemo
//
//  Created by apple on 15/8/9.
//  Copyright (c) 2015年 LiGang. All rights reserved.
//

#import "GGAccelerometerViewController.h"
#import <CoreMotion/CoreMotion.h>  

@interface GGAccelerometerViewController ()<UIAccelerometerDelegate>

@end

@implementation GGAccelerometerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
//    accelerometer.delegate = self;
//    accelerometer.updateInterval = 0.1;
    self.view.backgroundColor = [UIColor whiteColor];

    CMMotionManager *motionManager = [[CMMotionManager alloc] init];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //加速计
    if (motionManager.accelerometerAvailable) {
        motionManager.accelerometerUpdateInterval = 0.1;
        [motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData *accelerometerData,NSError *error){
            if (error) {
                [motionManager stopAccelerometerUpdates];
                NSLog(@"error");
            }else{
                NSLog(@"x -> %f y - > %f z -> %f",accelerometerData.acceleration.x,accelerometerData.acceleration.y,accelerometerData.acceleration.z);
            }
        }];
    }else{
        NSLog(@"This device has no accelerometer");
    }
}

//- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration NS_DEPRECATED_IOS(2_0, 5_0)
//{
//    NSLog(@"x -> %f y - > %f z -> %f",accelerometer.x,accelerometer.y,accelerometer.z);
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
