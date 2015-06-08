//
//  LDMusicBoxVM.m
//  LD_Box
//
//  Created by Jay on 15/6/8.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDMusicBoxVM.h"
#import "LDBLEManager.h"


@interface LDMusicBoxVM () <MusicDelegate>

@property (nonatomic, assign) PlayStatus musicState;

@property (nonatomic, strong) NSTimer *musicTimer;

@property (nonatomic, assign) FuncMode funcMode;

@property (nonatomic, assign) NSInteger seq;

@property (nonatomic, assign) BOOL isManagerReady;

//获取歌曲的总数
@property (nonatomic, assign) UInt32 CBLSongNum;

@property (nonatomic, assign) BOOL isPListChanged;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) BOOL isLoadAllEnd;

@end

@implementation LDMusicBoxVM

#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        [BLE_MANGER creatMusicManager:self];
        self.isPListChanged = YES;
        self.isLoadAllEnd = YES;
    }
    return self;
}

#pragma mark - property

- (NSMutableArray *)CBLPLMusicArr {
    if (_CBLPLMusicArr) {
        return _CBLPLMusicArr;
    }
    _CBLPLMusicArr = [NSMutableArray array];
    return _CBLPLMusicArr;
}


#pragma mark - Timer

- (void)createMusicTimer {
    if (self.musicTimer) {
        [self removeMusicTimer];
    }
    self.musicTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(refreshMusicProgress) userInfo:nil repeats:YES];
}

- (void)removeMusicTimer {
    if (self.musicTimer) {
        [self.musicTimer invalidate];
        self.musicTimer = nil;
    }
}

- (void)refreshMusicProgress {
    if (self.musicState == STATE_PLAYING) {
        
        UInt32 time = [BLE_MANGER.musicManager getCurrentPosition];
        UInt32 total = [BLE_MANGER.musicManager getDuration];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(setPlayProgress:total:)]) {
            [self.delegate setPlayProgress:time total:total];
        }
    }
}

#pragma mark - Private Methods

- (void)getPlist {
    
    UInt32 left = (UInt32)(self.CBLSongNum - self.CBLPLMusicArr.count);
    [BLE_MANGER.musicManager getPListFrom:(UInt32)self.CBLPLMusicArr.count+1 withCount:(left >= 5 ? 5:left)];
}

#pragma mark - MusicDelegate
//对象准备就绪
-(void)managerReady:(UInt32)mode {
    
    self.seq = 0;
    self.funcMode = mode;
    self.isManagerReady = YES;
    
    if(mode == MODE_CARD ||
       mode == MODE_UHOST ||
       mode == MODE_CRECORD ||
       mode == MODE_URECORD ||
       mode > MODE_CRECORD) {
        
        self.CBLSongNum = [BLE_MANGER.musicManager getPListSize];
        
        if (self.CBLSongNum) {
            if (self.isPListChanged) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(pListChanged)]) {
                    [self.delegate pListChanged];
                }
                
                self.page = 0;
                
                if (self.page == 0 &&
                    self.CBLPLMusicArr.count < self.CBLSongNum) {
                    
                    self.isLoadAllEnd = NO;
                    NSLog(@"总的歌曲有%lu,正在获取第%lu首", (long)self.CBLSongNum, (long)self.CBLPLMusicArr.count);
                }
                [self getPlist];
            }
            else {
                
            }
        }
        else {
            NSLog(@"未检测到歌曲");
        }
    }
}

//音箱返回指定歌曲的歌词信息
-(void)lyricReady:(UInt32)index lyric:(NSData*)lyric {
    
}

//音箱播放音乐条目切换
-(void)musicEntryChanged:(MusicEntry*) entry {
    
}

//音箱当前循环模式变化
-(void)loopModeChanged:(UInt32) mode {
    
}

//音箱播放状态变化
-(void)stateChanged:(UInt32) state {
    
}

//音箱播放列表变化，应用需重新同步播放列表
-(void)contentChanged {
    
}

//音箱发送播放列表
-(void)pListEntryReady:(NSMutableArray*)entryList {
    
}

@end
