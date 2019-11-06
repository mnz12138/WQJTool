//
//  NSTimer+MNZ.h
//  WQJTool
//
//  Created by 王全金 on 2017/12/21.
//  Copyright © 2017年 mnz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (MNZ)

/**timer的block*/
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)repeats;
/**timer的block*/
+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)repeats;

@end
