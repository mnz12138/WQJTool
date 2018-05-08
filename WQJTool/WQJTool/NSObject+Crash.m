//
//  NSObject+Crash.m
//  WQJTool
//
//  Created by Apple on 2018/5/7.
//  Copyright © 2018年 mnz. All rights reserved.
//

#import "NSObject+Crash.h"
#import "NSObject+MNZ.h"
#import <objc/runtime.h>

@implementation NSObject (Crash)

static void addMethodForMyClass(id self, SEL _cmd) {
    // 获取类中指定名称实例成员变量的信息
//    Ivar ivar = class_getInstanceVariable([self class], "");
    // 获取整个成员变量列表
    //   Ivar * class_copyIvarList ( Class cls, unsigned intint * outCount );
    // 获取类中指定名称实例成员变量的信息
    //   Ivar class_getInstanceVariable ( Class cls, const charchar *name );
    // 获取类成员变量的信息
    //   Ivar class_getClassVariable ( Class cls, const charchar *name );
    
    // 返回名为test的ivar变量的值
//    id obj = object_getIvar(self, ivar);
//    NSLog(@"%@",obj);
//    NSLog(@"addMethodForMyClass:参数：%@",test);
//    NSLog(@"ClassName：%@",NSStringFromClass([self class]));
}

//这个方法实际上没有被调用,但是必须实现否则不会调用addMethodForMyClass()方法
- (void)addMethodForMyClass:(NSObject *)firstObj, ... {
    
}

+ (void)load {
    [self swizzleMethod:@selector(forwardingTargetForSelector:) andAnotherSelecor:@selector(mnz_forwardingTargetForSelector:)];
    [self swizzleMethod:NSSelectorFromString(@"dealloc") andAnotherSelecor:@selector(mnz_dealloc)];
}
//Unrecognized Selector类型crash防护，可以记录日志，便于修改bug
- (id)mnz_forwardingTargetForSelector:(SEL)aSelector {
    static NSUInteger index = 0;
    static NSMutableDictionary *classDict = nil;
    if (classDict==nil) {
        classDict = [[NSMutableDictionary alloc] init];
    }
    NSString *Class_Name = [NSString stringWithFormat:@"NSObject_Crash_Proxy_%ld",index];;
    const char *NSObject_Crash_Proxy_Name = [Class_Name UTF8String];
    Class MyClass = [classDict valueForKey:NSStringFromSelector(aSelector)];
    if (MyClass==nil) {
        MyClass = objc_getClass(NSObject_Crash_Proxy_Name);
    }
    if (MyClass==nil) {
        MyClass = objc_allocateClassPair([NSObject class], NSObject_Crash_Proxy_Name, 0);
        //    BOOL isSuccess = class_addIvar(MyClass, "test", sizeof(NSString *), 0, "@");
        // 三目运算符
        //    isSuccess?NSLog(@"添加变量成功"):NSLog(@"添加变量失败");
        class_addMethod(MyClass, aSelector, (IMP)addMethodForMyClass, "V@:");
        objc_registerClassPair(MyClass);
        index++;
        [classDict setObject:MyClass forKey:NSStringFromSelector(aSelector)];
    }
    id myObjc = [[MyClass alloc] init];
    if ([myObjc respondsToSelector:aSelector]) {
        return myObjc;
    }
    return [self mnz_forwardingTargetForSelector:aSelector];
}

- (void)mnz_dealloc {
    //在iOS9之后，即使开发者没有移除observer，Notification crash也不会再产生了。
    if ([self obj_flag]==OBJECTENUMFLAGNOTIFICATION) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    [self mnz_dealloc];
}

@end
