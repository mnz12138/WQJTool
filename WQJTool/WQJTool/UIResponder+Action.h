//
//  UIResponder+Action.h
//  简化代码
//
//  Created by 王全金 on 2017/12/20.
//  Copyright © 2017年 王全金. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MNZActionProtocol <NSObject>
- (void)actionName:(NSString *)name sender:(id)sender object:(id)object;
@end

@interface UIResponder (Action) <MNZActionProtocol>
@property (nonatomic, weak) id<MNZActionProtocol> delegate;
/**通知代理响应*/
- (void)callActionName:(NSString *)name sender:(id)sender object:(id)object;
/**沿着响应链传递*/
- (void)callEventName:(NSString *)eventName sender:(id)sender object:(id)object;
@end
