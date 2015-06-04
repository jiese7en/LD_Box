//
//  LDBLEConnectVM.m
//  LD_Box
//
//  Created by Jay on 15/6/2.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDBLEConnectVM.h"


@interface LDBLEConnectVM () <ConnectDelegate, GlobalDelegate>



@end


@implementation LDBLEConnectVM


#pragma mark - property

- (BluzDevice *)bluzDevice {
    if (_bluzDevice) {
        return _bluzDevice;
    }
    _bluzDevice = [[BluzDevice alloc] init];
    [_bluzDevice setConnectDelegate:self];
    return _bluzDevice;
}

- (BluzManager *)bluzManager {
    if (_bluzManager) {
        return _bluzManager;
    }
    _bluzManager = [[BluzManager alloc] initWithConnector:self.bluzDevice];
    
    return _bluzManager;
}

- (id<GlobalManager>)globalManager {
    if (_globalManager) {
        return _globalManager;
    }
    _globalManager = [self.bluzManager getGlobalManager:self];
    
    return _globalManager;
}

- (NSMutableArray *)deviceArr {
    if (_deviceArr) {
        return _deviceArr;
    }
    _deviceArr = [[NSMutableArray alloc] initWithCapacity:0];
    return _deviceArr;
}


#pragma mark - Private Methods

- (void)featureSupport {
    BOOL isFeatureSupport = [self.globalManager isFeatureSupport:FeatureFolder];
    if (isFeatureSupport) {
        self.musicFolderArray = [self.globalManager getMusicFolder];
        if (self.musicFolderArray) {
            for (NSInteger i=0; i < self.musicFolderArray.count; i++) {
                
            }
        }
    }
}

- (void)featureRecPlayback {
    self.isSupportRecPlayback = [self.globalManager isFeatureSupport:FeatureRecPlayback];
    if (self.hasSDCard && self.isSupportRecPlayback) {
        
    }
    
    if (self.hasUhost && self.isSupportRecPlayback) {
        
    }
}

#pragma mark - Methods

- (void)scanStart {
    
    [self.deviceArr removeAllObjects];
    
    [self.bluzDevice scanStart];
    
}

- (void)connect:(LDBluzDeviceModel *)deviceModel {
    
    CBPeripheral *peripheral = deviceModel.peripheral;
    
    [self.bluzDevice connect:peripheral];
}

#pragma mark - ConnectDelegate

-(void)foundPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData {
    
    NSString *deviceName = [advertisementData objectForKey:CBAdvertisementDataLocalNameKey];
    
    if (deviceName && deviceName.length) {
        LDBluzDeviceModel *deviceModel = [[LDBluzDeviceModel alloc] init];
        deviceModel.deviceName = deviceName;
        deviceModel.peripheral = peripheral;
        
        [self.deviceArr addObject:deviceModel];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(foundPeripheralFinished)]) {
        [self.delegate foundPeripheralFinished];
    }
    
    
}

-(void)connectedPeripheral:(CBPeripheral*) peripheral {
    
    for (LDBluzDeviceModel *deviceModel in self.deviceArr) {
        if ([deviceModel isPeripheral:peripheral]) {
            self.curDeviceModel = deviceModel;
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(connectedPeripheralFinished)]) {
        [self.delegate connectedPeripheralFinished];
    }
    
    self.bluzManager = [[BluzManager alloc] initWithConnector:self.bluzDevice];
    self.globalManager = [self.bluzManager getGlobalManager:self];
    
}

-(void)disconnectedPeripheral:(CBPeripheral*) peripheral {
    
}

-(void)disconnectedPeripheral:(CBPeripheral*) peripheral initiative:(BOOL)onInitiative {
    
}


#pragma mark - GlobalDelegate

//对象准备就绪
-(void)managerReady {
    
    [self featureSupport];
    
    [self featureRecPlayback];
    
    self.isGlobalManagerReady = YES;
}

//音箱音效模式变化
-(void)soundEffectChanged:(UInt32)mode {
    
}

//EQ模式变化
-(void)eqModeChanged:(UInt32)mode {
    
}

//DAE音效模式变化
-(void)daeModeChangedWithVBASS:(BOOL)vbassEnable andTreble:(BOOL)trebleEnable {
    
}

//音箱电池电量或充放电状态变化
-(void)batteryChanged:(UInt32)battery charging:(BOOL)charging {
    
}

//音箱静音及音量状态变化
-(void)volumeChanged:(UInt32)current max:(UInt32)max min:(UInt32)min isMute:(BOOL)mute {
    
}

//音箱功能模式变化
-(void)modeChanged:(UInt32)mode {
    
}

//音箱外置卡插拔状态变化
-(void)hotplugCardChanged:(BOOL)visibility {
    
}

//音箱外置U盘插拔状态变化
-(void)hotplugUhostChanged:(BOOL)visibility {
    
}

//音箱Linein连接线插拔状态变化
-(void)lineinChanged:(BOOL)visibility {
    
}

//显示音箱对话框
-(void)dialogMessageArrived:(UInt32)type messageID:(UInt32)messageId {
    
}

//显示音箱提示信息
-(void)toastMessageArrived:(UInt32)messageId {
    
}

//取消音箱提示信息
-(void)dialogCancel {
    
}

//自定义命令回调
-(void)customCommandArrived:(UInt32)cmdKey param1:(UInt32)arg1 param2:(UInt32)arg2 others:(NSData*)data {
    
}
@end
