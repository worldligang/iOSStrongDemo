//
//  GGInterfaceOrientationViewController.m
//  iOSStrongDemo
//
//  Created by ligang on 15/12/7.
//  Copyright © 2015年 LiGang. All rights reserved.
//

#import "GGInterfaceOrientationViewController.h"

@interface GGInterfaceOrientationViewController ()

@end

@implementation GGInterfaceOrientationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *orientationKey = NSStringFromSelector(@selector(orientation));
    [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeRight) forKey:orientationKey];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate{
    return YES;
}
//支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
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
