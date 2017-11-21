//
//  NSObject+MNZ.h
//  WQJTool
//
//  Created by 王全金 on 2017/11/21.
//  Copyright © 2017年 mnz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MNZ)

/**
 *  方法交叉
 *
 *  @param originalSelector 原方法SEL
 *  @param swizzledSelector 自己实现的SEL
 */
+ (void)swizzleMethod:(SEL)originalSelector andAnotherSelecor:(SEL)swizzledSelector;
+ (BOOL)isEmptyObject:(id)object;

@end
