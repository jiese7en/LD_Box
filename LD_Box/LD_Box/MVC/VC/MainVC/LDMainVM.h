//
//  LDMainVM.h
//  LD_Box
//
//  Created by Jay on 15/6/18.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BluzDevice.h"
#import "LDBluzDeviceModel.h"
#import "BluzManager.h"


@protocol LDMainVMDelegate <NSObject>

- (void)mainBatteryChanged:(UInt32)battery charging:(BOOL)charging;

@end

@interface LDMainVM : NSObject

@property (nonatomic, assign) id <LDMainVMDelegate> delegate;

//是否有SD卡
@property (nonatomic, assign) BOOL hasSDCard;

//是否有U盘
@property (nonatomic, assign) BOOL hasUhost;

//isGlobalManagerReady
@property (nonatomic, assign) BOOL isGlobalManagerReady;

//音效模式
@property (nonatomic, assign) SoundEffect soundEffect;

//EQ模式
@property (nonatomic, assign) EQMode eqMode;

//虚拟低音音效使能状态
@property (nonatomic, assign) BOOL vbassEnable;

//高音增强音效使能状态
@property (nonatomic, assign) BOOL trebleEnable;

//音箱功能模式
@property (nonatomic, assign) FuncMode funcMode;

//是否有连接线
@property (nonatomic, assign) BOOL hasLinein;

/**
 *  例:FolderEntry
 */
@property (nonatomic, strong) NSMutableArray *musicFolderArray;

//见FeatureRecPlayback  支持录音回放功能标志
@property (nonatomic, assign) BOOL isSupportRecPlayback;

//FeatureFolder       支持特殊目录功能标志
@property (nonatomic, assign) BOOL isFeatureFolder;


//开始
- (void)start;

@end
