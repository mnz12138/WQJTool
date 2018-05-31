//
//  UIViewController+MNZ.m
//  简化代码
//
//  Created by 王全金 on 2017/12/20.
//  Copyright © 2017年 王全金. All rights reserved.
//

#import "UIViewController+MNZ.h"

@implementation UIViewController (MNZ)

+ (instancetype)getLastActivityController {
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self getTopViewControllerWithVc:vc];
}

+ (instancetype)getTopViewControllerWithVc:(UIViewController *)vc {
    BOOL isTabBarController = [vc isKindOfClass:[UITabBarController class]];
    BOOL isNavigationController = [vc isKindOfClass:[UINavigationController class]];
    while (isTabBarController||isNavigationController) {
        if (isTabBarController) {
            vc = ((UITabBarController *)vc).selectedViewController;
        }
        isNavigationController = [vc isKindOfClass:[UINavigationController class]];
        if (isNavigationController) {
            vc = ((UINavigationController *)vc).visibleViewController;
        }
        isTabBarController = [vc isKindOfClass:[UITabBarController class]];
        isNavigationController = [vc isKindOfClass:[UINavigationController class]];
    }
    return [vc presentedViewController] ? [self getTopViewControllerWithVc:vc.presentedViewController]: vc;
}

@end
