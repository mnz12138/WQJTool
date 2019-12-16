//
//  NSObject+Crash.h
//  WQJTool
//
//  Created by Apple on 2018/5/7.
//  Copyright © 2018年 mnz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Crash)

- (void)mnz_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;
- (void)mnz_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;

@end
