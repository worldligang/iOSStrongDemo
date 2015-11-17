//
//  MDSegmentNavBarViewController.m
//  iOSStrongDemo
//
//  Created by ligang on 15/11/17.
//  Copyright © 2015年 LiGang. All rights reserved.
//

#import "MDSegmentNavBarViewController.h"

#define LIMIT 10
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN [UIScreen mainScreen].bounds.size

@interface MDSegmentNavBarViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UISegmentedControl      *_segmentedControl;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *mutableArray;
@property (nonatomic, assign) NSInteger limit;
@property (nonatomic, assign) NSInteger skip;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *tableViewTwo;
@property (nonatomic, strong) UITableView *tableViewThree;


@end

@implementation MDSegmentNavBarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!_segmentedControl)
    {
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"通知",@"评论",@"赞",nil];
        _segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
        [_segmentedControl setFrame:CGRectMake(SCREEN.width/2-160/2, 9, 160, 44)];
        _segmentedControl.selectedSegmentIndex = 0;
        _segmentedControl.backgroundColor = [UIColor clearColor];
        _segmentedControl.tintColor = [UIColor clearColor];
        [_segmentedControl addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor],NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica-Bold"size:18],NSFontAttributeName,nil];
        [_segmentedControl setTitleTextAttributes:dic forState:UIControlStateNormal];
        NSDictionary *dicS = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica-Bold"size:18],NSFontAttributeName ,nil];
        [_segmentedControl setTitleTextAttributes:dicS forState:UIControlStateSelected];
        self.navigationItem.titleView = _segmentedControl;
    }
    
    self.mutableArray = [NSMutableArray array];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 64, SCREEN.width, SCREEN.height - 64);
    [self.view addSubview:scrollView];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(SCREEN.width * 3, SCREEN.height - 64);
    self.scrollView = scrollView;
    self.scrollView.backgroundColor = [UIColor redColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, SCREEN.height - 64) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.scrollView addSubview:tableView];
    self.tableView = tableView;
    
    UITableView *tableViewTwo = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN.width, 0, SCREEN.width, SCREEN.height - 64) style:UITableViewStylePlain];
    tableViewTwo.dataSource = self;
    tableViewTwo.delegate = self;
    [self.scrollView addSubview:tableViewTwo];
    self.tableViewTwo = tableViewTwo;
    
    UITableView *tableViewThree = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN.width * 2, 0, SCREEN.width, SCREEN.height - 64) style:UITableViewStylePlain];
    tableViewThree.dataSource = self;
    tableViewThree.delegate = self;
    [self.scrollView addSubview:tableViewThree];
    self.tableViewThree = tableViewThree;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (void)segmentAction:(UISegmentedControl *)seg
{
    if (seg == _segmentedControl)
    {
        NSInteger index = seg.selectedSegmentIndex;
        NSLog(@"Index %li", (long)index);
        [UIView beginAnimations:@"animationID" context:nil];
        [UIView setAnimationDuration:0.5f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationRepeatAutoreverses:NO];
        self.scrollView.contentOffset = CGPointMake(SCREENWIDTH*index, 0);
        [UIView commitAnimations];
    }
}



#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"%f",scrollView.contentOffset.x);
    if (self.scrollView == scrollView)
    {
        _segmentedControl.selectedSegmentIndex = scrollView.contentOffset.x / SCREENWIDTH;
        if (scrollView.contentOffset.x == 0)
        {
            _segmentedControl.selectedSegmentIndex = 0;
            
        }
        else if (scrollView.contentOffset.x == SCREENWIDTH)
        {
            _segmentedControl.selectedSegmentIndex = 1;
        }
        else if (scrollView.contentOffset.x == SCREENWIDTH*2)
        {
            _segmentedControl.selectedSegmentIndex = 2;
        }
    }
}


#pragma mark UITableView datasource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellComments";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.commentObject = self.mutableArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
    
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        return 70;

    }else if(tableView == self.tableViewTwo){
        return 60;

    }else if(tableView == self.tableViewThree){
        return 50;
    }
    return 50;
}



@end
