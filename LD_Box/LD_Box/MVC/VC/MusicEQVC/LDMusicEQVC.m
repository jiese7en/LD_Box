//
//  VCMusicEQControl.m
//  BluetoothBox
//
//  Created by huangdw on 13-12-24.
//  Copyright (c) 2013年 Halong. All rights reserved.
//

#import "LDMusicEQVC.h"
#import "CPPickerView.h"
#import "BluzManagerData.h"
#import "CPPickerView.h"
#import "LDMusicEQVM.h"

@interface LDMusicEQVC () <CPPickerViewDataSource, CPPickerViewDelegate>

@property (nonatomic, strong) CPPickerView *pickerView;
@property (nonatomic, strong) LDMusicEQVM *viewModel;
@property (nonatomic, assign) NSInteger eqMode;

@end


 ;

@implementation LDMusicEQVC

#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor clearColor];
    CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI * -0.5);
    self.slider80.transform = trans;
    self.slider200.transform = trans;
    self.slider500.transform = trans;
    self.slider1k.transform = trans;
    self.slider4k.transform = trans;
    self.slider8k.transform = trans;
    self.slider16k.transform = trans;
    self.slider80.enabled=NO;
    self.slider200.enabled=NO;
    self.slider500.enabled=NO;
    self.slider1k.enabled=NO;
    self.slider4k.enabled=NO;
    self.slider8k.enabled=NO;
    self.slider16k.enabled=NO;
    
    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [userDefault objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    if ([preferredLang isEqualToString:@"zh-Hans"]) {
        self.eqLabel.text = @"EQ音效";
        self.noEffectLabel.text = @"无音效";
        self.daeLabel.text = @"DAE音效";
        self.vbassLabel.text = @"虚拟低音";
        self.trebleLabel.text = @"高音增强";
    } else if ([preferredLang isEqualToString:@"zh-Hant"]) {
        self.eqLabel.text = @"EQ音效";
        self.noEffectLabel.text = @"無音效";
        self.daeLabel.text = @"DAE音效";
        self.vbassLabel.text = @"虛擬低音";
        self.trebleLabel.text = @"高音增強";
    } else {
        self.eqLabel.text = @"EQ";
        self.noEffectLabel.text = @"NONE";
        self.daeLabel.text = @"DAE";
        self.vbassLabel.text = @"VBASS";
        self.trebleLabel.text = @"TREBLE";
    }

    self.pickerView = [[CPPickerView alloc] initWithFrame:CGRectMake(175, 100, 80, 30)];
    [self.view addSubview:self.pickerView];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.itemFont = [UIFont boldSystemFontOfSize:14];
    self.pickerView.itemColor = [UIColor blackColor];
    [self.pickerView reloadData];
    self.eqMode = 1;
    [self setEQMode:self.eqMode];
    
    self.effectLabel.text = NSLocalizedString(@"eqsettings", nil);
    NSLog(@"VCMusicEQControl viewDidLoad");
}

#pragma mark - Methods

