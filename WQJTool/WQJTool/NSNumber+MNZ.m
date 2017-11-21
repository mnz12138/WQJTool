//
//  NSNumber+MNZ.m
//  WQJTool
//
//  Created by 王全金 on 2017/11/21.
//  Copyright © 2017年 mnz. All rights reserved.
//

#import "NSNumber+MNZ.h"

@implementation NSNumber (MNZ)

- (NSNumber* (^)(NSNumber *))add {
    return ^NSNumber *(NSNumber *number) {
        NSDecimalNumber *decimalValue = [NSDecimalNumber decimalNumberWithDecimal:[self decimalValue]];
        return [decimalValue decimalNumberByAdding:[NSDecimalNumber decimalNumberWithDecimal:number.decimalValue]];
    };
}
- (NSNumber* (^)(NSNumber *))subtract {
    return ^NSNumber *(NSNumber *number) {
        NSDecimalNumber *decimalValue = [NSDecimalNumber decimalNumberWithDecimal:[self decimalValue]];
        return [decimalValue decimalNumberBySubtracting:[NSDecimalNumber decimalNumberWithDecimal:number.decimalValue]];
    };
}
- (NSNumber* (^)(NSNumber *))multiplying {
    return ^NSNumber *(NSNumber *number) {
        NSDecimalNumber *decimalValue = [NSDecimalNumber decimalNumberWithDecimal:[self decimalValue]];
        return [decimalValue decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithDecimal:number.decimalValue]];
    };
}
- (NSNumber* (^)(NSNumber *))dividing {
    return ^NSNumber *(NSNumber *number) {
        NSDecimalNumber *decimalValue = [NSDecimalNumber decimalNumberWithDecimal:[self decimalValue]];
        return [decimalValue decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithDecimal:number.decimalValue]];
    };
}

@end
