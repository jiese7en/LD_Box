//
//  LDMusicBoxVM.m
//  LD_Box
//
//  Created by Jay on 15/6/8.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDMusicBoxVM.h"
#import "LDBLEManager.h"
#import "NSString+LDCategory.h"
#import "NSObject+LDUserDefaults.h"

#import "NSArray+LDCategory.h"

@interface LDMusicBoxVM () <MusicDelegate>

//音箱功能状态
@property (nonatomic, assign) PlayStatus musicStatus;

@property (nonatomic, strong) NSTimer *musicTimer;

//当前的音箱功能模式
@property (nonatomic, assign) FuncMode funcMode;



//对象准备就绪
@property (nonatomic, assign) BOOL isManagerReady;

//获取歌曲的总数
@property (nonatomic, assign) UInt32 CBLSongNum;

@property (nonatomic, assign) BOOL isPListChanged;




//当前播放的歌词Idx
@property (nonatomic, assign) NSInteger curLyricIdx;

//当前的播放模式
@property (nonatomic, assign) LoopMode loopMode;

//字典 歌词-时间
@property (nonatomic,strong) NSMutableArray *itemArr;

//放每一行的歌词
@property (nonatomic,strong) NSMutableArray *tempArr;

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

- (NSMutableArray *)itemArr {
    if (_itemArr) {
        return _itemArr;
    }
    _itemArr = [NSMutableArray array];
    return _itemArr;
}

- (NSMutableArray *)tempArr {
    if (_tempArr) {
        return _tempArr;
    }
    _tempArr = [NSMutableArray array];
    return _tempArr;
}

- (LDMusicBeanModel *)musicBeanModel {
    if (_musicBeanModel) {
        return _musicBeanModel;
    }
    _musicBeanModel = [[LDMusicBeanModel alloc] init];
    return _musicBeanModel;
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
    if (self.musicStatus == STATE_PLAYING) {
        
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

- (void)createLyric:(NSString *)lyricStr{
    
    self.musicBeanModel.m_Lyrics = lyricStr;
    
    NSArray *lyricsLineArr = [self.musicBeanModel.m_Lyrics componentsSeparatedByString:@"\n"];
    
    [self.itemArr removeAllObjects];
    
    for (NSString *lineStr in lyricsLineArr)
    {
        if (!lineStr || lineStr.length <= 0) {
            continue;
        }
        
        [self parseLrcLine:lineStr];
        [self parseTempArr:self.tempArr];
    }
    [NSArray sortByTime:self.itemArr];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(finishedByItemArr:)]) {
        [self.delegate finishedByItemArr:self.itemArr];
    }
}

// 解析每一行，将每一行的[time]和内容分开
- (NSString *)parseLrcLine:(NSString *)lineStr {
    
    if (!lineStr || lineStr.length <= 0) {
        return nil;
    }
    
    NSRange range = [lineStr rangeOfString:@"]"];
    if (range.length > 0) {
        
        NSString *time = [lineStr substringToIndex:range.location + 1];
        NSString *other = [lineStr substringFromIndex:range.location + 1];
        
        if (time && time.length > 0){
            [self.tempArr addObject:time];
        }
        
        if (other) {
            [self parseLrcLine:other];
        }
    }
    else {
        [self.tempArr addObject:lineStr];
    }
    return nil;
}

- (void)parseTempArr:(NSMutableArray *)tempArr {
    
    if (!tempArr || tempArr.count <= 0) {
        return;
    }
    
    NSString *value = [tempArr lastObject];
    
    if (!value || ([value rangeOfString:@"["].length > 0 && [value rangeOfString:@"]"].length > 0))
    {
        [tempArr removeAllObjects];
        return;
    }
    
    for (NSUInteger i = 0; i < tempArr.count - 1; i++)
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        NSString *key = [tempArr objectAtIndex:i];
        NSString *secondKey = [NSString timeToSecond:key];
        [dic setObject:value forKey:secondKey];
        [self.itemArr addObject:dic];
    }
    [tempArr removeAllObjects];
}