-(void)setEffect:(NSInteger)effect eqMode:(NSInteger)eq vbassState:(BOOL)vbass trebleState:(BOOL)treble {
    NSLog(@"setEffect %li, %li, %@, %@", (long)effect, (long)eq, vbass?@"YES":@"NO", treble?@"YES":@"NO");
    [self.noEffectSwitch setOn:effect == SOUND_EFFECT_NONE];
    [self.eqSwitch setOn:effect == SOUND_EFFECT_EQ];
    [self.daeSwitch setOn:effect == SOUND_EFFECT_DAE];
    [self.vbassSwitch setOn:vbass];
    [self.trebleSwitch setOn:treble];
    [self enableEQView:effect == SOUND_EFFECT_EQ];
    [self enableDAEView:effect == SOUND_EFFECT_DAE];
    
    if (eq > 0) {
        [self setEQMode:eq];
    }
    
    [self.eqSwitch setEnabled:effect != SOUND_EFFECT_NONE];
    [self.eqLabel setEnabled:effect != SOUND_EFFECT_NONE];
    [self.daeSwitch setEnabled:effect != SOUND_EFFECT_NONE];
    [self.daeLabel setEnabled:effect != SOUND_EFFECT_NONE];
}
-(void)setEQMode:(NSInteger)nMode{
    self.eqMode = nMode;
    [self.pickerView setSelectedItem:(int)nMode - 1];
    self.slider80.enabled=NO;
    self.slider200.enabled=NO;
    self.slider500.enabled=NO;
    self.slider1k.enabled=NO;
    self.slider4k.enabled=NO;
    self.slider8k.enabled=NO;
    self.slider16k.enabled=NO;
    if(nMode==0){
        self.slider80.value=0;
        self.slider200.value=0;
        self.slider500.value=0;
        self.slider1k.value=0;
        self.slider4k.value=0;
        self.slider8k.value=0;
        self.slider16k.value=0;
    }
    else if(nMode==1){   //eq_jazz:3、0、0、-1、0、2、4
        self.slider80.value=3;
        self.slider200.value=0;
        self.slider500.value=0;
        self.slider1k.value=-1;
        self.slider4k.value=0;
        self.slider8k.value=2;
        self.slider16k.value=4;
    }
    else if(nMode==2){   //eq_pop：3、0、0、0、0、-1、-2
        self.slider80.value=3;
        self.slider200.value=0;
        self.slider500.value=0;
        self.slider1k.value=0;
        self.slider4k.value=0;
        self.slider8k.value=-1;
        self.slider16k.value=-2;
    }
    else if(nMode==3){   //eq_classic：0、0、0、-1、-1、-2、-4
        self.slider80.value=0;
        self.slider200.value=0;
        self.slider500.value=0;
        self.slider1k.value=-1;
        self.slider4k.value=-1;
        self.slider8k.value=-2;
        self.slider16k.value=-4;
    }
    else if(nMode==4){   //eq_soft：0、0、1、2、0、1、1
        self.slider80.value=0;
        self.slider200.value=0;
        self.slider500.value=1;
        self.slider1k.value=2;
        self.slider4k.value=0;
        self.slider8k.value=1;
        self.slider16k.value=1;
    }
    else if(nMode==5){   //eq_dbb：5、2、0、0、0、0、6
        self.slider80.value=5;
        self.slider200.value=2;
        self.slider500.value=0;
        self.slider1k.value=0;
        self.slider4k.value=0;
        self.slider8k.value=0;
        self.slider16k.value=6;
    }
    else if(nMode==6){   //eq_rock：5、3、0、-1、0、4、5
        self.slider80.value=5;
        self.slider200.value=3;
        self.slider500.value=0;
        self.slider1k.value=-1;
        self.slider4k.value=0;
        self.slider8k.value=4;
        self.slider16k.value=5;
    }
    else if(nMode==7){   //
        NSUserDefaults * aUserDefaults = [NSUserDefaults standardUserDefaults];
        if([aUserDefaults objectForKey:@"EQValue"]==nil){
            self.slider80.value=0;
            self.slider200.value=0;
            self.slider500.value=0;
            self.slider1k.value=0;
            self.slider4k.value=0;
            self.slider8k.value=0;
            self.slider16k.value=0;
        }
        else{
            NSDictionary* dict=[aUserDefaults objectForKey:@"EQValue"];
            self.slider80.value=[[dict objectForKey:@"slider80"] integerValue];
            self.slider200.value=[[dict objectForKey:@"slider200"] integerValue];
            self.slider500.value=[[dict objectForKey:@"slider500"] integerValue];
            self.slider1k.value=[[dict objectForKey:@"slider1k"] integerValue];
            self.slider4k.value=[[dict objectForKey:@"slider4k"] integerValue];
            self.slider8k.value=[[dict objectForKey:@"slider8k"] integerValue];
            self.slider16k.value=[[dict objectForKey:@"slider16k"] integerValue];
        }
        
        if (!self.noEffectSwitch.on && self.eqSwitch.on) {
            self.slider80.enabled=YES;
            self.slider200.enabled=YES;
            self.slider500.enabled=YES;
            self.slider1k.enabled=YES;
            self.slider4k.enabled=YES;
            self.slider8k.enabled=YES;
            self.slider16k.enabled=YES;
        }
     //   [self sendEQPara];
        [self postNotfication];
    }
}

