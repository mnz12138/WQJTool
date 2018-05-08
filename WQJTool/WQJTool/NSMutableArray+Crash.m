//
//  NSMutableArray+Crash.m
//  WQJTool
//
//  Created by Apple on 2018/5/7.
//  Copyright © 2018年 mnz. All rights reserved.
//

#import "NSMutableArray+Crash.h"
#import "NSObject+MNZ.h"
#import <objc/runtime.h>

@implementation NSMutableArray (Crash)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class arrCls = NSClassFromString(@"__NSArrayM");
        //查
        [self swizzleClass:arrCls originalMethod:@selector(objectAtIndex:) andAnotherSelecor:@selector(mnz_objectAtIndex:)];
        [self swizzleClass:arrCls originalMethod:@selector(objectAtIndexedSubscript:) andAnotherSelecor:@selector(mnz_objectAtIndexedSubscript:)];
        //增
        [self swizzleClass:arrCls originalMethod:@selector(insertObject:atIndex:) andAnotherSelecor:@selector(mnz_insertObject:atIndex:)];
        [self swizzleClass:arrCls originalMethod:@selector(setObject:atIndex:) andAnotherSelecor:@selector(mnz_setObject:atIndex:)];
        [self swizzleClass:arrCls originalMethod:@selector(setObject:atIndexedSubscript:) andAnotherSelecor:@selector(mnz_setObject:atIndexedSubscript:)];
        //删
        [self swizzleClass:arrCls originalMethod:@selector(removeObjectsInRange:) andAnotherSelecor:@selector(mnz_removeObjectsInRange:)];
        //改
        [self swizzleClass:arrCls originalMethod:@selector(replaceObjectAtIndex:withObject:) andAnotherSelecor:@selector(mnz_replaceObjectAtIndex:withObject:)];
    });
}

//查
- (id)mnz_objectAtIndex:(NSUInteger)index {
    if (!self.count || self.count == 0) {
        NSLog(@"%s\n%@",__func__,@"数组为空");
        return nil;
    }
    else if (self.count-1 < index){
        NSLog(@"%s\n%@",__func__,@"数组越界了");
        return nil;
    }
    return [self mnz_objectAtIndex:index];
}
- (id)mnz_objectAtIndexedSubscript:(NSUInteger)index {
    if (!self.count || self.count == 0) {
        NSLog(@"%s\n%@",__func__,@"数组为空");
        return nil;
    }
    else if (self.count-1 < index){
        NSLog(@"%s\n%@",__func__,@"数组越界了");
        return nil;
    }
    return [self mnz_objectAtIndexedSubscript:index];
}
//增
- (void)mnz_insertObject:(id)anObject atIndex:(NSUInteger)index{
    if (index == 0) {
        if (!anObject) {
            NSLog(@"不能为空");
            return;
        }
    }
    else{
        //因为是插入操作 所以在数组最后也可以插入
        if (index> self.count) {
            NSLog(@"%s\n%@",__func__,@"数组越界了");
            return;
        }
        if (!anObject) {
            NSLog(@"不能为空");
            return;
        }
    }
    [self mnz_insertObject:anObject atIndex:index];
}
//增
-(void)mnz_setObject:(id)anObject atIndex:(NSUInteger)index{
    if (!anObject) {
        NSLog(@"不能为空");
        return;
    }
    //可以在最末位增加
    if (index>self.count) {
        NSLog(@"%s\n%@",__func__,@"数组越界了");
        return;
    }
    [self mnz_setObject:anObject atIndex:index];
}
//增
-(void)mnz_setObject:(id)anObject atIndexedSubscript:(NSUInteger)index{
    if (!anObject) {
        NSLog(@"不能为空");
        return;
    }
    //可以在最末位增加
    if (index>self.count) {
        NSLog(@"%s\n%@",__func__,@"数组越界了");
        return;
    }
    [self mnz_setObject:anObject atIndexedSubscript:index];
}
//删
-(void)mnz_removeObjectsInRange:(NSRange)range{
    if (range.location>self.count) {
        NSLog(@"%s\n%@",__func__,@"数组越界了");
        return;
    }
    if ((range.location + range.length)>self.count) {
        NSLog(@"%s\n%@",__func__,@"数组越界了");
        return;
    }
    [self mnz_removeObjectsInRange:range];
}
//改
- (void)mnz_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject{
    if (!self.count || self.count==0) {
        NSLog(@"%s\n%@",__func__,@"数组为空");
        return;
    }
    if (index>=self.count) {
        NSLog(@"%s\n%@",__func__,@"数组越界了");
        return;
    }
    if (!anObject) {
        NSLog(@"不能为空");
        return;
    }
    [self mnz_replaceObjectAtIndex:index withObject:anObject];
}

@end
