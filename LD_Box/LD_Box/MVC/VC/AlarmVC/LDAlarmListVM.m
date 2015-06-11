//
//  LDAlarmListVM.m
//  LD_Box
//
//  Created by Jay on 15/6/12.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDAlarmListVM.h"
#import "LDBLEManager.h"


@interface LDAlarmListVM () <AlarmDelegate>

//对象准备就绪
@property (nonatomic, assign) BOOL isManagerReady;

//音箱功能状态
@property (nonatomic, assign) PlayStatus playState;

@end


@implementation LDAlarmListVM

#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


#pragma mark - Methods

- (void)start {
    [BLE_MANGER creatAlarmManager:self];
}


#pragma mark - AlarmDelegate

//对象准备就绪
-(void)managerReady:(UInt32)mode {
    
}

//闹铃状态变化
- (void)alarmStateChanged:(UInt32)state {
    
}
//获取到闹钟条目,列表对象
-(void)alarmListArrived:(NSMutableArray*)alarmList {
    
}


//获取到铃声条目{@link RingEntry}列表对象
-(void)ringListArrived:(NSMutableArray*)ringList {
    
}

//获取到铃声目录{@link FolderEntry}列表对象
-(void)folderListArrived:(NSMutableArray*)folderList {
    
}

@end
