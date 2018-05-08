//
//  NSTimer+Crash.h
//  WQJTool
//
//  Created by Apple on 2018/5/7.
//  Copyright © 2018年 mnz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Crash)

@end


@interface NSTimer_Crash_StubTarget: NSObject

- (void)fireProxyTimer:(NSTimer *)timer;

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, strong) id userInfo;

@end