-(void)playMusicEntry:(MusicEntry *)entry {
    
    NSString *unknowStr = @"未知";
    
    if(!entry.mimeType) {
        entry.mimeType = unknowStr;
    }
    if(!entry.name) {
        entry.name = unknowStr;
    }
    if(!entry.title) {
        entry.title = unknowStr;
    }
    if(!entry.artist) {
        entry.artist = unknowStr;
    }
    if(!entry.album) {
        entry.album = unknowStr;
    }
    if(!entry.genre) {
        entry.genre = unknowStr;
    }
    
    self.musicBeanModel.m_musicType = entry.mimeType;
    self.musicBeanModel.m_musicName = entry.name;
    self.musicBeanModel.m_musicTitle = entry.title;
    self.musicBeanModel.m_musicArtist = entry.artist;
    self.musicBeanModel.m_musicAlbum = entry.album;
    self.musicBeanModel.m_musicGenre = entry.genre;
    self.musicBeanModel.m_url =  nil;
    self.musicBeanModel.m_musicCover = [UIImage imageNamed: @"ic_album_cover_default.png"];
    
    self.seq = entry.index;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(boxPlayMusicEntry)]) {
        [self.delegate boxPlayMusicEntry];
    }
    
    if(self.CBLPLMusicArr.count >= self.seq &&
       self.page == 0 &&
       self.selectedRow != self.seq - 1) {
        
        self.selectedRow = self.seq - 1;
        if (self.delegate && [self.delegate respondsToSelector:@selector(refreshUISelectRow)]) {
            [self.delegate refreshUISelectRow];
        }
    }
    
    if(self.page == 2) {
        
        self.curLyricIdx = self.seq;
        
        [self createLyric:@""];
        
        NSString *lyric = nil;
        if (self.CBLPLMusicArr.count >= self.seq) {
            NSString *key = [NSString stringWithFormat:@"Lyric_%@", entry.name];
            lyric = [NSObject getFromUserDefaults:key];
        }
        
        if (!lyric) {
            [BLE_MANGER.musicManager getLyric:(UInt32)self.seq];
        }
        else {
            [self createLyric:lyric];
        }
    }
}

- (void)createLoopMode:(LoopMode)mode {
    
    self.loopMode = mode;
    if (self.delegate && [self.delegate respondsToSelector:@selector(boxLoopMode:)]) {
        [self.delegate boxLoopMode:mode];
    }
}

- (void)createPlayStatus:(PlayStatus)status {
    self.musicStatus = status;
    if (self.delegate && [self.delegate respondsToSelector:@selector(boxPlayStatus:)]) {
        [self.delegate boxPlayStatus:status];
    }
}

- (void)showCBLPLMusic:(NSMutableArray *)entryList {
    
    for (MusicEntry *entry in entryList) {
        
        NSMutableDictionary *PLDic = [NSMutableDictionary dictionary];
        
        [PLDic setObject:[NSNumber numberWithInteger:entry.index] forKey:@"seq"];
        NSString *unknowStr = @"未知";
        
        if(!entry.mimeType) {
            entry.mimeType = unknowStr;
        }
        if(!entry.name) {
            entry.name = unknowStr;
        }
        if(!entry.title) {
            entry.title = unknowStr;
        }
        if(!entry.artist) {
            entry.artist = unknowStr;
        }
        if(!entry.album) {
            entry.album = unknowStr;
        }
        if(!entry.genre) {
            entry.genre = unknowStr;
        }
        
        [PLDic setObject:entry.mimeType forKey:@"type"];
        [PLDic setObject:entry.name forKey:@"Filename"];
        [PLDic setObject:entry.title forKey:@"Titlename"];
        [PLDic setObject:entry.artist forKey:@"Artistname"];
        [PLDic setObject:entry.album forKey:@"Albumname"];
        [PLDic setObject:entry.genre forKey:@"Genrename"];
        [PLDic setObject:[NSNumber numberWithBool:entry.lyric] forKey:@"hasLyric"];
        
        BOOL found = NO;
        for (int i = 0; i < self.CBLPLMusicArr.count; i++) {
            NSMutableDictionary *entryDic = [self.CBLPLMusicArr objectAtIndex:i];
            NSInteger index = [[entryDic objectForKey:@"seq"] integerValue];
            if (index == entry.index) {
                found = YES;
                break;
            }
        }
        
        if (!found) {
            [self.CBLPLMusicArr addObject:PLDic];
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(boxShowCBLPLMusic)]) {
        [self.delegate boxShowCBLPLMusic];
    }
    
}


#pragma mark - Methods