/*
-(void)sendEQPara{
    NSLog(@"sendEQPara");
    Byte byteEQPara[7]={0};
    byteEQPara[0]=(Byte)((NSInteger)self.slider80.value);
    byteEQPara[1]=(Byte)((NSInteger)self.slider200.value);
    byteEQPara[2]=(Byte)((NSInteger)self.slider500.value);
    byteEQPara[3]=(Byte)((NSInteger)self.slider1k.value);
    byteEQPara[4]=(Byte)((NSInteger)self.slider4k.value);
    byteEQPara[5]=(Byte)((NSInteger)self.slider8k.value);
    byteEQPara[6]=(Byte)((NSInteger)self.slider16k.value);
    NSMutableDictionary* dictPara=[NSMutableDictionary dictionary];
    [dictPara setObject:[NSData dataWithBytes:byteEQPara length:7] forKey:@"EQPara"];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:MsgOfCBLSetEQPara object:self userInfo:dictPara];
}*/


- (void)enableEQView:(BOOL)enable
{
    [self.pickerView setAlpha:enable ? 1.0f : 0.5f];
    self.maxDBLabel.enabled = enable;
    self.midDBLabel.enabled = enable;
    self.minDBLabel.enabled = enable;
    if (self.eqMode == User) {
        self.slider80.enabled = enable;
        self.slider200.enabled = enable;
        self.slider500.enabled = enable;
        self.slider1k.enabled = enable;
        self.slider4k.enabled = enable;
        self.slider8k.enabled = enable;
        self.slider16k.enabled = enable;
    }
    self.eq80Label.enabled = enable;
    self.eq200Label.enabled = enable;
    self.eq500Label.enabled = enable;
    self.eq1kLabel.enabled = enable;
    self.eq4kLabel.enabled = enable;
    self.eq8kLabel.enabled = enable;
    self.eq16kLabel.enabled = enable;
}

- (void)enableDAEView:(BOOL)enable
{
    self.vbassLabel.enabled = enable;
    self.vbassSwitch.enabled = enable;
    self.trebleLabel.enabled = enable;
    self.trebleSwitch.enabled = enable;
}

- (IBAction)doChangedValSlider:(id)sender {
    UISlider* slider=sender;
    NSLog(@"doChangedValSlider, %f", slider.value);
    
    NSMutableDictionary* dict=[NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInteger:(NSInteger)self.slider80.value] forKey:@"slider80"];
    [dict setObject:[NSNumber numberWithInteger:(NSInteger)self.slider200.value] forKey:@"slider200"];
    [dict setObject:[NSNumber numberWithInteger:(NSInteger)self.slider500.value] forKey:@"slider500"];
    [dict setObject:[NSNumber numberWithInteger:(NSInteger)self.slider1k.value] forKey:@"slider1k"];
    [dict setObject:[NSNumber numberWithInteger:(NSInteger)self.slider4k.value] forKey:@"slider4k"];
    [dict setObject:[NSNumber numberWithInteger:(NSInteger)self.slider8k.value] forKey:@"slider8k"];
    [dict setObject:[NSNumber numberWithInteger:(NSInteger)self.slider16k.value] forKey:@"slider16k"];
    NSUserDefaults * aUserDefaults = [NSUserDefaults standardUserDefaults];
    [aUserDefaults setObject:dict forKey:@"EQValue"];
    [aUserDefaults synchronize];
  //  [self sendEQPara];
    [self postNotfication];
}

