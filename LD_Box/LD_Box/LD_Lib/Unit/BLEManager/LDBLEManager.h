//
//  LDBluzManager.h
//  LD_Box
//
//  Created by Jay on 15/6/8.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BluzDevice.h"
#import "BluzManager.h"
#import "GlobalManager.h"
#import "LDBluzDeviceModel.h"

#define BLE_MANGER [LDBLEManager sharedInstance]


@interface LDBLEManager : NSObject

//单例
+ (LDBLEManager *)sharedInstance;


#pragma mark - Manager

@property (nonatomic, strong) BluzDevice *bluzDevice;

@property (nonatomic, strong) BluzManager *bluzManager;

@property (strong, nonatomic) id <GlobalManager> globalManager;

@property (strong, nonatomic) id <MusicManager> musicManager;

@property (strong, nonatomic) id <AuxManager> auxManager;

@property (strong, nonatomic) id <AlarmManager> alarmManager;

@property (strong, nonatomic) id <RadioManager> radioManager;

#pragma mark - 

//当前连接的设备
@property (nonatomic, strong) LDBluzDeviceModel *curDeviceModel;


#pragma mark - Set Manager Delegate

- (void)creatGlobalManager:(id <GlobalDelegate>)delegate;

- (void)creatMusicManager:(id <MusicDelegate>)delegate;

- (void)creatAuxManager:(id <AuxDelegate>)delegate;

- (void)creatAlarmManager:(id <AlarmDelegate>)delegate;

- (void)creatRadioManager:(id <RadioDelegate>)delegate;




@end
