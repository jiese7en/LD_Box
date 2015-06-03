/*!
 *  @header GlobalManager.h
 *
 *  @abstract 全局控制对象
 *
 *  @author Actions Semi.
 */

#import <Foundation/Foundation.h>
#import "BluzManagerData.h"

/*!
 *  @protocol GlobalDelegate
 *
 *  @abstract {@link GlobalManager}对象的代理需遵循 <code>GlobalDelegate</code>协议.
 */
@protocol GlobalDelegate <NSObject>

/*!
 *  @method managerReady
 *
 *  @abstract {@link GlobalManager}对象准备就绪
 */
-(void)managerReady;
/*!
 *  @method soundEffectChanged:
 *
 *  @param mode 音效模式
 *
 *  @abstract 音箱音效模式变化
 *
 *  @seealso SoundEffect
 */
-(void)soundEffectChanged:(UInt32)mode;
/*!
 *  @method eqModeChanged:
 *
 *  @param mode EQ模式
 *
 *  @abstract EQ模式变化
 *
 *  @seealso EQMode
 */
-(void)eqModeChanged:(UInt32)mode;
/*!
 *  @method daeModeChangedWithVBASS:andTreble:
 *
 *  @param vbassEnable 虚拟低音音效使能状态
 *  @param trebleEnable 高音增强音效使能状态
 *
 *  @abstract DAE音效模式变化
 */
-(void)daeModeChangedWithVBASS:(BOOL)vbassEnable andTreble:(BOOL)trebleEnable;
/*!
 *  @method batteryChanged:charging:
 *
 *  @param battery 电池电量状态
 *  @param charging 充放电状态
 *
 *  @abstract 音箱电池电量或充放电状态变化
 */
-(void)batteryChanged:(UInt32)battery charging:(BOOL)charging;
/*!
 *  @method volumeChanged:max:min:isMute:
 *
 *  @param current 当前音量
 *  @param max 支持的最大音量
 *  @param min 支持的最小音箱
 *  @param mute 静音状态
 *
 *  @abstract 音箱静音及音量状态变化
 */
-(void)volumeChanged:(UInt32)current max:(UInt32)max min:(UInt32)min isMute:(BOOL)mute;
/*!
 *  @method modeChanged:
 *
 *  @param mode 功能模式
 *
 *  @abstract 音箱功能模式变化
 *
 *  @seealso FuncMode
 */
-(void)modeChanged:(UInt32)mode;
/*!
 *  @method hotplugCardChanged:
 *
 *  @param visibility 卡状态
 *
 *  @abstract 音箱外置卡插拔状态变化
 */
-(void)hotplugCardChanged:(BOOL)visibility;
/*!
 *  @method hotplugUhostChanged:
 *
 *  @param visibility U盘状态
 *
 *  @abstract 音箱外置U盘插拔状态变化
 */
-(void)hotplugUhostChanged:(BOOL)visibility;
/*!
 *  @method lineinChanged:
 *
 *  @param visibility linein线状态
 *
 *  @abstract 音箱Linein连接线插拔状态变化
 */
-(void)lineinChanged:(BOOL)visibility;
/*!
 *  @method dialogMessageArrived:messageID:
 *
 *  @param type 对话框类型
 *  @param messageId 对话框信息序号
 *
 *  @abstract 显示音箱对话框
 *
 *  @seealso DialogType
 */
-(void)dialogMessageArrived:(UInt32)type messageID:(UInt32)messageId;
/*!
 *  @method toastMessageArrived:
 *
 *  @param messageId 提示信息序号
 *
 *  @abstract 显示音箱提示信息
 *
 *  @seealso
 */
-(void)toastMessageArrived:(UInt32)messageId;
/*!
 *  @method dialogCancel
 *
 *  @abstract 取消音箱提示信息
 */
-(void)dialogCancel;
/*!
 *  @method customCommandArrived:param1:param2:others:
 *
 *  @param cmdKey 自定义命令
 *  @param arg1 命令参数一
 *  @param arg2 命令参数二
 *  @param data 其他命令数据
 *
 *  @abstract 自定义命令回调
 *
 *  @seealso buildKey:cmdID:
 *
 *  @discussion 示例代码:
 *
 *      -(void)customCommandArrived:(UInt32)cmdKey param1:(UInt32)arg1 param2:(UInt32)arg2 others:(NSData*)data {
 *
 *      if (cmdKey == [appDele.globalManager buildKey:ANS cmdID:0x80]) {
 *
 *          //收到自定义命令回调，处理返回信息
 *
 *      }
 */
