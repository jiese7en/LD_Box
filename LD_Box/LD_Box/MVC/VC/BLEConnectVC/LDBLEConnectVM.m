//
//  LDBLEConnectVM.m
//  LD_Box
//
//  Created by Jay on 15/6/2.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDBLEConnectVM.h"
#import "NSString+LDCategory.h"
#import "LDBLEManager.h"

@interface LDBLEConnectVM () <ConnectDelegate, GlobalDelegate>



@end


@implementation LDBLEConnectVM

#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        [BLE_MANGER.bluzDevice setConnectDelegate:self];
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


#pragma mark - Private Methods

- (void)featureSupport {
    self.isFeatureSupport = [BLE_MANGER.globalManager isFeatureSupport:FeatureFolder];
    if (self.isFeatureSupport) {
        self.musicFolderArray = [BLE_MANGER.globalManager getMusicFolder];
        if (self.musicFolderArray) {
            for (NSInteger i=0; i < self.musicFolderArray.count; i++) {
                
            }
        }
    }
}

- (void)featureRecPlayback {
    self.isSupportRecPlayback = [BLE_MANGER.globalManager isFeatureSupport:FeatureRecPlayback];
    if (self.hasSDCard && self.isSupportRecPlayback) {
        
    }
    
    if (self.hasUhost && self.isSupportRecPlayback) {
        
    }
}

#pragma mark - Methods

- (void)scanStart {
    
    [self.deviceArr removeAllObjects];
    
    [BLE_MANGER.bluzDevice scanStart];
    
}

- (void)connect:(LDBluzDeviceModel *)deviceModel {
    
    CBPeripheral *peripheral = deviceModel.peripheral;
    
    [BLE_MANGER.bluzDevice connect:peripheral];
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
    
    [BLE_MANGER creatGlobalManager:self];
    
}

-(void)disconnectedPeripheral:(CBPeripheral*) peripheral {
    if (self.delegate && [self.delegate respondsToSelector:@selector(disconnectedPeripheralFinished)]) {
        [self.delegate disconnectedPeripheralFinished];
    }
}

-(void)disconnectedPeripheral:(CBPeripheral*) peripheral initiative:(BOOL)onInitiative {
    if (self.delegate && [self.delegate respondsToSelector:@selector(disconnectedPeripheralFinished:)]) {
        [self.delegate disconnectedPeripheralFinished:onInitiative];
    }
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
    self.soundEffect = mode;
}

//EQ模式变化
-(void)eqModeChanged:(UInt32)mode {
    self.eqMode = mode;
}

//DAE音效模式变化
-(void)daeModeChangedWithVBASS:(BOOL)vbassEnable andTreble:(BOOL)trebleEnable {
    self.vbassEnable = vbassEnable;
    self.trebleEnable = trebleEnable;
}

//音箱电池电量或充放电状态变化
-(void)batteryChanged:(UInt32)battery charging:(BOOL)charging {
    //电池电量状态
    //充放电状态
}

//音箱静音及音量状态变化
-(void)volumeChanged:(UInt32)current max:(UInt32)max min:(UInt32)min isMute:(BOOL)mute {
    
}

//音箱功能模式变化
-(void)modeChanged:(UInt32)mode {
    self.funcMode = mode;
}

//音箱外置卡插拔状态变化
-(void)hotplugCardChanged:(BOOL)visibility {
    self.hasSDCard = visibility;
}

//音箱外置U盘插拔状态变化
-(void)hotplugUhostChanged:(BOOL)visibility {
    self.hasUhost = visibility;
}

//音箱Linein连接线插拔状态变化
-(void)lineinChanged:(BOOL)visibility {
    self.hasLinein = visibility;
}

//显示音箱对话框
-(void)dialogMessageArrived:(UInt32)type messageID:(UInt32)messageId {
    DialogType dialogType = type;
    if (dialogType == DIALOG_NOTICE) {
        
    }
    else if (dialogType == DIALOG_USB_CONNECTED) {
        
    }
    
    if (messageId == 0) {
        //选择进入音箱，将会与设备断开连接
    }
    
    //设置对话框的超时时间
    if (BLE_MANGER.globalManager) {
        [BLE_MANGER.globalManager setDialogTimeout:5];
    }
}

//显示音箱提示信息
-(void)toastMessageArrived:(UInt32)messageId {
    //提示信息序号
}

//取消音箱提示信息
-(void)dialogCancel {
    
}

//自定义命令回调
-(void)customCommandArrived:(UInt32)cmdKey param1:(UInt32)arg1 param2:(UInt32)arg2 others:(NSData*)data {
    int ck = [BLE_MANGER.globalManager buildKey:ANS cmdID:0x80];
    if (ck == cmdKey) {
        int index = 0;
        Byte *bytes = (Byte *)malloc(data.length);
        memcpy(bytes, [data bytes], data.length);
        
        NSString *var = [NSString bytes2String:bytes+index length:5 encode:bytes[7]];
        index += 8;
        NSString *name = [NSString bytes2String:bytes+index length:56 encode:bytes[7]];
        
        NSLog(@"音响信息:名称 = %@, 版本号 = %@", name, var);
    }
}
@end
