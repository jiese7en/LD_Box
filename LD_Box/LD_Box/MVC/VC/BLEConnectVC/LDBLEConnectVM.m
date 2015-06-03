//
//  LDBLEConnectVM.m
//  LD_Box
//
//  Created by Jay on 15/6/2.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDBLEConnectVM.h"


@interface LDBLEConnectVM () <ConnectDelegate>



@end


@implementation LDBLEConnectVM


#pragma mark - property

- (BluzDevice *)bluzDevice {
    if (_bluzDevice) {
        return _bluzDevice;
    }
    _bluzDevice = [[BluzDevice alloc] init];
    return _bluzDevice;
}

- (NSMutableArray *)deviceArr {
    if (_deviceArr) {
        return _deviceArr;
    }
    _deviceArr = [[NSMutableArray alloc] initWithCapacity:0];
    return _deviceArr;
}

- (void)scanStart {
    
    [self.deviceArr removeAllObjects];
    
    [self.bluzDevice scanStart];
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
    
}



@end
