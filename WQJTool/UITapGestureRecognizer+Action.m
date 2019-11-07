//
//  UITapGestureRecognizer+Action.m
//  WQJTool
//
//  Created by Apple on 2018/6/15.
//  Copyright © 2018年 mnz. All rights reserved.
//

#import "UITapGestureRecognizer+Action.h"
#import <objc/runtime.h>

@interface UITapGestureRecognizer () <UIGestureRecognizerDelegate>

/**点击时间间隔-控制连续点击**/
@property (nonatomic, assign) NSTimeInterval duration;

@end

@implementation UITapGestureRecognizer (Action)

- (instancetype)initWithTarget:(id)target action:(SEL)action withDuration:(NSTimeInterval)duration {
    self = [super init];
    if (self) {
        [self addTarget:target action:action withDuration:duration];
    }
    return self;
}

- (void)addTarget:(id)target action:(SEL)action withDuration:(NSTimeInterval)duration {
    self.duration = duration;
    self.delegate = self;
    [super addTarget:target action:action];
}

#pragma mark 时间间隔
static const void *UITapGestureRecognizerduration = @"UITapGestureRecognizerduration";
- (void)setDuration:(NSTimeInterval)duration {
    NSNumber *number = [NSNumber numberWithDouble:duration];
    objc_setAssociatedObject(self, UITapGestureRecognizerduration, number, OBJC_ASSOCIATION_ASSIGN);
}

- (NSTimeInterval)duration {
    NSNumber *number = objc_getAssociatedObject(self, UITapGestureRecognizerduration);
    return number.doubleValue;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    self.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.enabled = YES;
    });
    return YES;
}

@end
