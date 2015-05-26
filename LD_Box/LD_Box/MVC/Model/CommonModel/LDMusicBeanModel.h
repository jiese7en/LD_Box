//
//  LDMusicBeanModel.h
//  LD_Box
//
//  Created by Jay on 15/5/24.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface LDMusicBeanModel : NSObject {
    CGFloat m_fTotalTime;
}
-(void) setTotalTime:(CGFloat)fTime;
-(CGFloat) getTotalTime;

@property(nonatomic,strong)NSString* m_musicName;   //歌曲名
@property(nonatomic,strong)NSString* m_musicTitle;   //标题
@property(nonatomic,strong)NSString* m_musicAlbum;   //专辑
@property(nonatomic,strong)NSString* m_musicArtist;   //歌手
@property(nonatomic,strong)NSString* m_musicGenre;   //风格
@property(nonatomic,strong)NSString* m_musicType;   //格式

@property(nonatomic,strong)NSURL* m_url;            //歌曲地址
@property(nonatomic,strong)NSString* m_singerName;  //演唱者
@property(nonatomic,strong)NSString* m_musicTime;   //总时间
@property(nonatomic,strong)UIImage * m_musicCover;   //封面
@property(nonatomic,strong)NSString* m_AlbumTitle;  //专辑名
@property(nonatomic,strong)NSString* m_AlbumArtist; //专辑歌手
@property(nonatomic,strong)NSString* m_Lyrics;      //歌词

@end
