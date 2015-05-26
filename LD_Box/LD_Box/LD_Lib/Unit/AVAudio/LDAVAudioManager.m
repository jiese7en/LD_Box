//
//  LDAVAudioManager.m
//  LD_Box
//
//  Created by Jay on 15-5-21.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDAVAudioManager.h"
#import <AVFoundation/AVFoundation.h>

@implementation LDAVAudioManager



#pragma mark - Init
//单例
+ (LDAVAudioManager *)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static LDAVAudioManager * _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    
    return _sharedObject;
}

#pragma mark - Methods

- (void)prepareAudioSession {
    
    // deactivate session
    BOOL success = [[AVAudioSession sharedInstance] setActive:NO error: nil];
    if (!success) {
        NSLog(@"deactivationError");
    }
    
    // set audio session category AVAudioSessionCategoryPlayAndRecord options AVAudioSessionCategoryOptionAllowBluetooth
    //withOptions:AVAudioSessionCategoryOptionAllowBluetooth
    success = [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback  error:nil];
    if (!success) {
        NSLog(@"setCategoryError");
    }
    
    success = [[AVAudioSession sharedInstance] setActive:YES error: nil];
    if (!success) {
        NSLog(@"activationError");
    }
}

@end
