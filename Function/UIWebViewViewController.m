//
//  UIWebViewViewController.m
//  iOSStrongDemo
//
//  Created by apple on 15/7/9.
//  Copyright (c) 2015年 LiGang. All rights reserved.
//
//  iOS开发技术网站：http://www.superqq.com/
//  iOS开发微信公众号：iOSDevTip


#import "UIWebViewViewController.h"

#define SCREEN [UIScreen mainScreen].bounds.size

@interface UIWebViewViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation UIWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.delegate = self;
    webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    webView.dataDetectorTypes = UIDataDetectorTypePhoneNumber;//自动检测网页上的电话号码，单击可以拨打
    [self.view addSubview:webView];
    self.webView = webView;
    
    //1
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.superqq.com"]];
    [webView loadRequest:request];
    
    
    //    //2
    //    NSString *path = [[NSBundle mainBundle] pathForResource:@"swift" ofType:@"html"];
    //    NSURL* url = [NSURL   fileURLWithPath:path];//创建URL
    //    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    //    [webView loadRequest:request];//加载
    
    //3
    //    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    //    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //    [webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:path]];
    
    
    NSArray *array = [NSArray arrayWithObjects:@"加载",@"停止",@"返回",@"前进", nil];
    int far = (SCREEN.width - 200)/5;
    for (int i = 0; i < array.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake( (i + 1) * far + 50 * i, SCREEN.height - 60, 50, 40);
        button.tag = 200 + i;
        [button addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor orangeColor]];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [self.view addSubview:button];
    }
    
    
    
}

- (void)actionClick:(UIButton *)button
{
    switch (button.tag) {
        case 200:
        {
            [self.webView reload];//加载
        }
            break;
        case 201:
        {
            [self.webView stopLoading];//停止加载
        }
            break;
        case 202:
        {
            [self.webView goBack];//返回
        }
            break;
        case 203:
        {
            [self.webView goForward];//前进
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //返回YES，进行加载。通过UIWebViewNavigationType可以得到请求发起的原因
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //开始加载，可以加上风火轮（也叫菊花）
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //完成加载
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //加载出错
}


@end
