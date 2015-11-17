//
//  ViewController.m
//  iOSStrongDemo
//
//  Created by apple on 15/7/9.
//  Copyright (c) 2015年 LiGang. All rights reserved.
//
//  iOS开发技术网站：http://www.superqq.com/
//  iOS开发微信公众号：iOSDevTip

#import "ViewController.h"
#import "UIWebViewViewController.h"
#import "UIDataDetectorTypesViewController.h"
#import "NSTimerViewController.h"
#import "NSStringViewController.h"
#import "GGSandBoxViewController.h"
#import "GGCropImageViewController.h"
#import "GGImageViewController.h"
#import "GGNavigationViewController.h"
#import "GGAlbumViewController.h"
#import "GGtextViewViewController.h"
#import "GGAccelerometerViewController.h"
#import "GGEdgesForExtendedLayoutViewController.h"

#define SCREEN [UIScreen mainScreen].bounds.size

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *mutArray;
@property (nonatomic, strong) UIButton *bottomButton;
@property (nonatomic, assign) CGFloat offsetY;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.mutArray = [NSMutableArray arrayWithObjects:@"EdgesForExtendedLayout",@"Accelerometer",@"UITextView",@"Album",@"Navigation", @"UIImage", @"CropImage",@"SandBox",@"System Setting",@"NSString", @"NSTimer",@"UIDataDetectorTypes",@"UIWebView",@"tast",@"test",@"test",@"test",@"test",@"test",@"test",@"test",@"test",@"test",@"test",@"test", nil];
    
    //用UITableView现实股票信息
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, SCREEN.height) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;

    self.bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bottomButton.frame = CGRectMake(SCREEN.width / 2 - 25, SCREEN.height - 50, 50, 50);
    [self.bottomButton setBackgroundImage:[UIImage imageNamed:@"bottom"] forState:UIControlStateNormal];
    [self.view addSubview:self.bottomButton];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"这是一个闪退" style:UIBarButtonItemStylePlain target:self action:@selector(actionClick:)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"1 - viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"1 - viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"1 - viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"1 - viewDidDisappear");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (void)actionClick:(UIButton *)button
{
    NSArray *array = [NSArray arrayWithObjects:@"1", nil];
    NSString *string = [array objectAtIndex:2];
    NSLog(@"%@",string);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //判断滑动到底部
    if (scrollView.contentOffset.y == scrollView.contentSize.height - self.tableView.frame.size.height) {
        [UIView transitionWithView:self.bottomButton duration:0.1 options:UIViewAnimationOptionTransitionNone animations:^{
            self.bottomButton.frame = CGRectMake(SCREEN.width / 2 - 25, SCREEN.height - 50, 50, 50);
        } completion:NULL];
    }
    
    if (scrollView.contentOffset.y > self.offsetY && scrollView.contentOffset.y > 0) {//如果当前位移大于缓存位移，说明scrollView向上滑动
        [UIView transitionWithView:self.bottomButton duration:0.1 options:UIViewAnimationOptionTransitionNone animations:^{
            self.bottomButton.frame = CGRectMake(SCREEN.width / 2 - 25, SCREEN.height, 50, 50);
        } completion:NULL];
    }else if (scrollView.contentOffset.y < self.offsetY){
        [UIView transitionWithView:self.bottomButton duration:0.1 options:UIViewAnimationOptionTransitionNone animations:^{
            self.bottomButton.frame = CGRectMake(SCREEN.width / 2 - 25, SCREEN.height - 50, 50, 50);
        } completion:NULL];
    }
    self.offsetY = scrollView.contentOffset.y;//将当前位移变成缓存位移
}


#pragma mark UITableView datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellUserSelect";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.mutArray[indexPath.row];
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *value = self.mutArray[indexPath.row];
    if ([value isEqualToString:@"UIWebView"]) {
        UIWebViewViewController *vc = [[UIWebViewViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([value isEqualToString:@"UIDataDetectorTypes"]){
        UIDataDetectorTypesViewController *vc = [[UIDataDetectorTypesViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([value isEqualToString:@"NSTimer"]){
        NSTimerViewController *vc = [[NSTimerViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([value isEqualToString:@"NSString"]){
        NSStringViewController *vc = [[NSStringViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([value isEqualToString:@"System Setting"]){
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    } else if ([value isEqualToString:@"SandBox"]){
        GGSandBoxViewController *vc = [[GGSandBoxViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([value isEqualToString:@"CropImage"]){
        GGCropImageViewController *vc = [[GGCropImageViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([value isEqualToString:@"UIImage"]){
        GGImageViewController *vc = [[GGImageViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([value isEqualToString:@"Navigation"]){
        GGNavigationViewController *vc = [[GGNavigationViewController alloc] init];
        self.navigationItem.title = @"";
        //        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
        //        [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
        //        self.navigationController.navigationBar.translucent = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([value isEqualToString:@"Album"]){
        GGAlbumViewController *vc = [[GGAlbumViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([value isEqualToString:@"UITextView"]){
        GGtextViewViewController *vc = [[GGtextViewViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([value isEqualToString:@"Accelerometer"]){
        GGAccelerometerViewController *vc = [[GGAccelerometerViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([value isEqualToString:@"EdgesForExtendedLayout"]){
        GGEdgesForExtendedLayoutViewController *vc = [[GGEdgesForExtendedLayoutViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

@end
