/*!
 *  @header RadioManager.h
 *
 *  @abstract 收音机控制对象
 *
 *  @author Actions Semi.
 */


/*!
 *  @protocol RadioDelegate
 *
 *  @discussion {@link RadioManager}对象的代理需遵循 <code>RadioDelegate</code>协议.
 */
@protocol RadioDelegate <NSObject>

/*!
 *  @method managerReady:
 *
 *  @param mode 音箱当前的模式
 *
 *  @abstract {@link RadioManager}对象准备就绪
 *
 *  @seealso FuncMode
 */
-(void)managerReady:(UInt32)mode;
/*!
 *  @method radioListChanged:
 *
 *  @param channelList 电台列表
 *
 *  @abstract 音箱返回搜到得电台列表
 */
-(void)radioListChanged:(NSMutableArray*)channelList;
/*!
 *  @method radioStateChanged:
 *
 *  @param state 当前模式
 *
 *  @abstract 收音机当前模式变化
 */
-(void)radioStateChanged:(UInt32)state;
/*!
 *  @method channelChanged:
 *
 *  @param channel 当前电台频率
 *
 *  @abstract 当前电台频率变化
 *
 *  @seealso select:
 */
-(void)channelChanged:(UInt32)channel;
/*!
 *  @method bandChanged:
 *
 *  @param band 当前频段
 *
 *  @abstract 收音机当前频段变化
 *
 *  @seealso setBand:
 *  @seealso RadioBand
 */
-(void)bandChanged:(UInt32)band;

@end

/*!
 *  @protocol RadioManager
 *
 *  @discussion 收音机控制接口，通过{@link BluzManager}的接口来获取。
 */
@protocol RadioManager <NSObject>

/*!
 *  @method select:
 *
 *  @param channel 电台频率
 *
 *  @abstract 设置电台频率
 *
 *  @seealso channelChanged:
 */
-(void)select:(UInt32)channel;
/*!
 *  @method scanStart:
 *
 *  @abstract 开始搜台
 */
-(void)scanStart;
/*!
 *  @method scanStop
 *
 *  @abstract 结束搜台
 */
-(void)scanStop;
/*!
 *  @method getCurrentChannel
 *
 *  @return 当前电台频率
 *
 *  @abstract 获取当前电台频率
 */
-(UInt32)getCurrentChannel;
/*!
 *  @method switchMute
 *
 *  @abstract 设置收音机静音状态
 */
-(void)switchMute;
/*!
 *  @method getChannelList
 *
 *  @abstract 获取电台列表
 *
 *  @seealso radioListChanged:
 */
-(void)getChannelList;
/*!
 *  @method setBand:
 *
 *  @param band 收音机频段
 *
 *  @abstract 切换收音机频段
 *
 *  @discussion 可选中/美、日本、欧洲，三种频段。
 *
 *  @seealso bandChanged:
 *  @seealso RadioBand
 */
-(void)setBand:(UInt32)band;

@end
