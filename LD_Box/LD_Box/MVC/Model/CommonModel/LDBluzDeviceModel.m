//
//  LDBluzDeviceModel.m
//  LD_Box
//
//  Created by Jay on 15/6/2.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDBluzDeviceModel.h"

@implementation LDBluzDeviceModel

#pragma mark - Init

- (instancetype)initWithPeripheral:(CBPeripheral *)peripheral
{
    self = [super init];
    if (self) {
        self.peripheral = peripheral;
    }
    
    return self;
}


#pragma mark - Methods

- (BOOL)isConnected {
    BOOL isConnected = NO;
    
    if (self.peripheral && (self.peripheral.state == CBPeripheralStateConnected)) {
        isConnected = YES;
    }
    
    return isConnected;
}

- (BOOL)isPeripheral:(CBPeripheral *)peripheral {
    BOOL isPeripheral = NO;
    
    if ([peripheral.identifier.UUIDString isEqualToString:self.peripheral.identifier.UUIDString]) {
        isPeripheral = YES;
    }
    
    return isPeripheral;
}

@end
