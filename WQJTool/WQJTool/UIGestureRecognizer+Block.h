//
//  UIGestureRecognizer+Block.h
//  CategoryTest
//
//  Created by 王全金 on 2017/12/7.
//  Copyright © 2017年 王全金. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GestureBlock)(id gestureRecognizer);

/*
 For example:
 [view addGestureRecognizer:[UITapGestureRecognizer gestureRecognizerWithActionBlock:^(id gestureRecognizer) {
    //...
 }]];
 */

@interface UIGestureRecognizer (Block)

+ (instancetype)gestureRecognizerWithActionBlock:(GestureBlock)block;
- (instancetype)initWithActionBlock:(GestureBlock)block;

@end
