//
//  NSString+MNZ.m
//  WQJTool
//
//  Created by 王全金 on 2017/11/21.
//  Copyright © 2017年 mnz. All rights reserved.
//

#import "NSString+MNZ.h"

@implementation NSString (MNZ)

+ (instancetype)formatFloat:(CGFloat)f {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.maximumFractionDigits = 2;
    formatter.minimumIntegerDigits = 1;
    return [formatter stringFromNumber:@(f)];
}

+ (BOOL)isEmptyString:(NSString*)string {
    if ( string == nil || string == (NSString *)[NSNull null] ||(![string respondsToSelector:@selector(isEqualToString:)]) || [string isEqualToString:@"(null)"] || [string isEqualToString:@"<null>"]){
        return YES;
    }else if ((![string respondsToSelector:@selector(stringByTrimmingCharactersInSet:)]) || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0){
        return YES;
    }
    return NO;
}

@end
