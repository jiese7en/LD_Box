//
//  LDBLEConnectVM.h
//  LD_Box
//
//  Created by Jay on 15/6/2.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BluzDevice.h"
#import "LDBluzDeviceModel.h"

@protocol LDBLEConnectVMDelegate <NSObject>

- (void)foundPeripheralFinished;

@end

@interface LDBLEConnectVM : NSObject

@property (nonatomic, assign) id <LDBLEConnectVMDelegate> delegate;

@property (nonatomic, strong) BluzDevice *bluzDevice;

//当前连接的设备
@property (nonatomic, strong) LDBluzDeviceModel *curDeviceModel;

@property (nonatomic, strong) NSMutableArray *deviceArr;


- (void)scanStart;

@end
