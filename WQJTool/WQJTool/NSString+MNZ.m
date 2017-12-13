//
//  NSString+MNZ.m
//  WQJTool
//
//  Created by 王全金 on 2017/11/21.
//  Copyright © 2017年 mnz. All rights reserved.
//

#import "NSString+MNZ.h"

@implementation NSString (MNZ)

+ (instancetype)formatNumber:(NSNumber *)number {
    return [self formatNumber:number decimalCount:2];
}

+ (NSString *)formatNumber:(NSNumber *)number decimalCount:(NSInteger)decimalCount{
    double fdouble = [number doubleValue];
    NSString *ftotal;
    switch (decimalCount) {
        case 1:
            ftotal = [NSString stringWithFormat:@"%.1f", fdouble];
            break;
        case 2:
            ftotal = [NSString stringWithFormat:@"%.2f", fdouble];
            break;
        case 3:
            ftotal = [NSString stringWithFormat:@"%.3f", fdouble];
            break;
        case 4:
            ftotal = [NSString stringWithFormat:@"%.4f", fdouble];
            break;
        case 5:
            ftotal = [NSString stringWithFormat:@"%.5f", fdouble];
            break;
        default:
            break;
    }
    while ([ftotal hasSuffix:@"0"]) {
        ftotal = [ftotal substringToIndex:[ftotal length]-1];
    }
    
    if ([ftotal hasSuffix:@"."]) {
        ftotal = [ftotal substringToIndex:[ftotal length]-1];
    }
    return ftotal;
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
