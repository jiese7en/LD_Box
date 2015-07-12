//
//  LDMainVC.m
//  LD_Box
//
//  Created by Jay on 15/5/29.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDMainVC.h"
#import "LDMainVM.h"
#import "LDBLEManager.h"


@interface LDMainVC () <LDMainVMDelegate>

@property (nonatomic, strong) LDMainVM *viewModel;

@end

@implementation LDMainVC


#pragma mark - Init

//单例
+ (LDMainVC *)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static LDMainVC * _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    
    return _sharedObject;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"蓝牙音响";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.viewModel start];
    
    
}


#pragma mark - property

- (LDMainVM *)viewModel {
    if (_viewModel) {
        return _viewModel;
    }
    
    _viewModel = [[LDMainVM alloc] init];
    _viewModel.delegate = self;
    return _viewModel;
}

#pragma mark - LDMainVMDelegate

- (void)mainBatteryChanged:(UInt32)battery charging:(BOOL)charging {
    NSString *prefix = @"ico_battery";
    NSString *stem= @"";
    NSString *suffix = [[NSString alloc] initWithFormat:@"_%d.png", (int)battery];

    if (charging) {
        stem = @"incharge";
    }
    NSString *imageName = [[NSString alloc] initWithFormat:@"%@%@%@", prefix, stem, suffix];
    self.batteryImgView.image = [UIImage imageNamed:imageName];

}

- (void)mainVolumeChanged:(UInt32)current max:(UInt32)max min:(UInt32)min isMute:(BOOL)mute {
    if(mute){
        self.soundBtn.selected = YES;
    }
    else{
        self.soundBtn.selected = NO;
    }
    self.soundSlide.maximumValue = max;
    self.soundSlide.minimumValue = min;
    self.soundSlide.value = current;
}

- (void)mainConnectedPeripheralFinished {
    if (BLE_MANGER.curDeviceModel) {
        self.nameLabel.text = BLE_MANGER.curDeviceModel.deviceName;
    }
    else {
        self.nameLabel.text = @"未连接";
    }
}


#pragma mark - Action

- (IBAction)clickSoundBtn:(UIButton *)sender {
    
    [BLE_MANGER.globalManager switchMute];
}

- (IBAction)clickSoundSlide:(UISlider *)sender {
    
    UInt32 nVal = self.soundSlide.value;
    [BLE_MANGER.globalManager setVolume:nVal];
    
}
@end
