//
//  UIView+Crash.m
//  WQJTool
//
//  Created by Apple on 2018/5/7.
//  Copyright © 2018年 mnz. All rights reserved.
//

#import "UIView+Crash.h"
#import "NSObject+MNZ.h"

@implementation UIView (Crash)

+ (void)load {
    [self swizzleClassMethod:@selector(setNeedsLayout) andAnotherSelecor:@selector(mnz_setNeedsLayout)];
    [self swizzleClassMethod:@selector(setNeedsDisplay) andAnotherSelecor:@selector(mnz_setNeedsDisplay)];
    [self swizzleClassMethod:@selector(setNeedsDisplayInRect:) andAnotherSelecor:@selector(mnz_setNeedsDisplayInRect:)];
}

- (void)mnz_setNeedsLayout {
    dispatch_async(dispatch_get_main_queue(), ^{
        //调用原本方法
        [self mnz_setNeedsLayout];
    });
}

- (void)mnz_setNeedsDisplay {
    dispatch_async(dispatch_get_main_queue(), ^{
        //调用原本方法
        [self mnz_setNeedsDisplay];
    });
}

- (void)mnz_setNeedsDisplayInRect:(CGRect)rect {
    dispatch_async(dispatch_get_main_queue(), ^{
        //调用原本方法
        [self mnz_setNeedsDisplayInRect:rect];
    });
}

@end
