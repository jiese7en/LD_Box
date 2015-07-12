//
//  LDMainVC.h
//  LD_Box
//
//  Created by Jay on 15/5/29.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDBaseVC.h"

@interface LDMainVC : LDBaseVC

//单例
+ (LDMainVC *)sharedInstance;



@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *batteryImgView;
@property (weak, nonatomic) IBOutlet UILabel *batteryLabel;
@property (weak, nonatomic) IBOutlet UISlider *soundSlide;
@property (weak, nonatomic) IBOutlet UIButton *soundBtn;
- (IBAction)clickSoundBtn:(UIButton *)sender;
- (IBAction)clickSoundSlide:(UISlider *)sender;

@end
