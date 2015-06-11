//
//  LDDrawer.m
//  LD_Box
//
//  Created by Jay on 15/5/29.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDDrawer.h"
#import "LDMainVC.h"
#import "LDLeftMenuVC.h"
#import "LDBaseNC.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "LDMusicVC.h"
#import "LDMusicBoxVC.h"

@interface LDDrawer ()

@property (nonatomic,strong) LDDrawerVC *drawerVC;

@end

@implementation LDDrawer

#pragma mark - Init
//单例
+ (LDDrawer *)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static LDDrawer * _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    
    return _sharedObject;
}


+ (LDDrawerVC *)createDrawer {
    
    LDMusicBoxVC *mainVC = [[LDMusicBoxVC alloc] init];
    LDBaseNC *mainNC = [[LDBaseNC alloc] initWithRootViewController:mainVC];
    
    LDLeftMenuVC *leftMenuVC = [[LDLeftMenuVC alloc] init];
    LDBaseNC *leftMenuNC = [[LDBaseNC alloc] initWithRootViewController:leftMenuVC];
    
    LDDrawerVC *drawerVC = [[LDDrawerVC alloc] initWithCenterViewController:mainNC leftDrawerViewController:leftMenuNC];
    [self sharedInstance].drawerVC = drawerVC;
    
    [[self sharedInstance].drawerVC setShowsShadow:NO];
    [[self sharedInstance].drawerVC setRestorationIdentifier:@"MMDrawer"];
    [[self sharedInstance].drawerVC setMaximumRightDrawerWidth:200.0];
    [[self sharedInstance].drawerVC setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [[self sharedInstance].drawerVC setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    [[self sharedInstance].drawerVC
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block = [[MMExampleDrawerVisualStateManager sharedManager]
                  drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];
    
    return drawerVC;
}

@end
