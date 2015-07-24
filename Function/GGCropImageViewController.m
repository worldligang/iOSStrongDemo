//
//  GGCropImageViewController.m
//  iOSStrongDemo
//
//  Created by ligang on 15/7/24.
//  Copyright (c) 2015年 LiGang. All rights reserved.
//

#import "GGCropImageViewController.h"
#import "UIImage+Crop.h"

@interface GGCropImageViewController ()

@end

@implementation GGCropImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    UIImage *image = [UIImage imageNamed:@"ganggang"];
    [image imageByCroppingWithStyle:XYCropImageStyleLeft];
    [image imageByCroppingWithStyle:XYCropImageStyleCenter];
    [image imageByCroppingWithStyle:XYCropImageStyleRight];
    [image imageByCroppingWithStyle:XYCropImageStyleLeftOneOfThird];
    [image imageByCroppingWithStyle:XYCropImageStyleCenterOneOfThird];
    [image imageByCroppingWithStyle:XYCropImageStyleRightOneOfThird];
    [image imageByCroppingWithStyle:XYCropImageStyleLeftQuarter];
    [image imageByCroppingWithStyle:XYCropImageStyleCenterLeftQuarter];
    [image imageByCroppingWithStyle:XYCropImageStyleCenterRightQuarter];
    [image imageByCroppingWithStyle:XYCropImageStyleRightQuarter];

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
