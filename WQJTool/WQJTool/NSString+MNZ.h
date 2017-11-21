//
//  NSString+MNZ.h
//  WQJTool
//
//  Created by 王全金 on 2017/11/21.
//  Copyright © 2017年 mnz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface NSString (MNZ)

/*四舍五入,保留两位小数*/
+ (instancetype)formatFloat:(CGFloat)f;
+ (BOOL)isEmptyString:(NSString*)string;

@end
