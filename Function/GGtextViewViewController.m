//
//  GGtextViewViewController.m
//  iOSStrongDemo
//
//  Created by apple on 15/8/6.
//  Copyright (c) 2015年 LiGang. All rights reserved.
//

#import "GGtextViewViewController.h"
#import "GGPlaceholderTextView.h"
#define SCREEN [UIScreen mainScreen].bounds.size

@interface GGtextViewViewController ()<UITextViewDelegate>

@end

@implementation GGtextViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    
    //方法一
    UITextView *textViewPlaceholder = [[UITextView alloc] initWithFrame:CGRectMake(20, 70, SCREEN.width - 40, 100)];
    textViewPlaceholder.backgroundColor = [UIColor whiteColor];
    textViewPlaceholder.text = @"关注微信公众号iOS开发：iOSDevTip";
    textViewPlaceholder.textColor = [UIColor grayColor];
    textViewPlaceholder.delegate = self;
    [self.view addSubview:textViewPlaceholder];
    
 
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    tapGesture.numberOfTapsRequired = 1; //点击次数
    tapGesture.numberOfTouchesRequired = 1; //点击手指数
    [self.view addGestureRecognizer:tapGesture];
    
    
//    GGPlaceholderTextView *textView = [[GGPlaceholderTextView alloc] initWithFrame:CGRectMake(0, 64, SCREEN.width , 200)];
//    textView.backgroundColor = [UIColor whiteColor];
//    textView.placeholder = @"关注微信公众号iOS开发：iOSDevTip";
//    [self.view addSubview:textView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

//轻击手势触发方法
-(void)tapGesture:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"关注微信公众号iOS开发：iOSDevTip"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length<1) {
        textView.text = @"关注微信公众号iOS开发：iOSDevTip";
        textView.textColor = [UIColor grayColor];
    }
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
