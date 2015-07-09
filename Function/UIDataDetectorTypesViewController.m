//
//  UIDataDetectorTypesViewController.m
//  iOSStrongDemo
//
//  Created by apple on 15/7/9.
//  Copyright (c) 2015年 LiGang. All rights reserved.
//

#import "UIDataDetectorTypesViewController.h"

@interface UIDataDetectorTypesViewController ()

@end

@implementation UIDataDetectorTypesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UITextView *textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    textView.dataDetectorTypes = UIDataDetectorTypeAll;
    textView.font = [UIFont systemFontOfSize:20];
    textView.editable = NO;
    textView.text = @"\r\n我的手机号不是： 13888888888 \r\n\r\n"
    "我的博客刚刚在线网址： www.superqq.com \r\n\r\n"
    "我的邮箱： worldligang@163.com \r\n\r\n"
    "\r\n\r\n\r\n\r\n\r\n\r\n微信公众号iOS开发：iOSDevTip";
    [self.view addSubview:textView];
    textView.textColor = [UIColor whiteColor];
    textView.backgroundColor = [UIColor purpleColor];

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
