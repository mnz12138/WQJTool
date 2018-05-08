//
//  NSMutableDictionary+Crash.m
//  WQJTool
//
//  Created by Apple on 2018/5/7.
//  Copyright © 2018年 mnz. All rights reserved.
//

#import "NSMutableDictionary+Crash.h"
#import "NSObject+MNZ.h"

@implementation NSMutableDictionary (Crash)

+ (void)load {
    Class dictCls = NSClassFromString(@"__NSDictionaryM");
    [self swizzleClass:dictCls originalMethod:@selector(setObject:forKey:) andAnotherSelecor:@selector(mnz_setObject:forKey:)];
    [self swizzleClass:dictCls originalMethod:@selector(setObject:forKeyedSubscript:) andAnotherSelecor:@selector(mnz_setObject:forKeyedSubscript:)];
    [self swizzleClass:dictCls originalMethod:@selector(removeObjectForKey:) andAnotherSelecor:@selector(mnz_removeObjectForKey:)];
}

- (void)mnz_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    if (obj&&key) {
        [self mnz_setObject:obj forKeyedSubscript:key];
    }
}

- (void)mnz_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (anObject&&aKey) {
        [self mnz_setObject:anObject forKey:aKey];
    }
}

- (void)mnz_removeObjectForKey:(id)aKey {
    if (aKey) {
        [self mnz_removeObjectForKey:aKey];
    }
}

@end
