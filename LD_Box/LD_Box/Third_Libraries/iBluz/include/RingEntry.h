/*!
 *  @header RingEntry.h
 *
 *  @abstract 闹钟铃声信息
 *
 *  @author Actions Semi.
 */

#import <Foundation/Foundation.h>

/*!
 *  @class RingEntry
 *
 *  @abstract 闹钟铃声信息
 */
@interface RingEntry : NSObject

/*!
 *  @var source 闹钟铃声源
 */
@property(nonatomic, readwrite)UInt32 source;
/*!
 *  @var index 铃声序号
 */
@property(nonatomic, readwrite)UInt32 index;
/*!
 *  @var name 铃声名称
 */
@property(nonatomic, readwrite)NSString *name;

@end
