/*!
 *  @header BluzDevice.h
 *
 *  @abstract 蓝牙BLE设备扫描及连接对象
 *
 *  @author Actions Semi.
 */

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreBluetooth/CBService.h>

/*!
 *  @protocol TimeoutDelegate
 *
 *  @abstract 声明命令超时协议(应用无需处理).
 */
@protocol TimeoutDelegate;

/*!
 *  @protocol ConnectDelegate
 *
 *  @abstract 蓝牙BLE搜索及连接协议.
 */
@protocol ConnectDelegate <NSObject>

@required
/*!
 *  @method foundPeripheral:advertisementData:
 *
 *  @param peripheral 蓝牙设备对象
 *  @param advertisementData 包含蓝牙设备广播信息或者蓝牙搜索回应数据的字典容器。
 *
 *  @abstract 搜索蓝牙时返回的蓝牙设备信息。
 *
 *  @seealso scanStart
 */
-(void)foundPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData;
/*!
 *  @method connectedPeripheral:
 *
 *  @param peripheral 蓝牙设备对象
 *
 *  @abstract 连接蓝牙时返回已经连接上的蓝牙设备信息。
 *
 *  @seealso connect:
 */
-(void)connectedPeripheral:(CBPeripheral*) peripheral;

@optional
/*!
 *  @method disconnectedPeripheral:
 *
 *  @param peripheral 蓝牙设备对象
 *
 *  @abstract 断开蓝牙时返回已经断开的蓝牙设备信息。
 *
 *  @seealso disconnect:
 */
-(void)disconnectedPeripheral:(CBPeripheral*) peripheral;
/*!
 *  @method disconnectedPeripheral:initiative:
 *
 *  @param peripheral 蓝牙设备对象
 *  @param onInitiative 是否用户主动断开连接
 *
 *  @abstract 断开蓝牙时返回已经断开的蓝牙设备信息。
 *
 *  @seealso disconnect:
 */
-(void)disconnectedPeripheral:(CBPeripheral*) peripheral initiative:(BOOL)onInitiative;

@end

/*!
 *  @class BluzDevice
 *
 *  @abstract 负责蓝牙搜索、连接等操作的对象
 */
@interface BluzDevice : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate,TimeoutDelegate>

/*!
 *  @method setConnectDelegate:
 *
 *  @param delegate 蓝牙设备搜索及连接协议
 *
 *  @abstract 设置蓝牙设备搜索及连接协议。
 *
 *  @seealso ConnectDelegate
 */
-(void)setConnectDelegate:(id<ConnectDelegate>) delegate;
/*!
 *  @method scanStop
 *
 *  @abstract 停止搜索周围蓝牙设备。
 */
-(void)scanStop;
/*!
 *  @method scanStart
 *
 *  @abstract 开始搜索周围的蓝牙设备。
 *
 *  @seealso foundPeripheral:advertisementData:
 */
-(void)scanStart;
/*!
 *  @method connect:
 *
 *  @param peripheral 蓝牙设备对象
 *
 *  @abstract 主动连接设定的蓝牙设备。
 *
 *  @seealso connectedPeripheral:
 */
-(void)connect:(CBPeripheral*)peripheral;
/*!
 *  @method disconnect:
 *
 *  @param peripheral 蓝牙设备对象
 *
 *  @abstract 主动断开当前已经连接的蓝牙设备。
 *
 *  @seealso disconnectedPeripheral:
 */
-(void)disconnect:(CBPeripheral*)peripheral;
/*!
 *  @method setAppForeground:
 *
 *  @param foreground 应用前后台状态
 *
 *  @abstract 通知iBluz应用当前的前、后台状态
 *
 *  @discussion 在后台时iBluz不进行BLE的数据收发，用以优化音箱资源开销。
 */
-(void)setAppForeground:(BOOL)foreground;
/*!
 *  @method close
 *
 *  @abstract 关闭并清理<code>BluzDevice</code>类对象。
 */
-(void)close;

@end
