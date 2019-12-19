//
//  UINavigationController+MNZ.h
//  WQJTool
//
//  Created by Apple on 2018/5/30.
//  Copyright © 2018年 mnz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (MNZ) <UIGestureRecognizerDelegate>

/// 设全屏右滑返回手势,关闭系统返回手势
- (void)setupFullScreenPopGesture;

@end
