//
//  LDDevice.h
//  LD_Box
//
//  Created by Jay on 15/5/24.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef LD_Box_LDDevice_h
#define LD_Box_LDDevice_h

//屏幕的高度
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width


//当前的系统版本
#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define IS_IOS6 (SYSTEM_VERSION >= 6.0 && SYSTEM_VERSION < 7)
#define IS_IOS7 (SYSTEM_VERSION >= 7.0 && SYSTEM_VERSION < 8.0)
#define IS_IOS8 (SYSTEM_VERSION >= 8.0)

#define IS_LATER_IOS7 (SYSTEM_VERSION >= 7.0)
#define IS_BEFORE_IOS7 (SYSTEM_VERSION <= 7.0)


//设备的型号
#define IS_IPHONE [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
#define IS_PAD [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad

#define IS_IPHONE4 ([[UIScreen mainScreen] bounds].size.height == 480)
#define IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568)
#define IS_IPHONE6 ([[UIScreen mainScreen] bounds].size.height == 667)
#define IS_IPHONE6_PLUS ([[UIScreen mainScreen] bounds].size.height == 736)


//判断设备室真机还是模拟器
#if TARGET_OS_IPHONE
/** iPhone Device */
#endif

#if TARGET_IPHONE_SIMULATOR
/** iPhone Simulator */
#endif


//判断系统为64位还是32位
#if __LP64__
#else
#endif


#endif
