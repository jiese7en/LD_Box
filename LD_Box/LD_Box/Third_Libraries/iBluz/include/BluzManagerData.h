/*!
 *  @header BluzManagerData.h
 *
 *  @abstract BluzManager数据对象
 *
 *  @author Actions Semi.
 */

#import <Foundation/Foundation.h>
#import "AlarmEntry.h"
#import "RingEntry.h"
#import "FolderEntry.h"
#import "MusicEntry.h"
#import "RadioEntry.h"

/*!
 *  @enum FuncMode
 *
 *  @abstract 音箱功能模式。
 *
 *  @constant MODE_UNKNOWN  未知模式。
 *  @constant MODE_A2DP     A2DP推送模式。
 *  @constant MODE_CARD     卡歌曲播放模式。
 *  @constant MODE_UHOST    U盘歌曲播放模式。
 *  @constant MODE_LINEIN   Linein模式。
 *  @constant MODE_RADIO    收音机模式。
 *  @constant MODE_ALARM    闹钟模式。
 *  @constant MODE_URECORD  U盘录音回放模式。
 *  @constant MODE_CRECORD  卡录音回放模式。
 *
 */
typedef enum {
    MODE_UNKNOWN    = -1,
    MODE_A2DP       = 0,
    MODE_CARD       = 1,
    MODE_UHOST      = 2,
    MODE_LINEIN     = 3,
    MODE_RADIO      = 4,
    MODE_ALARM      = 8,
    MODE_URECORD    = 9,
    MODE_CRECORD    = 10,
}FuncMode;

/*!
 *  @enum FeatureSupport
 *
 *  @abstract 音箱功能支持标志。
 *
 *  @constant FeatureA2dp         支持A2DP推送功能标志。
 *  @constant FeatureCard         支持卡歌曲播放功能标志。
 *  @constant FeatureUhost        支持U盘歌曲播放功能标志。
 *  @constant FeatureRecPlayback  支持录音回放功能标志。
 *  @constant FeatureFolder       支持特殊目录功能标志。
 *  @constant FeatureRadio        支持收音机功能标志。
 *  @constant FeatureLinein       支持Linein功能标志。
 *  @constant FeatureRecMic       支持Mic录音功能标志。
 *  @constant FeatureRecFm        支持FM录制功能标志。
 *  @constant FeatureRecAux       支持Linein录制功能标志。
 *  @constant FeatureAlarm        支持闹钟功能标志。
 *  @constant FeatureRingBuildin  支持内建铃声功能标志。
 *  @constant FeatureRingFolder   支持特殊铃声目录功能标志。
 *  @constant FeatureRingPlaylist 支持铃声列表功能标志。
 *  @constant FeatureRingFm       支持FM铃声功能标志。
 *
 */
typedef enum {
    FeatureA2dp         = 0,
    FeatureCard         = 1,
    FeatureUhost        = 2,
    FeatureRecPlayback  = 3,
    FeatureFolder       = 4,
    FeatureRadio        = 5,
    FeatureLinein       = 6,
    FeatureRecMic       = 7,
    FeatureRecFm        = 8,
    FeatureRecAux       = 9,
    FeatureAlarm        = 10,
    FeatureRingBuildin  = 11,
    FeatureRingFolder   = 12,
    FeatureRingPlaylist = 13,
    FeatureRingFm       = 14,
}FeatureSupport;

/*!
 *  @enum PlayStatus
 *
 *  @abstract 音箱功能状态。
 *
 *  @constant STATE_UNKNOWN  未知或异常状态。
 *  @constant STATE_PAUSED   暂停状态。
 *  @constant STATE_PLAYING  播放状态。
 *
 */
typedef enum {
    STATE_UNKNOWN = -1,
    STATE_PAUSED  = 1,
    STATE_PLAYING = 2
}PlayStatus;

/*!
 *  @enum LoopMode
 *
 *  @abstract 音乐循环模式。
 *
 *  @constant LOOP_MODE_UNKNOWN 未知模式。
 *  @constant LOOP_MODE_ALL     全部循环。
 *  @constant LOOP_MODE_SINGLE  单曲循环。
 *  @constant LOOP_MODE_SHUFFLE 随机播放。
 */
