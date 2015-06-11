//
//  LDLineinVM.h
//  LD_Box
//
//  Created by Jay on 15/6/12.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BluzManagerData.h"

@protocol LDLineinVMDelegate <NSObject>

@optional

- (void)lineinStateChanged:(PlayStatus)status;


@end

@interface LDLineinVM : NSObject

@property (nonatomic, assign) id <LDLineinVMDelegate> delegate;

- (void)start;

- (void)mute;

@end
