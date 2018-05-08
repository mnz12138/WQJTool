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

static const char flag_key;
@implementation NSObject (MNZ)

+ (void)swizzleMethod:(SEL)originalSelector andAnotherSelecor:(SEL)swizzledSelector {
    Class myClass = [self class];
    [self swizzleClass:myClass originalMethod:originalSelector andAnotherSelecor:swizzledSelector];
}

+ (void)swizzleClassMethod:(SEL)originalSelector andAnotherSelecor:(SEL)swizzledSelector {
//    操作类方法，就是把 class 参数变成这个类的 Meta-Class
    Class myClass = object_getClass([self class]);
    [self swizzleClass:myClass originalMethod:originalSelector andAnotherSelecor:swizzledSelector];
}

+ (void)swizzleClass:(Class)myClass originalMethod:(SEL)originalSelector andAnotherSelecor:(SEL)swizzledSelector {
    Method originalMethod = class_getInstanceMethod(myClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(myClass, swizzledSelector);
    BOOL success = class_addMethod(myClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(myClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
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

- (void)setObj_flag:(NSUInteger)obj_flag {
    objc_setAssociatedObject(self, &flag_key, @(obj_flag), OBJC_ASSOCIATION_ASSIGN);
}

- (NSUInteger)obj_flag {
    return [objc_getAssociatedObject(self, &flag_key) unsignedIntegerValue];
}

@end
