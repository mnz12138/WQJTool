//
//  NSArray+Crash.m
//  WQJTool
//
//  Created by Apple on 2018/5/7.
//  Copyright © 2018年 mnz. All rights reserved.
//

#import "NSArray+Crash.h"
#import "NSObject+MNZ.h"
#import <objc/runtime.h>

@implementation NSArray (Crash)

+ (void)load {
    // 取值
    [self swizzleClass:objc_getClass("__NSArrayI") originalMethod:@selector(objectAtIndex:) andAnotherSelecor:@selector(mnz_objectAtIndexI:)];
    [self swizzleClass:objc_getClass("__NSArrayI") originalMethod:@selector(objectAtIndexedSubscript:) andAnotherSelecor:@selector(mnz_objectAtIndexedSubscriptI:)];
    
    [self swizzleClass:objc_getClass("__NSArray0") originalMethod:@selector(objectAtIndex:) andAnotherSelecor:@selector(mnz_objectAtIndex0:)];
    [self swizzleClass:objc_getClass("__NSArray0") originalMethod:@selector(objectAtIndexedSubscript:) andAnotherSelecor:@selector(mnz_objectAtIndexedSubscript0:)];
    
    [self swizzleClass:objc_getClass("__NSSingleObjectArrayI") originalMethod:@selector(objectAtIndex:) andAnotherSelecor:@selector(mnz_objectAtIndexSingle:)];
    
    [self swizzleClass:objc_getClass("__NSPlaceholderArray") originalMethod:@selector(objectAtIndex:) andAnotherSelecor:@selector(mnz_objectAtIndexPlaceholder:)];
    
    //赋值
    [self swizzleClass:objc_getClass("__NSPlaceholderArray") originalMethod:@selector(initWithObjects:count:) andAnotherSelecor:@selector(mnz_initWithObjects:count:)];
}
//__NSArrayI
- (id)mnz_objectAtIndexI:(NSUInteger)index {
    if (![self judgeArrayIndex:index]) {
        return nil;
    }
    return [self mnz_objectAtIndexI:index];
}
- (id)mnz_objectAtIndexedSubscriptI:(NSUInteger)idx {
    if (![self judgeArrayIndex:idx]) {
        return nil;
    }
    return [self mnz_objectAtIndexedSubscriptI:idx];
}
//__NSArray0
- (id)mnz_objectAtIndex0:(NSUInteger)index {
    if (![self judgeArrayIndex:index]) {
        return nil;
    }
    return [self mnz_objectAtIndex0:index];
}
- (id)mnz_objectAtIndexedSubscript0:(NSUInteger)idx {
    if (![self judgeArrayIndex:idx]) {
        return nil;
    }
    return [self mnz_objectAtIndexedSubscript0:idx];
}
//__NSSingleObjectArrayI
- (id)mnz_objectAtIndexSingle:(NSUInteger)index {
    if (![self judgeArrayIndex:index]) {
        return nil;
    }
    return [self mnz_objectAtIndexSingle:index];
}
//__NSPlaceholderArray
- (id)mnz_objectAtIndexPlaceholder:(NSUInteger)index {
    NSLog(@"%s\n%s\n%@",class_getName(self.class),__func__,@"数组未初始化");
    return nil;
}
- (BOOL)judgeArrayIndex:(NSUInteger)index{
    if (!self.count || self.count == 0) {
        NSLog(@"%s\n%s\n%@",class_getName(self.class),__func__,@"数组为空");
        return NO;
    }else if (self.count-1 < index){
        NSLog(@"%s\n%s\n%@",class_getName(self.class),__func__,@"数组越界了");
        return NO;
    }
    return YES;
}

#pragma mark initWithObjects:count:
- (id)mnz_initWithObjects:(id  _Nonnull const [])objects count:(NSUInteger)cnt{
    for (int i = 0 ; i<cnt ; i++) {
        if (objects[i] == nil) {
            NSLog(@"数组第%d个参数为空",i);
            return nil;
        }
    }
    return [self mnz_initWithObjects:objects count:cnt];
}

@end
