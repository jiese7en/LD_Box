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

@interface LDMusicBoxVC () <UITableViewDelegate, UITableViewDataSource, LDMusicBoxVMDelegate>

@property (nonatomic, strong) LDMusicBoxVM *viewModel;

@property (nonatomic, assign) CGRect mainRect;

@property (nonatomic, strong) UITableView *tableView;



@property (nonatomic, assign) int CBLSongInt;



@property (nonatomic, assign) NSInteger lyricIdx;



@property (nonatomic, strong) NSDictionary *CBLPlayInfoDic;

@property (nonatomic, assign) NSInteger loopMode;







@end

@implementation LDMusicBoxVC

#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)layoutUI {
    
    self.mainRect = self.coverImgView.frame;
    
    self.musicMemoVC.view.frame = CGRectMake(self.mainRect.size.width, self.mainRect.origin.y, self.mainRect.size.width, self.mainRect.size.height);
    self.musicLrcVC.view.frame=CGRectMake(self.mainRect.size.width*2, self.mainRect.origin.y, self.mainRect.size.width, self.mainRect.size.height);
    
    self.tableView = [[UITableView alloc] initWithFrame:self.mainRect];
    self.tableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.coverImgView.userInteractionEnabled=YES;
    
    self.mainScrollView.contentSize = CGSizeMake(self.mainRect.size.width*3, self.mainRect.size.height);
    self.mainScrollView.backgroundColor = [UIColor clearColor];
    self.mainScrollView.contentOffset = CGPointZero;
    
    [self.mainScrollView addSubview:self.tableView];
    [self.mainScrollView addSubview:self.musicMemoVC.view];
    [self.mainScrollView addSubview:self.musicLrcVC.view];
}

#pragma mark - property

- (LDMusicBoxVM *)viewModel {
    if (_viewModel) {
        return _viewModel;
    }
    _viewModel = [[LDMusicBoxVM alloc] init];
    return _viewModel;
}

- (LDMusicBeanModel *)musicBeanModel {
    if (_musicBeanModel) {
        return _musicBeanModel;
    }
    _musicBeanModel = [[LDMusicBeanModel alloc] init];
    return _musicBeanModel;
}


- (NSMutableArray *)tempArr {
    if (_tempArr) {
        return _tempArr;
    }
    _tempArr = [NSMutableArray array];
    return _tempArr;
}


- (NSMutableArray *)itemArr {
    if (_itemArr) {
        return _itemArr;
    }
    _itemArr = [NSMutableArray array];
    return _itemArr;
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


#pragma mark - LDMusicBoxVMDelegate

- (void)setPlayProgress:(UInt32)time total:(UInt32)total {
    
    self.totalTimeLabel.text = [NSString stringMinAndSecond:total];
    self.playTimeLabel.text = [NSString stringMinAndSecond:total];
    
    [self.playProgressView setProgress: (float)time/total];
    
    [self.musicLrcVC displaySongWord:time];
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
    
    
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - UIButton

- (IBAction)clickLoopBtn:(UIButton *)sender {
}

- (IBAction)clickMusiclistBtn:(UIButton *)sender {
}

- (IBAction)clickPlayBtn:(UIButton *)sender {
}

- (IBAction)clickNextBtn:(UIButton *)sender {
}

- (IBAction)clickPrevBtn:(UIButton *)sender {
}
@end
