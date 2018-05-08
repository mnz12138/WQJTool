//
//  UIResponder+Action.m
//  简化代码
//
//  Created by 王全金 on 2017/12/20.
//  Copyright © 2017年 王全金. All rights reserved.
//

#import "UIResponder+Action.h"
#import <objc/runtime.h>

static const char delegate_key;
@implementation UIResponder (Action)

- (void)setDelegate:(id<MNZActionProtocol>)delegate {
    objc_setAssociatedObject(self, &delegate_key, delegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id<MNZActionProtocol>)delegate {
    return objc_getAssociatedObject(self, &delegate_key);
}

- (void)actionName:(NSString *)name sender:(id)sender object:(id)object {
    
}

- (void)callActionName:(NSString *)name sender:(id)sender object:(id)object {
    if ([self.delegate respondsToSelector:@selector(actionName:sender:object:)]) {
        [self.delegate actionName:name sender:sender object:object];
    }
}

- (void)callEventName:(NSString *)eventName sender:(id)sender object:(id)object {
    [[self nextResponder] callEventName:eventName sender:sender object:object];
}

@end
