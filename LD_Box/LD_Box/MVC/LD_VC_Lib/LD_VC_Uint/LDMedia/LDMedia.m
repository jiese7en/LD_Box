//
//  LDMedia.m
//  LD_Box
//
//  Created by Jay on 15/5/26.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDMedia.h"
#import "LDMusicBeanModel.h"

//MediaPlayer
#import <MediaPlayer/MPMediaQuery.h>
#import <MediaPlayer/MPMediaPlaylist.h>
#import <MediaPlayer/MPMediaItem.h>
#import <MEdiaPlayer/MPNowPlayingInfoCenter.h>
#import <AVFoundation/AVFoundation.h>

@implementation LDMedia


#pragma mark - Methods

+ (NSArray *)getMusicMessage {
    
    MPMediaQuery *myPlaylistsQuery = [MPMediaQuery songsQuery];
    
    NSArray *playlists = [myPlaylistsQuery collections];
    
    NSMutableArray *musicArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (MPMediaPlaylist *playlist in playlists) {
        NSArray *array = [playlist items];
        for (MPMediaItem *song in array) {
            LDMusicBeanModel * mbModel = [[LDMusicBeanModel alloc] init];
            MPMediaItemArtwork *artwork = [song valueForProperty: MPMediaItemPropertyArtwork];
            UIImage *artworkImages = [artwork imageWithSize:CGSizeMake(320, 265)];
            if (artworkImages) {
                mbModel.m_musicCover = (UIImage *)artworkImages;
            } else {
                mbModel.m_musicCover = [UIImage imageNamed: @"ic_album_cover_default"];
            }
            
            mbModel.m_musicName = [song valueForProperty: MPMediaItemPropertyTitle];
            
            NSURL* songURL = [song valueForProperty:MPMediaItemPropertyAssetURL];
            AVAsset* songAsset = [AVURLAsset URLAssetWithURL:songURL options:nil];
            NSString* lyrics = [songAsset lyrics];
            
            mbModel.m_Lyrics = lyrics;
            if (mbModel.m_Lyrics.length == 0) {
                mbModel.m_Lyrics = @"";
            }
            mbModel.m_url =  [song valueForProperty: MPMediaItemPropertyAssetURL];
            mbModel.m_AlbumTitle = [song valueForKey:MPMediaItemPropertyAlbumTitle];
            if(mbModel.m_AlbumTitle.length==0){
                mbModel.m_AlbumTitle = NSLocalizedString(@"unknown", nil);
            }
            mbModel.m_AlbumArtist=[song valueForKey:MPMediaItemPropertyAlbumArtist];
            if(mbModel.m_AlbumArtist.length==0){
                mbModel.m_AlbumArtist = NSLocalizedString(@"unknown", nil);
            }
            mbModel.m_singerName = [song valueForKey:MPMediaItemPropertyArtist];
            if(mbModel.m_singerName.length==0){
                mbModel.m_singerName = NSLocalizedString(@"unknown", nil);
            }
            //计算音乐文件所需要的时间
            CGFloat dblTotal=[[song valueForKey:MPMediaItemPropertyPlaybackDuration] floatValue];
            
            int seconds = (int)dblTotal;
            int minute = 0;
            if (seconds >= 60) {
                int index = seconds / 60;
                minute = index;
                seconds = seconds - index * 60;
            }
            mbModel.m_musicTime = [NSString stringWithFormat:@"%02d:%02d", minute, seconds];
            [mbModel setTotalTime:dblTotal];
            [musicArr addObject:mbModel];
        }
#if 0
        if (self.musicArr.count == 10) {
            //尽量快的时间显示出第一屏
            tmpTable = 10;
            [self.musicTableView reloadData];
            [self.musicTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:tmpTable-1 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        }
#endif
    }
    
    return musicArr;
}


@end
