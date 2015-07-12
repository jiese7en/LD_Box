//
//  LDBLEConnectVM.m
//  LD_Box
//
//  Created by Jay on 15/6/2.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDBLEConnectVM.h"
#import "LDBLEManager.h"
#import "LDNotificationName.h"
#import "NSArray+LDCategory.h"

@interface LDBLEConnectVM () <ConnectDelegate>

//用户主动断开连接
@property (nonatomic, assign) BOOL isUserDisconnected;

//是否正在扫描
@property (nonatomic, assign) BOOL isSearchBT;

@end


@implementation LDBLEConnectVM

#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        [BLE_MANGER.bluzDevice setConnectDelegate:self];
        [BLE_MANGER.bluzDevice setAppForeground:YES];
        
        self.isUserDisconnected = NO;
        self.isSearchBT = NO;
        
    }
    return self;
}



#pragma mark - property

- (NSMutableArray *)deviceArr {
    if (_deviceArr) {
        return _deviceArr;
    }
    _deviceArr = [[NSMutableArray alloc] initWithCapacity:0];
    return _deviceArr;
}



#pragma mark - Methods

- (void)start {
    
}

- (void)scanStart {
    
    [self.deviceArr removeAllObjects];
    
    [BLE_MANGER.bluzDevice scanStart];
    
}

- (void)connect:(LDBluzDeviceModel *)deviceModel {
    
    CBPeripheral *peripheral = deviceModel.peripheral;
    
    [BLE_MANGER.bluzDevice connect:peripheral];
}

- (void)disconnect {
    
    self.isUserDisconnected = YES;
    
    [BLE_MANGER.bluzDevice disconnect:BLE_MANGER.curDeviceModel.peripheral];
}

#pragma mark - ConnectDelegate

-(void)foundPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData {
    
    NSString *deviceName = [advertisementData objectForKey:CBAdvertisementDataLocalNameKey];
    
    if (deviceName && deviceName.length) {
        LDBluzDeviceModel *deviceModel = [[LDBluzDeviceModel alloc] init];
        deviceModel.deviceName = deviceName;
        deviceModel.peripheral = peripheral;
        
        [self.deviceArr addObject:deviceModel];
        
        self.deviceArr = [NSArray sortDeviceArr:self.deviceArr];
    }
    
    // 长时间播放有几率会断开BLE，此时重新尝试连接
    if (BLE_MANGER.curDeviceModel && !self.isUserDisconnected) {
        CBPeripheral *device = BLE_MANGER.curDeviceModel.peripheral;
        if (device && device.identifier.UUIDString == peripheral.identifier.UUIDString) {
            [self connect:BLE_MANGER.curDeviceModel];
        }        
    }
    
    self.isSearchBT = NO;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(foundPeripheralFinished)]) {
        [self.delegate foundPeripheralFinished];
    }
    
    
}

-(void)connectedPeripheral:(CBPeripheral*) peripheral {
    
    for (LDBluzDeviceModel *deviceModel in self.deviceArr) {
        if ([deviceModel isPeripheral:peripheral]) {
            BLE_MANGER.curDeviceModel = deviceModel;
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(connectedPeripheralFinished)]) {
        [self.delegate connectedPeripheralFinished];
    }
    
    self.isUserDisconnected = NO;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_Connected_Peripheral object:nil];

    
}

-(void)disconnectedPeripheral:(CBPeripheral*) peripheral {
    
    BLE_MANGER.curDeviceModel = nil;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(disconnectedPeripheralFinished)]) {
        [self.delegate disconnectedPeripheralFinished];
    }
}

-(void)disconnectedPeripheral:(CBPeripheral*) peripheral initiative:(BOOL)onInitiative {
    
    BLE_MANGER.curDeviceModel = nil;
    
    self.isUserDisconnected = onInitiative;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(disconnectedPeripheralFinished:)]) {
        [self.delegate disconnectedPeripheralFinished:onInitiative];
    }
}



@end
