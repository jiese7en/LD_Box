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
#import "BluzManager.h"

@protocol LDBLEConnectVMDelegate <NSObject>

- (void)foundPeripheralFinished;

- (void)connectedPeripheralFinished;

- (void)disconnectedPeripheralFinished;

- (void)disconnectedPeripheralFinished:(BOOL)onInitiative;

@end

@interface LDBLEConnectVM : NSObject

@property (nonatomic, assign) id <LDBLEConnectVMDelegate> delegate;


/**
 *  例:LDBluzDeviceModel
 */
@property (nonatomic, strong) NSMutableArray *deviceArr;


- (void)start;


- (void)scanStart;

- (void)connect:(LDBluzDeviceModel *)deviceModel;

- (void)disconnect;



@end
