//
//  NSStringViewController.m
//  iOSStrongDemo
//
//  Created by apple on 15/7/11.
//  Copyright (c) 2015年 LiGang. All rights reserved.
//

#import "NSStringViewController.h"

@interface NSStringViewController ()

@end

@implementation NSStringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];

//    //常量字符串
//    NSString *string = @"i am a string!";
    
//    //**常用创建方法**
//    NSString *string = [[NSString alloc] init];
//    string = @"i am a string too!";
    
//    //用initWithString创建字符串
//    NSString *string = [[NSString alloc] initWithString:@"string is here!"];
    
    //格式化创建字符串
//    int age = 20;
//    NSString *personAge = [NSString stringWithFormat:@"this person age is %d",age];
   
//    NSString *name = @"LiGang";
//    NSString *personName = [NSString stringWithFormat:@"this person name is %@",name];
    
//    //比较字符串
//    NSString *stingOne = @"This is a book!";
//    NSString *stringTwo = @"This is a book!";
////    BOOL result = [stingOne isEqualToString:stringTwo];
//    
//    BOOL result = [stingOne compare:stringTwo] == NSOrderedSame;    //NSOrderedSame判断两者内容是否相同

    //字符串大小写转换
//    NSString *string = @"This is a lowercaseString!";
//    [string lowercaseString];
    
//    NSString *string = @"This is a uppercaseString!";
//    [string uppercaseString];
//
    
//    NSString *string = @"This is a operation string!";
//    NSString *subToString = [string substringToIndex:6];
//
//    NSString *subFromString = [string substringFromIndex:6];
//    
//    NSString *rangeString = [string substringWithRange:NSMakeRange(6, 3)];

//    NSString *string1 = @"This is a string";
//    
//    NSString *string2 = @"string";
//    
//    NSRange range = [string1 rangeOfString:string2].location;
    
    
    
//    NSString *string1 = @"This is a iOSDevTip";
//    NSString *string2 = @"iOSDevTip";
//    NSRange range = [string1 rangeOfString:string2];
//    NSInteger location = range.location;
//    NSInteger leight = range.length;
//    NSString *logString = [[NSString alloc] initWithString:[NSString stringWithFormat:@"Location:%ld,Leight:%ld",location,leight]];
//    NSLog(@"astring:%@",logString);
    
//    //分割字符串
//    NSString *string = @"This is a iOSDevTip";
//    NSArray *array = [string componentsSeparatedByString:@"a"];
//    NSString *string1 = [array objectAtIndex:0];
//    NSString *string2 = [array objectAtIndex:1];
//    NSLog(@"string1:%@  string2:%@",string1,string2);
    
    
  
    
//    //追加字符串
//    NSMutableString *string = [[NSMutableString alloc] initWithString:@"I Love "];
//    [string appendString:@"China"];
//    NSLog(@"string:%@",string);

//    //插入字符串
//    NSMutableString *string = [[NSMutableString alloc] initWithString:@"I China"];
//    [string insertString:@"Love " atIndex:2];
//    NSLog(@"string: %@",string);

//    //删除字符串
//    NSMutableString *string = [[NSMutableString alloc] initWithString:@"I love China"];
//    [string deleteCharactersInRange:NSMakeRange(2, 4)];
//    NSLog(@"String1: %@",string);
    
//    //判断是否包含前后缀
//    NSString *string = @"I love China";
//    BOOL isHasI = [string hasPrefix:@"I"];
//    BOOL isHasChina = [string hasSuffix:@"China"];

//    //替换字符串
//    NSString *string = @"I love China";
//    NSString *replaceString = [string stringByReplacingOccurrencesOfString:@"love" withString:@"like"];
//    NSLog(@"replaceString:  %@",replaceString);
    
//    //去除字符串首尾的空格和换行符
//    NSString *string = @" I love China ";
//    NSString *text = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    NSLog(@"text:%@",text);
    
    
    //首字母大写
    NSString *string = @"ligang";
    NSLog(@"string: %@",[string capitalizedString]);

    
    
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
