//
//  NSNumber+MNZ.h
//  WQJTool
//
//  Created by 王全金 on 2017/11/21.
//  Copyright © 2017年 mnz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (MNZ)

/**加*/
- (NSNumber* (^)(NSNumber *))add;
/**减*/
- (NSNumber* (^)(NSNumber *))subtract;
/**乘*/
- (NSNumber* (^)(NSNumber *))multiplying;
/**除*/
- (NSNumber* (^)(NSNumber *))dividing;

@end
