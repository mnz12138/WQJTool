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

/**根据带参url分离url和参数 eg:https://www.baidu.com?a=1&b=2 返回 [@"https://www.baidu.com",@{@"a":@"1",@"b":@"2"}]*/
+ (NSArray*)getParamsWithUrlString:(NSString*)urlString;
/**四舍五入,保留两位小数*/
+ (instancetype)formatNumber:(NSNumber *)number;
/**四舍五入,保留decimalCount位小数*/
+ (NSString *)formatNumber:(NSNumber *)number decimalCount:(NSInteger)decimalCount;
/**判断字符串是否为空(各种空)*/
+ (BOOL)isEmptyString:(NSString*)string;
/**获取LaunchImage中图片的名字*/
+ (NSString *)getLaunchImageName;


@end
