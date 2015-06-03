/*!
 *  @header AuxManager.h
 *
 *  @abstract Aux(Linein)控制对象
 *
 *  @author Actions Semi.
 */

#import <Foundation/Foundation.h>

/*!
 *  @protocol AuxDelegate
 *
 *  @abstract {@link AuxManager}对象的代理需遵循 <code>AuxDelegate</code>协议.
 */
@protocol AuxDelegate <NSObject>

/*!
 *  @method managerReady:
 *
 *  @param mode   设备当前的模式
 *
 *  @abstract {@link AuxManager}对象准备就绪
 */
-(void)managerReady:(UInt32)mode;
/*!
 *  @method stateChanged:
 *
 *  @param state   Linein当前状态
 *
 *  @abstract Linein状态变化
 */
-(void)stateChanged:(UInt32)state;

@end

/*!
 *  @protocol AuxManager
 *
 *  @abstract Aux(Linein)管理接口，通过{@link BluzManager}的接口来获取。
 */
@protocol AuxManager <NSObject>

/*!
 *  @method mute
 *
 *  @abstract 控制Linein静音状态。
 */
-(void)mute;

@end
