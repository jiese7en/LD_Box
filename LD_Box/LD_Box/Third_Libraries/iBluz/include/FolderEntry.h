/*!
 *  @header FolderEntry.h
 *
 *  @abstract 文件目录条目
 *
 *  @author Actions Semi.
 */

#import <Foundation/Foundation.h>

/*!
 *  @class FolderEntry
 *
 *  @abstract 音乐、铃声等目录信息
 */
@interface FolderEntry : NSObject

/*!
 *  @var value 目录(应用)类型(模式)
 */
@property(nonatomic, readwrite)UInt32 value;
/*!
 *  @var modeComand 应用模式参数
 */
@property(nonatomic, readwrite)UInt32 modeComand;
/*!
 *  @var name 目录名称
 */
@property(nonatomic, readwrite)NSString *name;

@end
