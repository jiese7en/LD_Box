//
//  LDMusicBoxVM.h
//  LD_Box
//
//  Created by Jay on 15/6/8.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MusicEntry.h"
#import "LDMusicBeanModel.h"
#import "BluzManagerData.h"

@protocol LDMusicBoxVMDelegate <NSObject>

@optional

- (void)setPlayProgress:(UInt32)time total:(UInt32)total;

- (void)pListChanged;

- (void)finishedByItemArr:(NSMutableArray *)itemArr;

- (void)boxPlayMusicEntry;

- (void)refreshUISelectRow;

- (void)boxLoopMode:(LoopMode)mode;

- (void)boxPlayStatus:(PlayStatus)status;

- (void)boxShowCBLPLMusic;

@end


@interface LDMusicBoxVM : NSObject


@property (nonatomic, assign) id <LDMusicBoxVMDelegate> delegate;

@property (nonatomic,strong) NSMutableArray *CBLPLMusicArr;

//当前播放的歌曲
@property (nonatomic, strong) LDMusicBeanModel *musicBeanModel;

//选择的tableView的row
@property (nonatomic, assign) NSInteger selectedRow;

//音乐序号
@property (nonatomic, assign) NSInteger seq;

@property (nonatomic, assign) NSInteger page;

//是否全部加载完成了
@property (nonatomic, assign) BOOL isLoadAllEnd;


- (void)selectPlayMusic:(UInt32)index;

- (void)playLoopChanged;

- (void)playStatusChanged;

- (void)playNext;

- (void)playPrev;

@end
