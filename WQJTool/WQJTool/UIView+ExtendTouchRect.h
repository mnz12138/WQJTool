//
//  UIView+ExtendTouchRect.h
//  CategoryTest
//
//  Created by 王全金 on 2017/12/7.
//  Copyright © 2017年 王全金. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 For example:
 button.touchExtendInset = UIEdgeInsetsMake(-10, -10, -10, -10);
 */

@interface UIView (ExtendTouchRect)

/*增加响应区域*/
@property(nonatomic, assign) UIEdgeInsets touchExtendInset;

@end