-(void)customCommandArrived:(UInt32)cmdKey param1:(UInt32)arg1 param2:(UInt32)arg2 others:(NSData*)data;

@end

/*!
 *  @protocol GlobalManager
 *
 *  @abstract 全局控制接口，通过{@link BluzManager}的接口来获取。
 */
@protocol GlobalManager <NSObject>

/*!
 *  @method isFeatureSupport:
 *
 *  @param offset 偏移量
 *
 *  @return 是否支持该功能
 *
 *  @abstract 根据特定offset判断音箱是否支持相应功能
 *
 *  @seealso FeatureSupport
 */
-(BOOL)isFeatureSupport:(UInt32)offset;
/*!
 *  @method getMusicFolder
 *
 *  @return 特殊目录列表
 *
 *  @abstract 获取音箱特殊目录
 */
-(NSMutableArray *)getMusicFolder;
/*!
 *  @method setVolume:
 *
 *  @param volume 音量值
 *
 *  @abstract 设置音箱音量
 */
-(void)setVolume:(UInt32)volume;
/*!
 *  @method switchMute
 *
 *  @abstract 设置音箱静音状态
 */
-(void)switchMute;
/*!
 *  @method setMode:
 *
 *  @param mode 功能模式
 *
 *  @abstract 切换音箱的功能模式
 *
 *  @seealso FuncMode
 */
-(void)setMode:(UInt32)mode;
/*!
 *  @method setEQMode:
 *
 *  @param mode EQ模式
 *
 *  @abstract 设置音箱的EQ模式
 *
 *  @seealso EQMode
 */
-(void)setEQMode:(UInt32)mode;
/*!
 *  @method setEQParam:
 *
 *  @param values EQ各频点值
 *
 *  @abstract 设置用户EQ的各个频点值
 */
-(void)setEQParam:(int[])values;
/*!
 *  @method setSoundEffect:eqMode:userEQParam:vbassState:trebleState:
 *
 *  @param effect 音效模式
 *  @param eq EQ模式
 *  @param values 用户EQ频点值
 *  @param vbassEnable 虚拟低音音效使能状态
 *  @param trebleEnable 高音增强音效使能状态
 *
 *  @abstract 设置音箱的音效模式和参数
 *
 *  @seealso SoundEffect
 *  @seealso EQMode
 */
-(void)setSoundEffect:(UInt32)effect eqMode:(UInt32)eq userEQParam:(int[])values vbassState:(BOOL)vbassEnable trebleState:(BOOL)trebleEnable;
/*!
 *  @method setDialogTimeout:
 *
 *  @param timeout 超时时间
 *
 *  @abstract 设置对话框的超时时间
 */
-(void)setDialogTimeout:(UInt32)timeout;
/*!
 *  @method dialogResponse:
 *
 *  @param response 按键序号
 *
 *  @abstract 通知音箱用户点击的按键序号
 *
 *  @seealso DialogAnswer
 */
-(void)dialogResponse:(UInt32)response;
/*!
 *  @method sendCustomCommand:param1:param2:others:
 *
 *  @param cmdKey 命令号
 *  @param arg1 参数一
 *  @param arg2 参数二
 *  @param data 其他参数
 *
 *  @abstract 发送用户自定义命令
 *
 *  @seealso buildKey:cmdID:
 *
 *  @discussion 示例代码:
 *
 *      int key = [appDele.globalManager buildKey:QUE cmdID:0x80];
 *
 *      if (key != -1) {
 *
 *         [appDele.globalManager sendCustomCommand:key param1:0 param2:0 others:nil];
 *
 *      }
 *
 */
-(void)sendCustomCommand:(int)cmdKey param1:(UInt32)arg1 param2:(UInt32)arg2 others:(NSData*)data;
/*!
 *  @method buildKey:cmdID:
 *
 *  @param cmdType 命令类型
 *  @param cmdId 命令号
 *
 *  @return 自定义命令,-1为无效命令
 *
 *  @abstract 生成自定义命令
 */
-(int)buildKey:(int)cmdType cmdID:(int)cmdId;

@end