- (IBAction)doSwitchFlipped:(id)sender
{
    UISwitch *switchView = sender;
    if (switchView == self.noEffectSwitch) {
        self.eqLabel.enabled = !switchView.on;
        self.daeLabel.enabled = !switchView.on;
        self.eqSwitch.enabled = !switchView.on;
        self.daeSwitch.enabled = !switchView.on;
        [self enableDAEView:!switchView.on && self.daeSwitch.on];
        [self enableEQView:!switchView.on && self.eqSwitch.on];
    } else if (switchView == self.eqSwitch) {
        [self.eqSwitch setOn:switchView.on];
        [self enableEQView:switchView.on];
        if (switchView.on == YES) {
            [self.daeSwitch setOn:NO];
            [self enableDAEView:NO];
        }
    } else if (switchView == self.daeSwitch) {
        [self.daeSwitch setOn:switchView.on];
        [self enableDAEView:switchView.on];
        if (switchView.on == YES) {
            [self.eqSwitch setOn:NO];
            [self enableEQView:NO];
        }
    }
    
    [self postNotfication];
}

#pragma mark - NSNotification

- (void)postNotfication {
    NSMutableDictionary* dict=[NSMutableDictionary dictionary];
    
    NSInteger effect = SOUND_EFFECT_NONE;
    if (self.noEffectSwitch.on) {
        effect = SOUND_EFFECT_NONE;
    } else if (self.eqSwitch.on && !self.daeSwitch.on) {
        effect = SOUND_EFFECT_EQ;
    } else if (!self.eqSwitch.on && self.daeSwitch.on) {
        effect = SOUND_EFFECT_DAE;
    }
    [dict setObject:[NSNumber numberWithInteger:effect] forKey:@"SoundEffect"];
    [dict setObject:[NSNumber numberWithInteger:self.eqMode] forKey:@"EQMode"];
    
    NSNumber *on = [NSNumber numberWithInt:1];
    NSNumber *off = [NSNumber numberWithInt:0];
    [dict setObject:self.vbassSwitch.on ? on : off forKey:@"VBASS"];
    [dict setObject:self.trebleSwitch.on ? on : off forKey:@"Treble"];
    
    Byte byteEQPara[7]={0};
    byteEQPara[0]=(Byte)((NSInteger)self.slider80.value);
    byteEQPara[1]=(Byte)((NSInteger)self.slider200.value);
    byteEQPara[2]=(Byte)((NSInteger)self.slider500.value);
    byteEQPara[3]=(Byte)((NSInteger)self.slider1k.value);
    byteEQPara[4]=(Byte)((NSInteger)self.slider4k.value);
    byteEQPara[5]=(Byte)((NSInteger)self.slider8k.value);
    byteEQPara[6]=(Byte)((NSInteger)self.slider16k.value);
    [dict setObject:[NSData dataWithBytes:byteEQPara length:7] forKey:@"EQPara"];
    
    //发送通知
//    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
//    [nc postNotificationName:MsgOfSoundEffect object:self userInfo:dict];
}

#pragma mark - CPPickerViewDelegate

- (void)pickerView:(CPPickerView *)pickerView didSelectItem:(NSInteger)item {
    NSLog(@"didSelectItem: %@", [self.viewModel.eqItemsArr objectAtIndex:item]);
    if (!self.noEffectSwitch.on && self.eqSwitch.on) {
        [self setEQMode:item + 1];
        [self postNotfication];
    } else {
        int select = (self.eqMode - 1) >= 0 ? ((int)self.eqMode - 1) : 0;
        [pickerView setSelectedItem:select];
    }
/*
    NSMutableDictionary* dict=[NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInteger:item] forKey:@"EQMode"];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:MsgOfCBLSetEQMode object:self userInfo:dict];
*/
}

#pragma mark - CPPickerViewDataSource

- (NSInteger)numberOfItemsInPickerView:(CPPickerView *)pickerView {
    return self.viewModel.eqItemsArr.count;
}

- (NSString *)pickerView:(CPPickerView *)pickerView titleForItem:(NSInteger)item {
    return [self.viewModel.eqItemsArr objectAtIndex:item];
}

@end
