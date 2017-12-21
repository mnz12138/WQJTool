//
//  UIAlertView+MNZ.m
//  WQJTool
//
//  Created by 王全金 on 2017/12/21.
//  Copyright © 2017年 mnz. All rights reserved.
//

#import "UIAlertView+MNZ.h"
#import <objc/runtime.h>

static const int handler_key;
@implementation UIAlertView (MNZ)

- (void)showWithHandler:(CompletionHandler)handler {
    if (handler) {
        objc_setAssociatedObject(self, &handler_key, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
        self.delegate = self;
    }
    [self show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    CompletionHandler handler = objc_getAssociatedObject(self, &handler_key);
    objc_removeAssociatedObjects(self);
    if (handler) {
        handler(alertView, buttonIndex);
    }
}

@end
