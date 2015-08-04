//
//  GGAlbumViewController.m
//  iOSStrongDemo
//
//  Created by apple on 15/8/3.
//  Copyright (c) 2015年 LiGang. All rights reserved.
//

#import "GGAlbumViewController.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"

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
    
    UIButton *buttonSaveAlbum = [[UIButton alloc] init];
    buttonSaveAlbum.frame = CGRectMake( 100, 360, SCREEN.width - 200, 40);
    [buttonSaveAlbum addTarget:self action:@selector(createAlbum:) forControlEvents:UIControlEventTouchUpInside];
    [buttonSaveAlbum setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [buttonSaveAlbum setBackgroundColor:[UIColor orangeColor]];
    [buttonSaveAlbum setTitle:@"CreateAlbum" forState:UIControlStateNormal];
    [self.view addSubview:buttonSaveAlbum];
}

- (void)createAlbum:(UIButton *)button
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library saveImage:self.image toAlbum:@"gang" completion:^(NSURL *assetURL, NSError *error) {
        if (!error) {
            
        }
    } failure:^(NSError *error) {
        if (error) {
            
        }
    }];
    
//    [self getGroup];
//    [self savedLibrayImage:self.image];
    //添加到相册我让它执行是异步执行的方式，如果不想用这种方式，可以不去开一个线程
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self createAlbum];
        
    });
}

#pragma mark - 创建相册
- (void)createAlbum
{
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    NSMutableArray *groups=[[NSMutableArray alloc]init];
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop)
    {
        if (group)
        {
            [groups addObject:group];
        }
        
        else
        {
            BOOL haveHDRGroup = NO;
            
            for (ALAssetsGroup *gp in groups)
            {
                NSString *name =[gp valueForProperty:ALAssetsGroupPropertyName];
                
                if ([name isEqualToString:@"iOSDevTip"])
                {
                    haveHDRGroup = YES;
                }
            }
            
            if (!haveHDRGroup)
            {
                //do add a group named "XXXX"
                [assetsLibrary addAssetsGroupAlbumWithName:@"iOSDevTip"
                                               resultBlock:^(ALAssetsGroup *group)
                 {
                     [groups addObject:group];
                     
                 }
                                              failureBlock:nil];
                haveHDRGroup = YES;
            }
        }
        
    };
    //创建相簿
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:listGroupBlock failureBlock:nil];
    
    [self saveToAlbumWithMetadata:nil imageData:UIImagePNGRepresentation(self.image) customAlbumName:@"iOSDevTip" completionBlock:^
     {
         //这里可以创建添加成功的方法
         
     }
                     failureBlock:^(NSError *error)
     {
         //处理添加失败的方法显示alert让它回到主线程执行，不然那个框框死活不肯弹出来
         dispatch_async(dispatch_get_main_queue(), ^{
             
             //添加失败一般是由用户不允许应用访问相册造成的，这边可以取出这种情况加以判断一下
             if([error.localizedDescription rangeOfString:@"User denied access"].location != NSNotFound ||[error.localizedDescription rangeOfString:@"用户拒绝访问"].location!=NSNotFound){
                 UIAlertView *alert=[[UIAlertView alloc]initWithTitle:error.localizedDescription message:error.localizedFailureReason delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles: nil];
                 
                 [alert show];
             }
         });
     }];
}

