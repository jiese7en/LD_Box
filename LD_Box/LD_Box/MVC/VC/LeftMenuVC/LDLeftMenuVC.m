//
//  LeftMenuVC.m
//  LD_Box
//
//  Created by Jay on 15/5/29.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDLeftMenuVC.h"

@interface LDLeftMenuVC ()

@end

@implementation LDLeftMenuVC

#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Left";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
}




@end
