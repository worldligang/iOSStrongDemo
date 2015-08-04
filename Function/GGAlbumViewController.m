//
//  GGAlbumViewController.m
//  iOSStrongDemo
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 LiGang. All rights reserved.
//

#import "GGAlbumViewController.h"

#define SCREEN [UIScreen mainScreen].bounds.size

@interface GGAlbumViewController ()

@property (nonatomic, strong) UIImage *image;

@end

@implementation GGAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];

    
    self.image = [UIImage imageNamed:@"iOSDevTip"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN.width - 300) / 2, 70, 300, 150)];
    imageView.image = self.image;
    [self.view addSubview:imageView];
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake( 100, 300, SCREEN.width - 200, 40);
    [button addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor orangeColor]];
    [button setTitle:@"SavePhoto" forState:UIControlStateNormal];
    [self.view addSubview:button];
}



- (void)actionClick:(UIButton *)button
{
    UIImageWriteToSavedPhotosAlbum(self.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);

}

// 指定回调方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if(!error){
        NSLog(@"save success");
    }else{
        NSLog(@"save failed");
    }
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
