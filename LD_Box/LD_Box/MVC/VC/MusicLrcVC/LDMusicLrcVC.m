//
//  LDMusicLrcVC.m
//  LD_Box
//
//  Created by Jay on 15/6/8.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDMusicLrcVC.h"
#import "UIFont+LDFont.h"
#import "NSString+LDCategory.h"

@interface LDMusicLrcVC ()

@end

@implementation LDMusicLrcVC

#pragma mark - Init

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Methods

- (void)setMusicInfo:(NSString*)strInfo {
    
    self.musicLrcLabel.frame = CGRectZero;
    self.musicLrcLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.musicLrcLabel.numberOfLines = 0;
    self.musicLrcLabel.font = LD_FONT(18);
    self.musicLrcLabel.text = strInfo;
    self.musicLrcLabel.textAlignment = NSTextAlignmentLeft;
    
    CGSize size = [strInfo getUISize:LD_FONT(18) limitWidth:self.view.bounds.size.width];
    
    self.musicLrcLabel.frame = CGRectMake(00.0f, 10.0f, size.width, size.height);
}

@end
