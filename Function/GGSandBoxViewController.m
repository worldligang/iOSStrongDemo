//
//  GGSandBoxViewController.m
//  iOSStrongDemo
//
//  Created by apple on 15/7/22.
//  Copyright (c) 2015年 LiGang. All rights reserved.
//

#import "GGSandBoxViewController.h"

@interface GGSandBoxViewController ()

@end

@implementation GGSandBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    //沙盒根目录
//    NSString *directory = NSHomeDirectory();
//    NSLog(@"directory:%@", directory);
    
    
//    //获取Documents路径
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *path = [paths objectAtIndex:0];
//    NSLog(@"path:%@", path);
    
    
//    //获取Library路径
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
//    NSString *path = [paths objectAtIndex:0];
//    NSLog(@"path：%@", path);

//    //获取Caches路径
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    NSString *path = [paths objectAtIndex:0];
//    NSLog(@"path：%@", path);
 
    
    NSString *tmp = NSTemporaryDirectory();
    NSLog(@"tmp：%@", tmp);
    
}

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
