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

@interface Object_KVO_Info: NSObject

@property (nonatomic, weak) NSObject *observer;

@end

@interface NSObject ()

@property (nonatomic, strong) NSObject *kvoInfo;

@end

static const char kvo_key;
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
//    [self swizzleMethod:@selector(forwardingTargetForSelector:) andAnotherSelecor:@selector(mnz_forwardingTargetForSelector:)];
    [self swizzleMethod:NSSelectorFromString(@"dealloc") andAnotherSelecor:@selector(mnz_dealloc)];
    
//    [self swizzleMethod:@selector(addObserver:forKeyPath:options:context:) andAnotherSelecor:@selector(mnz_addObserver:forKeyPath:options:context:)];
//    [self swizzleMethod:@selector(removeObserver:forKeyPath:) andAnotherSelecor:@selector(mnz_removeObserver:forKeyPath:)];
}
//Unrecognized Selector类型crash防护，可以记录日志，便于修改bug
//- (id)mnz_forwardingTargetForSelector:(SEL)aSelector {
//    static NSUInteger index = 0;
//    static NSMutableDictionary *classDict = nil;
//    if (classDict==nil) {
//        classDict = [[NSMutableDictionary alloc] init];
//    }
//    NSString *Class_Name = [NSString stringWithFormat:@"NSObject_Crash_Proxy_%ld",index];;
//    const char *NSObject_Crash_Proxy_Name = [Class_Name UTF8String];
//    Class MyClass = [classDict valueForKey:NSStringFromSelector(aSelector)];
//    if (MyClass==nil) {
//        MyClass = objc_getClass(NSObject_Crash_Proxy_Name);
//    }
//    if (MyClass==nil) {
//        MyClass = objc_allocateClassPair([NSObject class], NSObject_Crash_Proxy_Name, 0);
//        //    BOOL isSuccess = class_addIvar(MyClass, "test", sizeof(NSString *), 0, "@");
//        // 三目运算符
//        //    isSuccess?NSLog(@"添加变量成功"):NSLog(@"添加变量失败");
//        class_addMethod(MyClass, aSelector, (IMP)addMethodForMyClass, "V@:");
//        objc_registerClassPair(MyClass);
//        index++;
//        [classDict setObject:MyClass forKey:NSStringFromSelector(aSelector)];
//    }
//    id myObjc = [[MyClass alloc] init];
//    if ([myObjc respondsToSelector:aSelector]) {
//        return myObjc;
//    }
//    static id myObjc = nil;
//    if (myObjc==nil) {
//        myObjc = [[NSObject alloc] init];
//    }
//    if ([myObjc respondsToSelector:aSelector]) {
//        return myObjc;
//    }else if (class_addMethod([myObjc class], aSelector, (IMP)addMethodForMyClass, "v@:")) {
//        return myObjc;
//    }
//    return [self mnz_forwardingTargetForSelector:aSelector];
//}

- (void)mnz_dealloc {
    //在iOS9之后，即使开发者没有移除observer，Notification crash也不会再产生了。
    if ([self obj_flag]==OBJECTENUMFLAGNOTIFICATION) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    [self mnz_dealloc];
}

//KVO防护
- (void)mnz_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    Object_KVO_Info *kvoInfo = [[Object_KVO_Info alloc] init];
    kvoInfo.observer = observer;
    self.kvoInfo = kvoInfo;
    [self addObserver:kvoInfo forKeyPath:keyPath options:options context:context];
//    [self mnz_addObserver:kvoInfo forKeyPath:keyPath options:options context:context];
}

- (void)mnz_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    //防止多次移除出现奔溃
    @try {
//        [self mnz_removeObserver:observer forKeyPath:keyPath];
        [self removeObserver:observer forKeyPath:keyPath];
    } @catch (NSException *exception) {}
}

- (NSObject *)kvoInfo {
    return objc_getAssociatedObject(self, &kvo_key);
}

- (void)setKvoInfo:(NSObject *)kvoInfo {
    objc_setAssociatedObject(self, &kvo_key, kvoInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


@implementation Object_KVO_Info

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (self.observer!=nil) {
        [self.observer observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }else{
        [object removeObserver:self forKeyPath:keyPath];
    }
}

@end
