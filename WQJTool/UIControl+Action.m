//
//  UIControl+Action.m
//  WQJTool
//
//  Created by Apple on 2018/6/15.
//  Copyright © 2018年 mnz. All rights reserved.
//

#import "UIControl+Action.h"
#import "NSObject+MNZ.h"
#import <objc/runtime.h>

@implementation UIControl (Action)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleMethod:@selector(sendAction:to:forEvent:) andAnotherSelecor:@selector(mnz_sendAction:to:forEvent:)];
    });
}

#pragma mark 时间间隔
static const void *ButtonDurationTime = @"ButtonDurationTime";
- (void)setDurationTime:(NSTimeInterval)durationTime {
    NSNumber *number = [NSNumber numberWithDouble:durationTime];
    objc_setAssociatedObject(self, ButtonDurationTime, number, OBJC_ASSOCIATION_ASSIGN);
}

- (NSTimeInterval)durationTime {
    NSNumber *number = objc_getAssociatedObject(self, ButtonDurationTime);
    return number.doubleValue;
}

- (void)mnz_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    self.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.durationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.userInteractionEnabled = YES;
    });
    [self mnz_sendAction:action to:target forEvent:event];
}

@end
