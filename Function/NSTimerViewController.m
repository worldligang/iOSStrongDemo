//
//  NSTimerViewController.m
//  iOSStrongDemo
//
//  Created by apple on 15/7/10.
//  Copyright (c) 2015年 LiGang. All rights reserved.
//

#import "NSTimerViewController.h"

#define SCREEN [UIScreen mainScreen].bounds.size

@interface NSTimerViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *mutArray;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, assign) int number;

@end

@implementation NSTimerViewController {
    NSTimer *_timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.mutArray = [NSMutableArray arrayWithObjects:@"公众号iOS开发：iOSDevTip",@"www.superqq.com",@"公众号iOS开发：iOSDevTip",@"www.superqq.com",@"公众号iOS开发：iOSDevTip",@"刚刚在线博客：www.superqq.com",@"公众号iOS开发：iOSDevTip",@"刚刚在线博客：www.superqq.com",@"公众号iOS开发：iOSDevTip",@"刚刚在线博客：www.superqq.com",@"公众号iOS开发：iOSDevTip",@"刚刚在线博客：www.superqq.com",@"公众号iOS开发：iOSDevTip",@"刚刚在线博客：www.superqq.com",@"公众号iOS开发：iOSDevTip", nil];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, SCREEN.height) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    self.number = 0;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, SCREEN.width - 100, 50)];
    label.text = [NSString stringWithFormat:@"%d",self.number];
    label.backgroundColor = [UIColor purpleColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    self.label = label;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(actionTimer:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:UITrackingRunLoopMode];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

- (void)viewWillDisappear:(BOOL)animatied {
    [_timer invalidate];
}

- (void)actionTimer:(NSTimer *)timer
{
    self.number++;
    self.label.text = [NSString stringWithFormat:@"%d",self.number];
    NSLog(@"%d",self.number);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

@end
