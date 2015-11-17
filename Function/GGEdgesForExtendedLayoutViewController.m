//
//  GGEdgesForExtendedLayoutViewController.m
//  iOSStrongDemo
//
//  Created by ligang on 15/10/9.
//  Copyright © 2015年 LiGang. All rights reserved.
//

#import "GGEdgesForExtendedLayoutViewController.h"
#define SCREEN [UIScreen mainScreen].bounds.size

@interface GGEdgesForExtendedLayoutViewController ()

@end

@implementation GGEdgesForExtendedLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"测试";
    
    self.view.backgroundColor = [UIColor purpleColor];

    self.navigationController.navigationBar.translucent = NO;
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;

    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 0, SCREEN.width - 20, 88);
    label.backgroundColor = [UIColor redColor];
    label.text = @"iOS开发：iOSDevTip";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"2 - viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"2 - viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"2 - viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"2 - viewDidDisappear");
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
