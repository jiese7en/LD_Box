//
//  LDLineinVC.m
//  LD_Box
//
//  Created by Jay on 15/6/12.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDLineinVC.h"
#import "LDLineinVM.h"

@interface LDLineinVC () <LDLineinVMDelegate>

@property (nonatomic, strong) LDLineinVM *viewModel;

@end

@implementation LDLineinVC

#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"音频输入";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.viewModel start];
    
}

#pragma mark - property

- (LDLineinVM *)viewModel {
    if (_viewModel) {
        return _viewModel;
    }
    _viewModel = [[LDLineinVM alloc] init];
    _viewModel.delegate = self;
    return _viewModel;
}

#pragma mark - LDLineinVMDelegate

- (void)lineinStateChanged:(PlayStatus)status {
    
    if (status == STATE_PLAYING) {
        [self.playBtn setImage:[UIImage imageNamed:@"ic_music_pause.png"] forState:UIControlStateNormal];
    }
    else {
        [self.playBtn setImage:[UIImage imageNamed:@"ic_music_play.png"] forState:UIControlStateNormal];
    }
}

#pragma mark - UIButton

- (IBAction)clickPlayBtn:(UIButton *)sender {
    
    [self.viewModel mute];
}
@end
