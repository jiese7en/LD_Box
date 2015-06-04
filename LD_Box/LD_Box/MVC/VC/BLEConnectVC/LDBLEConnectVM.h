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

@end

@interface LDBLEConnectVM : NSObject

@property (nonatomic, assign) id <LDBLEConnectVMDelegate> delegate;

@property (nonatomic, strong) BluzDevice *bluzDevice;

@property (nonatomic, strong) BluzManager *bluzManager;

@property (strong, nonatomic) id<GlobalManager> globalManager;

/**
 *  例:FolderEntry
 */
@property (nonatomic, strong) NSMutableArray *musicFolderArray;

//当前连接的设备
@property (nonatomic, strong) LDBluzDeviceModel *curDeviceModel;

@property (nonatomic, assign) BOOL isGlobalManagerReady;
@property (nonatomic, assign) BOOL hasSDCard;
@property (nonatomic, assign) BOOL hasUhost;
@property (nonatomic, assign) BOOL isSupportRecPlayback;


/**
 *  例:LDBluzDeviceModel
 */
@property (nonatomic, strong) NSMutableArray *deviceArr;


- (void)scanStart;

- (void)connect:(LDBluzDeviceModel *)deviceModel;

@end
