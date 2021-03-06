//
//  NSTimer+Crash.m
//  WQJTool
//
//  Created by Apple on 2018/5/7.
//  Copyright © 2018年 mnz. All rights reserved.
//

#import "NSTimer+Crash.h"
#import "NSObject+MNZ.h"
#import <objc/message.h>
#import "MNZWeakProxy.h"

//@interface Timer_Crash_StubTarget: NSObject
//
//- (void)fireProxyTimer:(NSTimer *)timer;
//
//@property (nonatomic, weak) id target;
//@property (nonatomic, assign) SEL selector;
//@property (nonatomic, weak) NSTimer *timer;
//@property (nonatomic, strong) id userInfo;
//
//@end

@implementation NSTimer (Crash)

+ (instancetype)scheduledProxyTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo {
    return [NSTimer scheduledTimerWithTimeInterval:ti target:[MNZWeakProxy proxyWithTarget:aTarget] selector:aSelector userInfo:userInfo repeats:yesOrNo];
}

//+ (void)load {
//    [self swizzleClassMethod:@selector(scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:) andAnotherSelecor:@selector(mnz_scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:)];
//}
//
//+ (NSTimer *)mnz_scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo {
//    if (yesOrNo) {
//        Timer_Crash_StubTarget *stubTarget = [[Timer_Crash_StubTarget alloc] init];
//        stubTarget.target = aTarget;
//        stubTarget.selector = aSelector;
//        stubTarget.userInfo = userInfo;
//        NSTimer *newTimer = [NSTimer mnz_scheduledTimerWithTimeInterval:ti target:stubTarget selector:@selector(fireProxyTimer:) userInfo:userInfo repeats:yesOrNo];
//        return newTimer;
//    }else{
//        return [NSTimer mnz_scheduledTimerWithTimeInterval:ti target:aTarget selector:aSelector userInfo:userInfo repeats:yesOrNo];
//    }
//}

@end


//@implementation Timer_Crash_StubTarget
//
//- (void)fireProxyTimer:(NSTimer *)timer {
//    if (self.target==nil) {
//        [timer invalidate];
//        timer = nil;
//    }else{
//        if ([self.target respondsToSelector:self.selector]) {
//            [self.target performSelector:self.selector withObject:timer];
//        }
//    }
//}
//
//@end
