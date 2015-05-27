//
//  LDMusicVC.m
//  LD_Box
//
//  Created by Jay on 15/5/24.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDMusicVC.h"
#import "LDDevice.h"
#import "LDMedia.h"
#import "MJExtension.h"

//MediaPlayer
#import <MediaPlayer/MPMediaQuery.h>
#import <MediaPlayer/MPMediaPlaylist.h>
#import <MediaPlayer/MPMediaItem.h>
#import <MEdiaPlayer/MPNowPlayingInfoCenter.h>
#import <AVFoundation/AVFoundation.h>

//Model
#import "LDMusicBeanModel.h"



@interface LDMusicVC () <AVAudioPlayerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *musicArr;

//用NSTimer来监控音频播放进度
@property (nonatomic, strong) NSTimer *musicTimer;

//音频是否正在播放
@property (nonatomic, assign) BOOL isMusicPlay;

//AVAudioPlayer
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

//歌曲总时间
@property (nonatomic, assign) CGFloat totalMusicTime;

//当前歌曲的封面
@property (nonatomic, assign) UIImage *curMusicImg;

//选择音乐的Index
@property (nonatomic, assign) NSInteger selectMusicIndex;

@property (weak, nonatomic) IBOutlet UIButton *playMusicBtn;
@property (weak, nonatomic) IBOutlet UIButton *preMusicBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextMusicBtn;
@property (weak, nonatomic) IBOutlet UILabel *curMusicLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalMusicLabel;
@property (weak, nonatomic) IBOutlet UISlider *playMusicSlide;
@property (weak, nonatomic) IBOutlet UILabel *titleMusicLabel;
@property (weak, nonatomic) IBOutlet UILabel *singerMusicLabel;
@property (weak, nonatomic) IBOutlet UITableView *musicTableView;

- (IBAction)clickPlayMusicBtn:(UIButton *)sender;
- (IBAction)clickPreMusicBtn:(UIButton *)sender;
- (IBAction)clickNextMusicBtn:(UIButton *)sender;


@end

@implementation LDMusicVC

#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)layoutTableView {
    self.musicTableView.tableFooterView = [[UIView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutTableView];
    
    self.isMusicPlay = NO;
    
    [self startMusicTimer];
    
    [self getMusicMessage];
    
}


#pragma mark - Property

- (IBAction)playMusicBtn:(UIButton *)sender {
}

- (NSMutableArray *)musicArr {
    if (_musicArr) {
        return _musicArr;
    }
    _musicArr = [[NSMutableArray alloc] init];
    return _musicArr;
}




#pragma mark - Timer

- (void)startMusicTimer {
    
    [self stopMusicTimer];
    
    self.musicTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(playProgress) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:self.musicTimer forMode:NSRunLoopCommonModes];
//    [self.musicTimer fire];
}

- (void)stopMusicTimer {
    if (self.musicTimer) {
        [self.musicTimer invalidate];
        self.musicTimer = nil;
    }
}


- (void)playProgress {
    
}

#pragma mark - Private Methods

- (void)AudioSessionSet {
    
    if (IS_BEFORE_IOS7) {
#if 0
        AudioSessionSetActive(true);
        
        UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
        AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(sessionCategory), &sessionCategory);
        
        //    AudioSessionInitialize(NULL, NULL, interruptionListenerCallback, (__bridge void *)(self));
    
#endif
    }
}

- (void)getMusicMessage {
    
    NSArray *musicArr = [LDMedia getMusicMessage];
    
    [self.musicArr addObjectsFromArray:musicArr];
    
    [self.musicTableView reloadData];
    
}

- (void)playMusic:(BOOL)play {
    
    [self.musicTimer fire];
    
    if (self.isMusicPlay) {
        [self.playMusicBtn setImage:[UIImage imageNamed:@"ic_music_play"] forState:UIControlStateNormal];
        self.isMusicPlay = NO;
        self.curMusicLabel.text = @"00:00";
        self.playMusicSlide.value = 0;
        [self.audioPlayer stop];
    }
    
    [self.playMusicBtn setImage:[UIImage imageNamed:@"ic_music_pause"] forState:UIControlStateNormal];
    
    LDMusicBeanModel *mbModel = [[LDMusicBeanModel alloc] init];
    mbModel = [self.musicArr objectAtIndex:self.selectMusicIndex];
    self.titleMusicLabel.text = mbModel.m_musicName;
    self.singerMusicLabel.text = mbModel.m_singerName;
    self.totalMusicLabel.text = mbModel.m_musicTime;
    self.curMusicLabel.text = @"00:00";
    
    self.totalMusicTime = [mbModel getTotalTime];
    self.curMusicImg = mbModel.m_musicCover;
    if(self.audioPlayer && !play) {
        [self.audioPlayer play];
    }
    else {
        NSError *error;
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:mbModel.m_url error:&error];
        self.playMusicSlide.maximumValue = [mbModel getTotalTime];
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
    }
    self.audioPlayer.delegate = self;
    self.isMusicPlay = YES;
}

#pragma mark - Methods
- (void)startPlay {
    if (self.isMusicPlay) {
        return;
    }
    
    if (self.musicArr.count > 0) {
        [self playMusic:NO];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.musicArr.count;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"CellCollect";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell
                 alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    LDMusicBeanModel *mbModel = [self.musicArr objectAtIndex:indexPath.row];
    
    cell.textLabel.text = mbModel.m_musicName;
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    LDMusicBeanModel *mbModel = [self.musicArr objectAtIndex:indexPath.row];
    
    self.titleMusicLabel.text = mbModel.m_musicName;
    self.singerMusicLabel.text = mbModel.m_singerName;
    self.totalMusicLabel.text = mbModel.m_musicTime;
    self.curMusicLabel.text = @"00:00";
    
    [self playMusic:YES];
}

#pragma mark - UIButton

- (IBAction)clickPlayMusicBtn:(UIButton *)sender {
    
    if (self.musicArr.count > 0) {
        if (self.isMusicPlay) {
            [self.playMusicBtn setImage:[UIImage imageNamed:@"ic_music_play"] forState:UIControlStateNormal];
            self.isMusicPlay = NO;
            [self.audioPlayer pause];
        }
        else{
            [self.playMusicBtn setImage:[UIImage imageNamed:@"ic_music_pause"] forState:UIControlStateNormal];
            self.isMusicPlay = YES;
            
            if (self.audioPlayer) {
                [self.audioPlayer play];
            } else {
                NSLog(@"Error initializing data for AVAudioPlayer.  Possibly an Unsupported Format");
            }
        }
    }
}

- (IBAction)clickPreMusicBtn:(UIButton *)sender {
    
    //doRefreshBtn
    
}

- (IBAction)clickNextMusicBtn:(UIButton *)sender {
}
@end
