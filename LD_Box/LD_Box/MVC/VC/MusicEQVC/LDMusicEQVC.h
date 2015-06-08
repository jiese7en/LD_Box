//
//  VCMusicEQControl.h
//  BluetoothBox
//
//  Created by huangdw on 13-12-24.
//  Copyright (c) 2013年 Halong. All rights reserved.
//

#import "LDBaseVC.h"


@interface LDMusicEQVC : LDBaseVC

-(void)setEffect:(NSInteger)effect eqMode:(NSInteger)eq vbassState:(BOOL)vbass trebleState:(BOOL)treble;

@property (weak, nonatomic) IBOutlet UIView *eqSettingView;
@property (weak, nonatomic) IBOutlet UIView *daeSettingView;

@property (weak, nonatomic) IBOutlet UISwitch *noEffectSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *eqSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *daeSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *vbassSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *trebleSwitch;
- (IBAction)doSwitchFlipped:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *effectLabel;
@property (weak, nonatomic) IBOutlet UILabel *noEffectLabel;
@property (weak, nonatomic) IBOutlet UILabel *eqLabel;
@property (weak, nonatomic) IBOutlet UILabel *daeLabel;
@property (weak, nonatomic) IBOutlet UILabel *vbassLabel;
@property (weak, nonatomic) IBOutlet UILabel *trebleLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxDBLabel;
@property (weak, nonatomic) IBOutlet UILabel *midDBLabel;
@property (weak, nonatomic) IBOutlet UILabel *minDBLabel;

@property (weak, nonatomic) IBOutlet UILabel *eq80Label;
@property (weak, nonatomic) IBOutlet UILabel *eq200Label;
@property (weak, nonatomic) IBOutlet UILabel *eq500Label;
@property (weak, nonatomic) IBOutlet UILabel *eq1kLabel;
@property (weak, nonatomic) IBOutlet UILabel *eq4kLabel;
@property (weak, nonatomic) IBOutlet UILabel *eq8kLabel;
@property (weak, nonatomic) IBOutlet UILabel *eq16kLabel;

@property (weak, nonatomic) IBOutlet UISlider *slider80;
@property (weak, nonatomic) IBOutlet UISlider *slider200;
@property (weak, nonatomic) IBOutlet UISlider *slider500;
@property (weak, nonatomic) IBOutlet UISlider *slider1k;
@property (weak, nonatomic) IBOutlet UISlider *slider4k;
@property (weak, nonatomic) IBOutlet UISlider *slider8k;
@property (weak, nonatomic) IBOutlet UISlider *slider16k;
- (IBAction)doChangedValSlider:(id)sender;
@end
