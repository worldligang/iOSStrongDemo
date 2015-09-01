/*
 File:       Bugtags/Bugtags.h
 
 Contains:   API for using Bugtags's SDK.
 
 Copyright:  (c) 2015 by Bugtags, Ltd., all rights reserved.
 
 Version:    1.0.4
 */

#import "BTGConstants.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Bugtags : NSObject

/**
 * 初始化Bugtags
 * @param appKey - 通过bugtags.com申请的应用appKey
 * @param invocationEvent - 呼出方式
 * @return none
 */
+ (void)startWithAppKey:(NSString *)appKey invocationEvent:(BTGInvocationEventEvent)invocationEvent;

/**
 * Bugtags日志工具，添加自定义日志，不会在控制台输出
 * @param format
 * @param ...
 * @return none
 */
void BTGLog(NSString *format, ...);

/**
 * 设置是否收集Crash信息
 * @param trackingCrashes - 默认 YES
 * @return none
 */
+ (void)setTrackingCrashes:(BOOL)trackingCrashes;

/**
 * 设置是否跟踪用户操作步骤
 * @param trackingUserSteps - 默认 YES
 * @return none
 */
+ (void)setTrackingUserSteps:(BOOL)trackingUserSteps;

/**
 * 设置是否跟收集制台日志
 * @param trackingConsoleLog - 默认 YES
 * @return none
 */
+ (void)setTrackingConsoleLog:(BOOL)trackingConsoleLog;

/**
 * 设置自定义数据，会与问题一起提交
 * @param data
 * @param key
 * @return none
 */
+ (void)setUserData:(NSString *)data forKey:(NSString *)key;

/**
 * 移除指定key的自定义数据
 * @param key
 * @return none
 */
+ (void)removeUserDataForKey:(NSString *)key;

/**
 * 移除所有自定义数据
 * @return none
 */
+ (void)removeAllUserData;

/**
 * 手动发送Exception
 * @param exception
 * @return none
 */
+ (void)sendException:(NSException *)exception;

/**
 * 发送用户反馈
 * @param content - 反馈内容
 * @return none
 */
+ (void)sendFeedback:(NSString *)content;

@end