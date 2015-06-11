//
//  LDLineinVM.m
//  LD_Box
//
//  Created by Jay on 15/6/12.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDLineinVM.h"
#import "LDBLEManager.h"

@interface LDLineinVM () <AuxDelegate>

//对象准备就绪
@property (nonatomic, assign) BOOL isManagerReady;

//音箱功能状态
@property (nonatomic, assign) PlayStatus playState;

@end

@implementation LDLineinVM


#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - Methods

- (void)start {
    [BLE_MANGER creatAuxManager:self];
    
}

- (void)mute {
    [BLE_MANGER.auxManager mute];
}

#pragma mark - AuxDelegate

//对象准备就绪
-(void)managerReady:(UInt32)mode {
    
    if(mode == MODE_LINEIN){
        self.isManagerReady = YES;
    }
}

//Linein状态变化
-(void)stateChanged:(UInt32)state {
    
    self.playState = state;
    if (self.delegate && [self.delegate respondsToSelector:@selector(lineinStateChanged:)]) {
        [self.delegate lineinStateChanged:state];
    }
}



@end