- (void)saveToAlbumWithMetadata:(NSDictionary *)metadata
                      imageData:(NSData *)imageData
                customAlbumName:(NSString *)customAlbumName
                completionBlock:(void (^)(void))completionBlock
                   failureBlock:(void (^)(NSError *error))failureBlock
{
    
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    __weak ALAssetsLibrary *weakSelf = assetsLibrary;
    void (^AddAsset)(ALAssetsLibrary *, NSURL *) = ^(ALAssetsLibrary *assetsLibrary, NSURL *assetURL) {
        [assetsLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset) {
            [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                
                if ([[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:customAlbumName]) {
                    [group addAsset:asset];
                    if (completionBlock) {
                        completionBlock();
                    }
                }
            } failureBlock:^(NSError *error) {
                if (failureBlock) {
                    failureBlock(error);
                }
            }];
        } failureBlock:^(NSError *error) {
            if (failureBlock) {
                failureBlock(error);
            }
        }];
    };
    [assetsLibrary writeImageDataToSavedPhotosAlbum:imageData metadata:metadata completionBlock:^(NSURL *assetURL, NSError *error) {
        if (customAlbumName) {
            [assetsLibrary addAssetsGroupAlbumWithName:customAlbumName resultBlock:^(ALAssetsGroup *group) {
                if (group) {
                    [weakSelf assetForURL:assetURL resultBlock:^(ALAsset *asset) {
                        [group addAsset:asset];
                        if (completionBlock) {
                            completionBlock();
                        }
                    } failureBlock:^(NSError *error) {
                        if (failureBlock) {
                            failureBlock(error);
                        }
                    }];
                } else {
                    AddAsset(weakSelf, assetURL);
                }
            } failureBlock:^(NSError *error) {
                AddAsset(weakSelf, assetURL);
            }];
        } else {
            if (completionBlock) {
                completionBlock();
            }
        }
    }];
}


-(void)savedLibrayImage:(UIImage *)image
{
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library addAssetsGroupAlbumWithName:@"test" resultBlock:^(ALAssetsGroup *group) {
        
        //创建相簿成功
        
    } failureBlock:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"存储失败"
                                                       message:@"请打开 设置-隐私-照片 来进行设置"
                                                      delegate:nil
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil, nil];
        [alert show];
    }];
    
    
//    ALAssetsLibrary *library = [[ALAssetsLibrary alloc]init];
//    [library writeImageToSavedPhotosAlbum:image.CGImage orientation:(ALAssetOrientation)image.imageOrientation completionBlock:^(NSURL *asSetUrl,NSError *error){
//        if (error) {
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"存储失败"
//                                                           message:@"请打开 设置-隐私-照片 来进行设置"
//                                                          delegate:nil
//                                                 cancelButtonTitle:@"确定"
//                                                 otherButtonTitles:nil, nil];
//            [alert show];
//        }else{
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"存储成功"
//                                                           message:nil
//                                                          delegate:nil
//                                                 cancelButtonTitle:@"确定"
//                                                 otherButtonTitles:nil, nil];
//            [alert show];
//            
//        }
//    }];
    
}



-(void)getGroup
{
    @autoreleasepool
    {
        NSMutableArray *groupArray = [[NSMutableArray alloc] init];

        ALAssetsLibraryAccessFailureBlock failureblock =
        ^(NSError *myerror)
        {
            NSLog(@"相册访问失败 =%@", [myerror localizedDescription]);
            if ([myerror.localizedDescription rangeOfString:@"Global denied access"].location!=NSNotFound) {
                NSLog(@"无法访问相册.请在'设置->定位服务'设置为打开状态.");
            }else{
                NSLog(@"相册访问失败.");
            }
        };
        
        ALAssetsLibraryGroupsEnumerationResultsBlock
        libraryGroupsEnumeration = ^(ALAssetsGroup* group,BOOL* stop)
        {
            if (group!=nil)
            {
                [groupArray addObject:group];
            }
            else
            {
//                if (!_groupTable)
//                {
//                    _groupTable = [[UITableView alloc] initWithFrame:EZRECT(0, 0, SCREEN_SIZE_WIDTH, SCREEN_SIZE_HEIGHT - 44)
//                                                               style:UITableViewStylePlain];
//                    _groupTable.delegate = self;
//                    _groupTable.dataSource = self;
//                    [self.view addSubview:_groupTable];
//                }
//                [_groupTable performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
            }
        };
    }
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
