//
//  NSObject+MNZ.m
//  WQJTool
//
//  Created by 王全金 on 2017/11/21.
//  Copyright © 2017年 mnz. All rights reserved.
//

#import "NSObject+MNZ.h"
#import "NSString+MNZ.h"
#import <objc/runtime.h>

@implementation NSObject (MNZ)

+ (void)swizzleMethod:(SEL)originalSelector andAnotherSelecor:(SEL)swizzledSelector {
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (BOOL)isEmptyObject:(id)object {
    if (object==nil) {
        return YES;
    }
    if ([object respondsToSelector:@selector(class)]&&[object isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([object respondsToSelector:@selector(class)]&&[[object class] isKindOfClass:[NSString class]]) {
        return [NSString isEmptyString:(NSString *)object];
    }
    return NO;
}

@end
