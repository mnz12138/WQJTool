//
//  NSObject+MNZ.h
//  WQJTool
//
//  Created by 王全金 on 2017/11/21.
//  Copyright © 2017年 mnz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, OBJECTENUMFLAG) {
    OBJECTENUMFLAGNOTIFICATION = 10000,//通知自动释放标识
};

@interface NSObject (MNZ)

/**
 *  实例方法交叉
 *
 *  @param originalSelector 原方法SEL
 *  @param swizzledSelector 自己实现的SEL
 */
+ (void)swizzleMethod:(SEL)originalSelector andAnotherSelecor:(SEL)swizzledSelector;
/**
 *  类方法交叉
 *
 *  @param originalSelector 原方法SEL
 *  @param swizzledSelector 自己实现的SEL
 */
+ (void)swizzleClassMethod:(SEL)originalSelector andAnotherSelecor:(SEL)swizzledSelector;
/**
 *  方法交叉
 *
 *  @param myClass class
 *  @param originalSelector 原方法SEL
 *  @param swizzledSelector 自己实现的SEL
 */
+ (void)swizzleClass:(Class)myClass originalMethod:(SEL)originalSelector andAnotherSelecor:(SEL)swizzledSelector;
/**判断对象是否为空(各种空)*/
+ (BOOL)isEmptyObject:(id)object;

/**标识obj_flag**/
@property (nonatomic, assign) NSUInteger obj_flag;

@end
