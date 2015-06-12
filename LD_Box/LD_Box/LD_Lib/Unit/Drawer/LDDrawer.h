//
//  LDDrawer.h
//  LD_Box
//
//  Created by Jay on 15/5/29.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LDDrawerVC.h"


@interface LDDrawer : NSObject

//单例
+ (LDDrawer *)sharedInstance;

//创建Drawer
+ (LDDrawerVC *)createDrawer;

@end