typedef enum {
    LOOP_MODE_UNKNOWN   = -1,
    LOOP_MODE_ALL       = 0,
    LOOP_MODE_SINGLE    = 1,
    LOOP_MODE_SHUFFLE   = 3
}LoopMode;

/*!
 *  @enum SoundEffect
 *
 *  @abstract EQ模式。
 *
 *  @constant NONE    无音效。
 *  @constant EQ      EQ音效。
 *  @constant DAE     DAE音效。
 *
 */
typedef enum {
    SOUND_EFFECT_NONE      = 0,
    SOUND_EFFECT_EQ        = 1,
    SOUND_EFFECT_DAE       = 2
}SoundEffect;

/*!
 *  @enum EQMode
 *
 *  @abstract EQ模式。
 *
 *  @constant Jazz      爵士。
 *  @constant Pop       流行。
 *  @constant Classic   经典。
 *  @constant Soft      柔和。
 *  @constant DBB       重低音。
 *  @constant Rock      摇滚。
 *  @constant User      用户模式。
 *
 */
typedef enum {
    Jazz        = 1,
    Pop         = 2,
    Classic     = 3,
    Soft        = 4,
    DBB         = 5,
    Rock        = 6,
    User        = 7
}EQMode;

/*!
 *  @enum RadioBand
 *
 *  @abstract 收音机频段。
 *
 *  @constant BAND_CHINA_US 中/美频段。
 *  @constant BAND_JAPAN    日本频段。
 *  @constant BAND_EUROP    欧洲频段。
 *
 */
typedef enum {
    BAND_CHINA_US   = 0,
    BAND_JAPAN      = 1,
    BAND_EUROP      = 2,
}RadioBand;

/*!
 *  @enum RingSource
 *
 *  @abstract 闹钟铃声类型。
 *
 *  @constant UHOST         U盘歌曲类型。
 *  @constant CARD          卡歌曲类型。
 *  @constant FM            收音机类型。
 *  @constant INTERNAL      内置类型。
 *  @constant EXTERNAL1     外置类型一。
 *  @constant EXTERNAL2     外置类型二。
 *  @constant EXTERNAL3     外置类型三。
 *  @constant EXTERNAL4     外置类型四。
 *  @constant SOURCE_COUNT  类型总数。
 *
 */
typedef enum {
    UHOST           = 0,
    CARD            = 1,
    FM              = 2,
    INTERNAL        = 3,
    EXTERNAL1       = 4,
    EXTERNAL2       = 5,
    EXTERNAL3       = 6,
    EXTERNAL4       = 7,
    SOURCE_COUNT    = 8
}RingSource;

/*!
 *  @enum DialogType
 *
 *  @abstract 音箱对话框类型。
 *
 *  @constant DIALOG_NOTICE         普通对话框。
 *  @constant DIALOG_USB_CONNECTED  USB已连接。
 *
 */
typedef enum {
    DIALOG_NOTICE           = 0,
    DIALOG_USB_CONNECTED    = 5
}DialogType;

/*!
 *  @enum DialogResponseParam
 *
 *  @abstract 音箱对话框应答参数。
 *
 *  @constant DIALOG_TIMEOUT    超时。
 *  @constant DIALOG_ANSWER     应答。
 *
 */
typedef enum {
    DIALOG_TIMEOUT          = 0,
    DIALOG_ANSWER           = 1,
}DialogResponseParam;

/*!
 *  @enum DialogAnswer
 *
 *  @abstract 音箱对话框应答。
 *
 *  @constant DIALOG_ANSWER_OK      确定。
 *  @constant DIALOG_ANSWER_CANCEL  取消。
 *
 */
typedef enum {
    DIALOG_ANSWER_OK        = 0,
    DIALOG_ANSWER_CANCEL    = 1,
}DialogAnswer;

/*!
 *  @enum CommandType
 *
 *  @abstract 命令类型。
 *
 *  @constant APP  应用切换。
 *  @constant CTL  控制。
 *  @constant QUE  查询。
 *  @constant SET  设置。
 *  @constant ANS  应答。
 *
 */
typedef enum {
    APP     = 1,
    CTL     = 2,
    QUE     = 3,
    SET     = 4,
    ANS     = 5,
}CommandType;


