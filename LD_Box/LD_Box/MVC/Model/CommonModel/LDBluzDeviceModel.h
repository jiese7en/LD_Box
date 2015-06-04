//
//  LDBluzDeviceModel.h
//  LD_Box
//
//  Created by Jay on 15/6/2.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface LDBluzDeviceModel : NSObject


@property (nonatomic, strong) NSString *deviceName;

@property (nonatomic, strong) CBPeripheral *peripheral;


- (instancetype)initWithPeripheral:(CBPeripheral *)peripheral;

/**
 *  当前设置是否连接
 *
 *  @return YES/NO
 */
- (BOOL)isConnected;

/**
 *  是否是CBPeripheral
 */
- (BOOL)isPeripheral:(CBPeripheral *)peripheral;

@end
