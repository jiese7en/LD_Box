/*!
 *  @header AlarmEntry.h
 *
 *  @abstract 闹钟条目
 *
 *  @author Actions Semi.
 */

#import <Foundation/Foundation.h>

/*!
 *  @class AlarmEntry
 *
 *  @abstract 保存闹钟条目各个参数信息
 */
@interface AlarmEntry : NSObject

/*!
 *  @var state 闹钟使能状态
 */
@property(nonatomic,readwrite)BOOL state;
/*!
 *  @var index 闹钟条目序号
 */
@property(nonatomic,readwrite)UInt32 index;
/*!
 *  @var title 闹钟条目标题。
 */
@property(nonatomic,retain)NSString* title;
/*!
 *  @var hour 闹铃时间，时。
 */
@property(nonatomic,readwrite)UInt32 hour;
/*!
 *  @var minute 闹铃时间，分。
 */
@property(nonatomic,readwrite)UInt32 minute;
/*!
 *  @var second 闹铃时间，秒。
 */
@property(nonatomic,readwrite)UInt32 second;
/*!
 *  @var repeat 闹钟重复周期，Byte由低位到高位依次表示周日、周一、周二...周六。
 */
@property(nonatomic,readwrite)Byte repeat;
/*!
 *  @var ringType 闹钟铃声类型。
 */
@property(nonatomic,readwrite)UInt32 ringType;
/*!
 *  @var ringId 闹钟铃声序号。
 */
@property(nonatomic,readwrite)UInt32 ringId;

@end
