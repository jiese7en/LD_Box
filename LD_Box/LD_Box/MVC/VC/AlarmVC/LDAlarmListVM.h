//
//  LDAlarmListVM.h
//  LD_Box
//
//  Created by Jay on 15/6/12.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LDAlarmListVMDelegate <NSObject>

@end

@interface LDAlarmListVM : NSObject

@property (nonatomic, assign) id <LDAlarmListVMDelegate> delegate;


- (void)start;

@end
