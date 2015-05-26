//
//  LDAVAudioManager.h
//  LD_Box
//
//  Created by Jay on 15-5-21.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <Foundation/Foundation.h>



#define AV_AUDIO_MAN [LDAVAudioManager sharedInstance]

@interface LDAVAudioManager : NSObject



//单例
+ (LDAVAudioManager *)sharedInstance;


- (void)prepareAudioSession;

@end
