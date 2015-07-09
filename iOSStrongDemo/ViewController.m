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

#define SCREEN [UIScreen mainScreen].bounds.size

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *mutArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.mutArray = [NSMutableArray arrayWithObjects:@"UIWebView",@"UIDataDetectorTypes", nil];
    
    //用UITableView现实股票信息
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, SCREEN.height) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
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
    NSString *value = self.mutArray[indexPath.row];
    if ([value isEqualToString:@"UIWebView"]) {
        UIWebViewViewController *vc = [[UIWebViewViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([value isEqualToString:@"UIDataDetectorTypes"]){
        UIDataDetectorTypesViewController *vc = [[UIDataDetectorTypesViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

@end
