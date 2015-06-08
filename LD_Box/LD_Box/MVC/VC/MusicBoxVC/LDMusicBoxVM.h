//
//  LDMusicBoxVM.h
//  LD_Box
//
//  Created by Jay on 15/6/8.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LDMusicBoxVMDelegate <NSObject>

@optional

- (void)setPlayProgress:(UInt32)time total:(UInt32)total;

- (void)pListChanged;

@end


@interface LDMusicBoxVM : NSObject


@property (nonatomic, assign) id <LDMusicBoxVMDelegate> delegate;

@property (nonatomic,strong) NSMutableArray *CBLPLMusicArr;

@end
