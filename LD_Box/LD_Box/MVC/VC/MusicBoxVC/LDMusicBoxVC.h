//
//  LDMusicBoxVC.h
//  LD_Box
//
//  Created by Jay on 15/6/8.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDBaseVC.h"
#import "LDMusicLrcVC.h"
#import "LDMusicMemoVC.h"

@interface LDMusicBoxVC : LDBaseVC


@property (nonatomic,strong) LDMusicMemoVC *musicMemoVC;
@property (nonatomic,strong) LDMusicLrcVC *musicLrcVC;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *playProgressView;
@property (weak, nonatomic) IBOutlet UIImageView *coverImgView;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *loopBtn;



#pragma mark - UIButton

- (IBAction)clickLoopBtn:(UIButton *)sender;
- (IBAction)clickMusiclistBtn:(UIButton *)sender;
- (IBAction)clickPlayBtn:(UIButton *)sender;
- (IBAction)clickNextBtn:(UIButton *)sender;
- (IBAction)clickPrevBtn:(UIButton *)sender;

#pragma mark - Methods

- (void)clearCBLPLMusic;

@end
