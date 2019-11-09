//
//  MNZWeakProxy.h
//  WQJTool
//
//  Created by wangquanjin on 2019/11/9.
//  Copyright © 2019 mnz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MNZWeakProxy : NSProxy

@property (weak, nonatomic, readonly) id target;
+ (instancetype)proxyWithTarget:(id)target;
- (instancetype)initWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
