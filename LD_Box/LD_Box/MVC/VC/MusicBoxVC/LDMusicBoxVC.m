//
//  LDMusicBoxVC.m
//  LD_Box
//
//  Created by Jay on 15/6/8.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDMusicBoxVC.h"
#import "LDMusicBoxVM.h"
#import "NSString+LDCategory.h"
#import "UIColor+LDColor.h"

@interface LDMusicBoxVC () <UITableViewDelegate, UITableViewDataSource, LDMusicBoxVMDelegate>

@property (nonatomic, strong) LDMusicBoxVM *viewModel;

@property (nonatomic, assign) CGRect mainRect;

@property (nonatomic, strong) UITableView *tableView;


@end

@implementation LDMusicBoxVC

#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"MusicBox";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self layoutUI];
}

- (void)viewDidAppear:(BOOL)animated{
    
#if 0
    [self addMusicInfo];
    
    self.mainScrollView.contentOffset = CGPointZero;
    self.titleLabel.text = self.viewModel.musicBeanModel.m_musicName;
    self.singerLabel.text = self.viewModel.musicBeanModel.m_singerName;
    self.totalTimeLabel.text = self.viewModel.musicBeanModel.m_musicTime;
    self.coverImgView.image=[UIImage imageNamed: @"ic_album_cover_default.png"];
    
    [self.playBtn setImage:[UIImage imageNamed:@"ic_music_pause.png"] forState:UIControlStateNormal];
#endif
}

- (void)layoutUI {
    
//    self.coverImgView.backgroundColor = [UIColor blackColor];
//    
//    self.mainRect = self.coverImgView.frame;
//    self.mainRect = CGRectMake(0, 0, 320, 256);
//    
//    self.musicMemoVC.view.frame = CGRectMake(self.mainRect.size.width, self.mainRect.origin.y, self.mainRect.size.width, self.mainRect.size.height);
//    self.musicLrcVC.view.frame = CGRectMake(self.mainRect.size.width*2, self.mainRect.origin.y, self.mainRect.size.width, self.mainRect.size.height);
//    
//    self.tableView = [[UITableView alloc] initWithFrame:self.mainRect];
//    self.tableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
//    self.tableView.backgroundColor = [UIColor clearColor];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    
//    self.coverImgView.userInteractionEnabled=YES;
//    
//    self.mainScrollView.contentSize = CGSizeMake(self.mainRect.size.width*3, self.mainRect.size.height);
    self.mainScrollView.backgroundColor = [UIColor clearColor];
//    self.mainScrollView.contentOffset = CGPointZero;
    
//    [self.mainScrollView addSubview:self.tableView];
//    [self.mainScrollView addSubview:self.musicMemoVC.view];
//    [self.mainScrollView addSubview:self.musicLrcVC.view];
}

#pragma mark - property

- (LDMusicBoxVM *)viewModel {
    if (_viewModel) {
        return _viewModel;
    }
    _viewModel = [[LDMusicBoxVM alloc] init];
    _viewModel.delegate = self;
    return _viewModel;
}


- (LDMusicMemoVC *)musicMemoVC {
    if (_musicMemoVC) {
        return _musicMemoVC;
    }
    _musicMemoVC = [[LDMusicMemoVC alloc] init];
    return _musicMemoVC;
}

- (LDMusicLrcVC *)musicLrcVC {
    if (_musicLrcVC) {
        return _musicLrcVC;
    }
    _musicLrcVC = [[LDMusicLrcVC alloc] init];
    return _musicLrcVC;
}

#pragma mark - Private Methods
- (void)addMusicInfo {
    
    self.mainScrollView.backgroundColor = RGBAlpha(0.0, 0.0, 0.0, 0.2);
    
    NSString *strMusicInfo = [NSString stringWithFormat:@"  %@：%@\r\n  %@：%@\r\n  %@：%@\r\n  %@：%@\r\n  %@：%@",
                              @"标题", self.viewModel.musicBeanModel.m_musicTitle,
                              @"歌手", self.viewModel.musicBeanModel.m_musicArtist,
                              @"专辑", self.viewModel.musicBeanModel.m_musicAlbum,
                              @"风格", self.viewModel.musicBeanModel.m_musicGenre,
                              @"格式", self.viewModel.musicBeanModel.m_musicType];
    
    [self.musicMemoVC setMusicInfo:strMusicInfo];
}

#pragma mark - LDMusicBoxVMDelegate

- (void)setPlayProgress:(UInt32)time total:(UInt32)total {
    
    self.totalTimeLabel.text = [NSString stringMinAndSecond:total];
    self.playTimeLabel.text = [NSString stringMinAndSecond:total];
    
    [self.playProgressView setProgress: (float)time/total];
    
    [self.musicLrcVC displaySongWord:time];
}

- (void)pListChanged {
    [self.mainScrollView scrollRectToVisible:self.mainScrollView.frame animated:YES];
}

- (void)finishedByItemArr:(NSMutableArray *)itemArr {
    [self.musicLrcVC loadDataItemArr:itemArr];
}

- (void)boxPlayMusicEntry {
    self.titleLabel.text = self.viewModel.musicBeanModel.m_musicName;
    self.singerLabel.text = self.viewModel.musicBeanModel.m_musicArtist;
    [self addMusicInfo];
}

- (void)refreshUISelectRow {
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.viewModel.selectedRow inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    
}

- (void)boxLoopMode:(LoopMode)mode {
    
    NSString *imageStr = nil;
    NSString *imageHighStr = nil;
    if (mode == LOOP_MODE_SINGLE) {
        imageStr = @"ic_loop_single.png";
        imageHighStr = @"ic_loop_single_focused.png";
    }
    else if(mode == LOOP_MODE_SHUFFLE){
        imageStr = @"ic_loop_shuffle.png";
        imageHighStr = @"ic_loop_shuffle_focused.png";
    }
    else {
        imageStr = @"ic_loop_all.png";
        imageHighStr = @"ic_loop_all_focused.png";
    }
    
    [self.loopBtn setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    [self.loopBtn setImage:[UIImage imageNamed:imageHighStr] forState:UIControlStateHighlighted];
}

- (void)boxShowCBLPLMusic {
    
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.viewModel.CBLPLMusicArr.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.CBLPLMusicArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"leftMenuCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    NSDictionary *dic = [self.viewModel.CBLPLMusicArr objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic objectForKey:@"Filename"];
    
    if(self.viewModel.seq > 0) {
        if(indexPath.row == self.viewModel.seq-1 &&
           self.viewModel.isLoadAllEnd) {
            [cell setSelected:YES];
        }
        else{
            [cell setSelected:NO];
        }
    }
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.viewModel selectPlayMusic:(UInt32)indexPath.row];
}


#pragma mark - UIButton

- (IBAction)clickLoopBtn:(UIButton *)sender {
    [self.viewModel playLoopChanged];
}

- (IBAction)clickMusiclistBtn:(UIButton *)sender {
}

- (IBAction)clickPlayBtn:(UIButton *)sender {
    [self.viewModel playStatusChanged];
}

- (IBAction)clickNextBtn:(UIButton *)sender {
    
    [self.viewModel playNext];
}

- (IBAction)clickPrevBtn:(UIButton *)sender {
    [self.viewModel playPrev];
}
@end
