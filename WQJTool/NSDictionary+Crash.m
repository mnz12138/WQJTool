//
//  NSDictionary+Crash.m
//  WQJTool
//
//  Created by Apple on 2018/5/7.
//  Copyright © 2018年 mnz. All rights reserved.
//

#import "NSDictionary+Crash.h"
#import <objc/runtime.h>

@implementation NSDictionary (Crash)

+ (instancetype)dictionaryWithObjects:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt {
    NSMutableArray *validKeys = [NSMutableArray new];
    NSMutableArray *validObjs = [NSMutableArray new];
    for (NSUInteger i = 0; i < cnt; i ++) {
        if (objects[i] && keys[i]) {
            [validKeys addObject:keys[i]];
            [validObjs addObject:objects[i]];
        }
    }
    return [self dictionaryWithObjects:validObjs forKeys:validKeys];
}

@end