- (void)selectPlayMusic:(UInt32)index {
    
    self.selectedRow = index;
    
    [BLE_MANGER.musicManager select:index + 1];
    
    NSMutableDictionary *entryDic = [self.CBLPLMusicArr objectAtIndex:index];
    self.musicBeanModel.m_musicType = [entryDic objectForKey:@"type"];
    self.musicBeanModel.m_musicName = [entryDic objectForKey:@"Filename"];
    self.musicBeanModel.m_musicTitle = [entryDic objectForKey:@"Titlename"];
    self.musicBeanModel.m_musicArtist = [entryDic objectForKey:@"Artistname"];
    self.musicBeanModel.m_musicAlbum = [entryDic objectForKey:@"Albumname"];
    self.musicBeanModel.m_musicGenre = [entryDic objectForKey:@"Genrename"];
    self.musicBeanModel.m_url =  nil;
    self.musicBeanModel.m_musicCover = [UIImage imageNamed: @"ic_album_cover_default.png"];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(boxPlayMusicEntry)]) {
        [self.delegate boxPlayMusicEntry];
    }
}

- (void)playLoopChanged {
    if(self.loopMode == LOOP_MODE_ALL){
        self.loopMode = LOOP_MODE_SINGLE;
    }
    else if(self.loopMode == LOOP_MODE_SINGLE){
        self.loopMode = LOOP_MODE_SHUFFLE;
    }
    else if(self.loopMode == LOOP_MODE_SHUFFLE){
        self.loopMode = LOOP_MODE_ALL;
    }
    [BLE_MANGER.musicManager setLoopMode:(UInt32)self.loopMode];
}

- (void)playStatusChanged {
    if (self.musicStatus == STATE_PLAYING) {
        [BLE_MANGER.musicManager pause];
    }
    else if (self.musicStatus == STATE_PAUSED) {
        [BLE_MANGER.musicManager play];
    }
}

- (void)playNext {
    [BLE_MANGER.musicManager next];
}

- (void)playPrev {
    [BLE_MANGER.musicManager previous];
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
                NSString *pListKey = [NSString stringWithFormat:@"PList_%d", (unsigned int)mode];
                
                self.CBLPLMusicArr = [NSMutableArray arrayWithArray:[NSObject getFromUserDefaults:pListKey]];
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(boxShowCBLPLMusic)]) {
                    [self.delegate boxShowCBLPLMusic];
                }
                
                self.seq = self.seq >= 1 ? self.seq : 1;
                self.selectedRow = self.seq - 1;
                if (self.delegate && [self.delegate respondsToSelector:@selector(refreshUISelectRow)]) {
                    [self.delegate refreshUISelectRow];
                }
            }
        }
        else {
            NSLog(@"未检测到歌曲");
        }
    }
}

//音箱返回指定歌曲的歌词信息
-(void)lyricReady:(UInt32)index lyric:(NSData*)lyric {
    
    NSString *strLyric = [NSString convertLyricToString:lyric];
    
    if (self.CBLPLMusicArr && self.CBLPLMusicArr.count > index - 1) {
        
        NSMutableDictionary *entry = [self.CBLPLMusicArr objectAtIndex:index - 1];
        NSString *title = [entry objectForKey:@"Filename"];
        NSString *key = [NSString stringWithFormat:@"Lyric_%@", title];
        
        [NSObject saveToUserDefaults:strLyric forKey:key];
    }
    
    self.curLyricIdx = index;
    [self createLyric:strLyric];
    
}

//音箱播放音乐条目切换
-(void)musicEntryChanged:(MusicEntry*) entry {
    
    [self playMusicEntry:entry];
    
}

//音箱当前循环模式变化
-(void)loopModeChanged:(UInt32) mode {
    [self createLoopMode:mode];
}

//音箱播放状态变化
-(void)stateChanged:(UInt32) state {
    
    [self createPlayStatus:state];
}

//音箱播放列表变化，应用需重新同步播放列表
-(void)contentChanged {
    self.isPListChanged = YES;
}

//音箱发送播放列表
-(void)pListEntryReady:(NSMutableArray*)entryList {
    [self showCBLPLMusic:entryList];
    
    if(self.CBLPLMusicArr.count < self.CBLSongNum) {
        if(self.page == 0) {
            NSLog(@"歌曲总数 %lu", (long)self.CBLSongNum);
            NSLog(@"正在获取第 %lu 首歌曲", (long)self.CBLPLMusicArr.count + 1);
        }
        
        [self getPlist];
    }
    else{
        self.isLoadAllEnd = YES;
        
        self.seq = self.seq >= 1 ? self.seq : 1;
        self.selectedRow = self.seq - 1;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(refreshUISelectRow)]) {
            [self.delegate refreshUISelectRow];
        }
        
        if (self.CBLPLMusicArr.count > 0) {
            self.isPListChanged = NO;
            NSString *pListKey = [NSString stringWithFormat:@"PList_%d", self.funcMode];
            [NSObject saveToUserDefaults:self.CBLPLMusicArr forKey:pListKey];
        }
    }
}

@end
