//
//  LDDevice.h
//  LD_Box
//
//  Created by Jay on 15/5/24.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#ifndef LD_Box_LDDevice_h
#define LD_Box_LDDevice_h


//当前的系统版本
#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define IS_IOS6 (SYSTEM_VERSION >= 6.0 && SYSTEM_VERSION < 7)
#define IS_IOS7 (SYSTEM_VERSION >= 7.0 && SYSTEM_VERSION < 8.0)
#define IS_IOS8 (SYSTEM_VERSION >= 8.0)

#define IS_LATER_IOS7 (SYSTEM_VERSION >= 7.0)
#define IS_BEFORE_IOS7 (SYSTEM_VERSION <= 7.0)

#endif
