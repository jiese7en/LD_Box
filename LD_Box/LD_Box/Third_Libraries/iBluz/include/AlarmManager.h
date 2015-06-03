/*!
 *  @header AlarmManager.h
 *
 *  @abstract 闹钟控制对象
 *
 *  @author Actions Semi.
 */


#import <Foundation/Foundation.h>
#import "AlarmEntry.h"

/*!
 *  @protocol AlarmDelegate
 *
 *  @discussion {@link AlarmManager}对象的代理需遵循 <code>AlarmDelegate</code>协议.
 */
@protocol AlarmDelegate <NSObject>

/*!
 *  @method managerReady:
 *
 *  @param mode 设备当前的模式
 *
 *  @abstract {@link AlarmManager}对象准备就绪
 *
 *  @seealso  FuncMode
 */
-(void)managerReady:(UInt32)mode;
/*!
 *  @method alarmStateChanged:
 *
 *  @param state 闹铃当前状态
 *
 *  @abstract 闹铃状态变化
 */
- (void)alarmStateChanged:(UInt32)state;
/*!
 *  @method alarmListArrived:
 *
 *  @param alarmList 音箱闹钟条目列表
 *
 *  @abstract 获取到闹钟条目{@link AlarmEntry}列表对象
 *
 *  @seealso getAlarmList
 */
-(void)alarmListArrived:(NSMutableArray*)alarmList;
/*!
 *  @method ringListArrived:
 *
 *  @param ringList 闹钟铃声条目列表
 *
 *  @abstract 获取到铃声条目{@link RingEntry}列表对象
 *
 *  @seealso getRingList
 */
-(void)ringListArrived:(NSMutableArray*)ringList;
/*!
 *  @method folderListArrived:
 *
 *  @param folderList 闹钟铃声目录列表
 *
 *  @abstract 获取到铃声目录{@link FolderEntry}列表对象
 *
 *  @seealso getRingFolderList
 */
-(void)folderListArrived:(NSMutableArray*)folderList;

@end

/*!
 *  @protocol AlarmManager
 *
 *  @abstract 闹钟管理接口，通过{@link BluzManager}的接口来获取
 */
@protocol AlarmManager <NSObject>

/*!
 *  @method setAlarm:
 *
 *  @param alarm 闹钟条目
 *
 *  @abstract 增加闹钟条目{@link AlarmEntry}或修改音箱上已有的闹钟条目。
 *
 *  @discussion 音箱支持最多设置4条闹钟。
 */
-(void)setAlarm:(AlarmEntry*)alarm;
/*!
 *  @method removeAlarm:
 *
 *  @param alarm 闹钟条目
 *
 *  @abstract 移除音箱上的指定闹钟条目{@link AlarmEntry}。
 */
-(void)removeAlarm:(AlarmEntry*)alarm;
/*!
 *  @method removeAll:
 *
 *  @abstract 移除音箱上所有闹钟条目。
 */
-(void)removeAll;
/*!
 *  @method getAlarmList:
 *
 *  @abstract 获取音箱上已有的闹钟列表。
 *
 *  @seealso alarmListArrived:
 */
-(void)getAlarmList;
/*!
 *  @method getRingList:
 *
 *  @abstract 获取闹钟铃声列表。
 *
 *  @seealso ringListArrived:
 */
-(void)getRingList;
/*!
 *  @method snooze:
 *
 *  @abstract 闹铃贪睡，延时5分钟再起闹。
 */
-(void)snooze;
/*!
 *  @method off:
 *
 *  @abstract 关闭当前闹铃。
 */
-(void)off;
/*!
 *  @method getRingFolderList:
 *
 *  @abstract 获取闹钟铃声目录。
 * 
 *  @seealso folderListArrived:
 */
-(void)getRingFolderList;

@end
