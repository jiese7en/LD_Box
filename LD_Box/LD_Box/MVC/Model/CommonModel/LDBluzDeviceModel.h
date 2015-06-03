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

@end
