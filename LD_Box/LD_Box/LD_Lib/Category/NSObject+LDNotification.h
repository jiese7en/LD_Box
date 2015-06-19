//
//  NSObject+LDNotification.h
//  LD_Box
//
//  Created by Jay on 15/6/12.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSNotification(LDNotification)

- (BOOL)is:(NSString *)name;
- (BOOL)isKindOf:(NSString *)prefix;

@end



@interface NSObject (LDNotification)

+ (NSString *)NOTIFICATION;

// 处理通知
- (void)handleNotification:(NSNotification *)notification;

// 注册观察者
- (void)observeNotification:(NSString *)name;

// 反注册观察者
- (void)unobserveNotification:(NSString *)name;

// 反注册所有通知
- (void)unobserveAllNotifications;

// 发送通知
- (void)postNotification:(NSString *)name;

// 发送通知 with 对象
- (void)postNotification:(NSString *)name withObject:(NSObject *)object;


@end
