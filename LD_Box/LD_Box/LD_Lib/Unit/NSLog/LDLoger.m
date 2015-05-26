//
//  LDLoger.m
//  LD_Box
//
//  Created by Jay on 15-5-21.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDLoger.h"
#import <UIKit/UIKit.h>

@implementation LDLoger


+ (void)redirectNSlogToDocumentFolder
{
    
    // 将打印信息写入文件
    if ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone Simulator"]) {
        return ;
    }
    
    if (isatty(STDOUT_FILENO))
    {
        NSLog(@"真机调试，无需将打印信息写入文件.");
        return;
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"RuntimeInfo.log"];
    NSString *logFilePath = [documentDirectory stringByAppendingPathComponent:fileName];
    // 先删除已经存在的文件
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    [defaultManager removeItemAtPath:logFilePath error:nil];
    
    // 将log输入到文件
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
}

@end
