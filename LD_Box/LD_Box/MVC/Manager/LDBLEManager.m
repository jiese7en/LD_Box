//
//  LDBluzManager.m
//  LD_Box
//
//  Created by Jay on 15/6/8.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDBLEManager.h"



@implementation LDBLEManager

#pragma mark - Init
//单例
+ (LDBLEManager *)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static LDBLEManager * _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    
    return _sharedObject;
}



#pragma mark - property

- (BluzDevice *)bluzDevice {
    if (_bluzDevice) {
        return _bluzDevice;
    }
    _bluzDevice = [[BluzDevice alloc] init];
    
    return _bluzDevice;
}

- (BluzManager *)bluzManager {
    if (_bluzManager) {
        return _bluzManager;
    }
    _bluzManager = [[BluzManager alloc] initWithConnector:self.bluzDevice];
    
    return _bluzManager;
}

#pragma mark - Methods

- (void)creatGlobalManager:(id <GlobalDelegate>)delegate {
    self.globalManager = [self.bluzManager getGlobalManager:delegate];
}

- (void)creatMusicManager:(id <MusicDelegate>)delegate {
    self.musicManager = [self.bluzManager getMusicManager:delegate];
}



@end
