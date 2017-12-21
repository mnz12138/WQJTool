//
//  NSTimer+MNZ.m
//  WQJTool
//
//  Created by 王全金 on 2017/12/21.
//  Copyright © 2017年 mnz. All rights reserved.
//

#import "NSTimer+MNZ.h"

@implementation NSTimer (MNZ)

+ (void)mnz_execBlock:(NSTimer *)timer {
    if (timer.userInfo) {
        void (^block)(NSTimer *timer) = (void (^)(NSTimer *timer))[timer userInfo];
        block(timer);
    }
}

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)repeats {
    return [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(mnz_execBlock:) userInfo:block repeats:repeats];
}
+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)repeats {
    return [NSTimer timerWithTimeInterval:seconds target:self selector:@selector(mnz_execBlock:) userInfo:block repeats:repeats];
}

@end
