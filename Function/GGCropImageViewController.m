//
//  GGCropImageViewController.m
//  iOSStrongDemo
//
//  Created by ligang on 15/7/24.
//  Copyright (c) 2015年 LiGang. All rights reserved.
//

#import "GGCropImageViewController.h"
#import "UIImage+Crop.h"
#import "XYAutoSimplingShowView.h"
#define SCREEN [UIScreen mainScreen].bounds.size

@interface GGCropImageViewController ()

@end

@implementation GGCropImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    NSMutableArray *mutablrArray = [NSMutableArray array];
    [mutablrArray addObject:[UIImage imageNamed:@"test.jpg"]];
    [mutablrArray addObject:[UIImage imageNamed:@"test2.jpg"]];
    XYAutoSimplingShowView *showView = [[XYAutoSimplingShowView alloc] init];
    showView.frame = CGRectMake(0, 64, SCREEN.width, SCREEN.width/4*3);
    showView.backgroundColor = [UIColor orangeColor];
    showView.imageArray = mutablrArray;
    [showView autoSimplingViewWithStyle:XYSimplingStyleTwoCenter];
    [self.view addSubview:showView];
    
//    UIImage *image = [UIImage imageNamed:@"ganggang"];
//    [image imageByCroppingWithStyle:XYCropImageStyleLeft];
//    [image imageByCroppingWithStyle:XYCropImageStyleCenter];
//    [image imageByCroppingWithStyle:XYCropImageStyleRight];
//    [image imageByCroppingWithStyle:XYCropImageStyleLeftOneOfThird];
//    [image imageByCroppingWithStyle:XYCropImageStyleCenterOneOfThird];
//    [image imageByCroppingWithStyle:XYCropImageStyleRightOneOfThird];
//    [image imageByCroppingWithStyle:XYCropImageStyleLeftQuarter];
//    [image imageByCroppingWithStyle:XYCropImageStyleCenterLeftQuarter];
//    [image imageByCroppingWithStyle:XYCropImageStyleCenterRightQuarter];
//    [image imageByCroppingWithStyle:XYCropImageStyleRightQuarter];

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
