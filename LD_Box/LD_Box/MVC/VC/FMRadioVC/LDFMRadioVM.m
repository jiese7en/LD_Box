//
//  LDFMRadioVM.m
//  LD_Box
//
//  Created by Jay on 15/6/12.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDFMRadioVM.h"
#import "LDBLEManager.h"

@interface LDFMRadioVM () <RadioDelegate>

//对象准备就绪
@property (nonatomic, assign) BOOL isManagerReady;

//音箱功能状态
@property (nonatomic, assign) PlayStatus playState;

@end

@implementation LDFMRadioVM

#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - Methods

- (void)start {
    [BLE_MANGER creatRadioManager:self];
}


#pragma mark - RadioDelegate

//对象准备就绪
-(void)managerReady:(UInt32)mode {
    
}

//电台列表
-(void)radioListChanged:(NSMutableArray*)channelList {
    
}

//收音机当前模式变化
-(void)radioStateChanged:(UInt32)state {
    
}

//当前电台频率变化
-(void)channelChanged:(UInt32)channel {
    
}

//收音机当前频段变化
-(void)bandChanged:(UInt32)band {
    
}

@end
