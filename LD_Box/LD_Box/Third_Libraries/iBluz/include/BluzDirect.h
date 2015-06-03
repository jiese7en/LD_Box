/*!
 *  @header BluzDirect.h
 *
 *  @abstract 用户自定义命令收发
 *
 *  @author Actions Semi.
 */

#import <Foundation/Foundation.h>
#import "BluzDevice.h"

@protocol OutputDelegate;

/*!
 *  @class BluzDirect
 *
 *  @abstract 用户自定义命令收发对象
 */
@interface BluzDirect : NSObject<OutputDelegate>

/*!
 *  @method initWithConnector:
 *
 *  @param connector 远程连接设备{@link BluzDevice}
 *
 *  @abstract 构造函数
 *
 *  @return 命令收发对象
 */
-(id)initWithConnector:(BluzDevice *)connector;
/*!
 *  @method send:
 *
 *  @param data 用户自定义命令
 *
 *  @abstract 发送用户自定义命令
 */
-(void)send:(NSData *)data;
/*!
 *  @method fetch:withOutput
 *
 *  @param count 获取数据长度
 *  @param output 获取数据的缓冲区，应用申请
 *
 *  @return 实际获取到的长度
 *
 *  @abstract 获取命令返回的结果
 */
-(NSInteger)fetch:(NSInteger)count withOutput:(NSData *)output;

@end
