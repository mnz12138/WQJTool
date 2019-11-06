//
//  NSNotificationCenter+Crash.m
//  WQJTool
//
//  Created by Apple on 2018/5/7.
//  Copyright © 2018年 mnz. All rights reserved.
//

#import "NSNotificationCenter+Crash.h"
#import "NSObject+MNZ.h"

@implementation NSNotificationCenter (Crash)

+ (void)load {
    [self swizzleMethod:@selector(addObserver:selector:name:object:) andAnotherSelecor:@selector(mnz_addObserver:selector:name:object:)];
}

- (void)mnz_addObserver:(id)observer selector:(SEL)aSelector name:(NSNotificationName)aName object:(id)anObject {
    if ([observer conformsToProtocol:@protocol(NSObject)]) {
        // NSObject有obj_flag属性
        ((NSObject *)observer).obj_flag = OBJECTENUMFLAGNOTIFICATION;
    }
    [self mnz_addObserver:observer selector:aSelector name:aName object:anObject];
}

@end
