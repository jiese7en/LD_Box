//
//  AppDelegate.m
//  LD_Box
//
//  Created by Jay on 15-5-21.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "AppDelegate.h"

#import "LDMusicVC.h"
#import "LDMainVC.h"

#import "LDLoger.h"
#import "LDAVAudioManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 将打印信息写入文件
    [LDLoger redirectNSlogToDocumentFolder];
    
    //启动音频
    [AV_AUDIO_MAN prepareAudioSession];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    LDMusicVC *mainVC = [[LDMusicVC alloc] init];
    self.window.rootViewController = mainVC;
    
    return YES;
}


@end
