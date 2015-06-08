//
//  LDMusicMemoVC.m
//  LD_Box
//
//  Created by Jay on 15/6/8.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDMusicMemoVC.h"
#import "UIFont+LDFont.h"
#import "NSString+LDCategory.h"

@interface LDMusicMemoVC ()

@end

@implementation LDMusicMemoVC

#pragma mark - Init

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Methods

- (void)setMusicInfo:(NSString*)strInfo {
    
    self.musicMemoLabel.frame = CGRectZero;
    self.musicMemoLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.musicMemoLabel.numberOfLines = 0;
    self.musicMemoLabel.font = LD_FONT(18);
    self.musicMemoLabel.text = strInfo;
    self.musicMemoLabel.textAlignment = NSTextAlignmentLeft;
    
    CGSize size = [strInfo getUISize:LD_FONT(18) limitWidth:self.view.bounds.size.width];
    self.musicMemoLabel.frame = CGRectMake(00.0f, 10.0f, size.width, size.height);
}

@end
