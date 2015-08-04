//
//  GGNavigationViewController.m
//  iOSStrongDemo
//
//  Created by apple on 15/8/1.
//  Copyright (c) 2015年 LiGang. All rights reserved.
//

#import "GGNavigationViewController.h"

@interface GGNavigationViewController ()

@end

@implementation GGNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(right:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"test"] style:UIBarButtonItemStylePlain target:self action:@selector(right:)];
    
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 60)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:testView];

    
//    self.navigationController.interactivePopGestureRecognizer.delegate = self;

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    
    self.title = @"iOS开发：iOSDevTip";
    
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)right:(id)sender
{
    NSLog(@"rightBarButtonItem");
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
