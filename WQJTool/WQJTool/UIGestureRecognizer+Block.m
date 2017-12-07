//
//  UIGestureRecognizer+Block.m
//  CategoryTest
//
//  Created by 王全金 on 2017/12/7.
//  Copyright © 2017年 王全金. All rights reserved.
//

#import "UIGestureRecognizer+Block.h"
#import <objc/message.h>

static const int target_key;
@implementation UIGestureRecognizer (Block)

+ (instancetype)gestureRecognizerWithActionBlock:(GestureBlock)block {
    return [[self alloc] initWithActionBlock:block];
}

- (instancetype)initWithActionBlock:(GestureBlock)block {
    self = [self init];
    if (self) {
        [self addActionBlock:block];
        [self addTarget:self action:@selector(invoke:)];
    }
    return self;
}

- (void)addActionBlock:(GestureBlock)block {
    if (block) {
        objc_setAssociatedObject(self, &target_key, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

- (void)invoke:(id)sender {
    GestureBlock block = objc_getAssociatedObject(self, &target_key);
    if (block) {
        block(sender);
    }
}

@end
