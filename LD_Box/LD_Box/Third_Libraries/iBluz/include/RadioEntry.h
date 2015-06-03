/*!
 *  @header RadioEntry.h
 *
 *  @abstract 电台信息
 *
 *  @author Actions Semi.
 */

#import <Foundation/Foundation.h>

/*!
 *  @class RadioEntry
 *
 *  @abstract 电台信息
 */
@interface RadioEntry : NSObject

/*!
 *  @var channel 电台频率
 */
@property(nonatomic,readwrite)UInt32 channel;
/*!
 *  @var name 电台名称
 */
@property(nonatomic,retain)NSString* name;

@end
