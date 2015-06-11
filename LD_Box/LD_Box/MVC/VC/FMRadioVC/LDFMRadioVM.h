//
//  LDFMRadioVM.h
//  LD_Box
//
//  Created by Jay on 15/6/12.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol LDFMRadioVMDelegate <NSObject>

@optional



@end


@interface LDFMRadioVM : NSObject

@property (nonatomic, assign) id <LDFMRadioVMDelegate> delegate;

- (void)start;

@end
