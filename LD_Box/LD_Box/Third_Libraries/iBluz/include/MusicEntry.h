/*!
 *  @header MusicEntry.h
 *
 *  @abstract 音乐条目
 *
 *  @author Actions Semi.
 */

#import <Foundation/Foundation.h>

/*!
 *  @class MusicEntry
 *
 *  @abstract 保存音乐条目信息
 */
@interface MusicEntry : NSObject

/*!
 *  @var index 音乐序号
 */
@property(nonatomic,readwrite)UInt32 index;
/*!
 *  @var mimeType 格式信息
 */
@property(nonatomic,retain)NSString* mimeType;
/*!
 *  @var name 音乐名称(带后缀)
 */
@property(nonatomic,strong)NSString* name;
/*!
 *  @var title 音乐标题(不带后缀)
 */
@property(nonatomic,strong)NSString* title;
/*!
 *  @var artist 演唱者
 */
@property(nonatomic,retain)NSString* artist;
/*!
 *  @var album 专辑名称
 */
@property(nonatomic,retain)NSString* album;
/*!
 *  @var genre 风格
 */
@property(nonatomic,retain)NSString* genre;
/*!
 *  @var lyric 是否有歌词
 */
@property(nonatomic,readwrite)BOOL lyric;

@end
