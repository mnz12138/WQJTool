//
//  UITapGestureRecognizer+Action.h
//  WQJTool
//
//  Created by Apple on 2018/6/15.
//  Copyright © 2018年 mnz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITapGestureRecognizer (Action)

- (instancetype)initWithTarget:(id)target action:(SEL)action withDuration:(NSTimeInterval)duration;
- (void)addTarget:(id)target action:(SEL)action withDuration:(NSTimeInterval)duration;

@end
