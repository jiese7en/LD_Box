//
//  LDBluzManager.h
//  LD_Box
//
//  Created by Jay on 15/6/8.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BluzDevice.h"
#import "BluzManager.h"
#import "GlobalManager.h"

#define BLE_MANGER [LDBLEManager sharedInstance]


@interface LDBLEManager : NSObject

//单例
+ (LDBLEManager *)sharedInstance;

@property (nonatomic, strong) BluzDevice *bluzDevice;

@property (nonatomic, strong) BluzManager *bluzManager;

@property (strong, nonatomic) id <GlobalManager> globalManager;

@property (strong, nonatomic) id <MusicManager> musicManager;

- (void)creatGlobalManager:(id <GlobalDelegate>)delegate;

- (void)creatMusicManager:(id <MusicDelegate>)delegate;

@end
