//
//  MNZWeakProxy.m
//  WQJTool
//
//  Created by wangquanjin on 2019/11/9.
//  Copyright © 2019 mnz. All rights reserved.
//

#import "MNZWeakProxy.h"

@implementation MNZWeakProxy

- (instancetype)initWithTarget:(id)target{
    _target = target;
    return self;
}
+ (instancetype)proxyWithTarget:(id)target{
    return [[self alloc] initWithTarget:target];
}
- (void)forwardInvocation:(NSInvocation *)invocation {
    SEL sel = [invocation selector];
    if ([self.target respondsToSelector:sel]) {
        [invocation invokeWithTarget:self.target];
    }
}
//消息转发
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

//1.使用NSProxy
//2.重写如下的2个方法(消息转发里面的完整消息转发)：
//methodSignatureForSelector:
//forwardInvocation:
//或者重写这个方法
//(id)forwardingTargetForSelector:(SEL)selector

////备用接收者
//- (id)forwardingTargetForSelector:(SEL)selector {
//    return _target;
//}

@end
