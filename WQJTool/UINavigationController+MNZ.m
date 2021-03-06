//
//  UINavigationController+MNZ.m
//  WQJTool
//
//  Created by Apple on 2018/5/30.
//  Copyright © 2018年 mnz. All rights reserved.
//

#import "UINavigationController+MNZ.h"
#import "NSObject+MNZ.h"

@implementation UINavigationController (MNZ)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleMethod:@selector(preferredStatusBarStyle) andAnotherSelecor:@selector(mnz_preferredStatusBarStyle)];
        [self swizzleMethod:@selector(pushViewController:animated:) andAnotherSelecor:@selector(mnz_pushViewController:animated:)];
    });
}

- (UIStatusBarStyle)mnz_preferredStatusBarStyle {
    UIStatusBarStyle style = self.visibleViewController.preferredStatusBarStyle;
    return style;
}

- (void)mnz_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [self mnz_pushViewController:viewController animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setupFullScreenPopGesture {
    //设全屏启动右滑返回手势，此处可以优化为iPad 上支持全屏
    id target = self.interactivePopGestureRecognizer.delegate;
    SEL handler = NSSelectorFromString(@"handleNavigationTransition:");
    // 获取添加系统边缘触发手势的View
    UIView *targetView = self.interactivePopGestureRecognizer.view;
    // 创建pan手势 作用范围是全屏
    UIPanGestureRecognizer *fullScreenGes = [[UIPanGestureRecognizer alloc]initWithTarget:target action:handler];
    fullScreenGes.delegate = self;
    [targetView addGestureRecognizer:fullScreenGes];
    // 关闭边缘触发手势 防止和原有边缘手势冲突（也可不用关闭）
    [self.interactivePopGestureRecognizer setEnabled:NO];
    //设置右滑返回手势的代理为自身
    __weak typeof(self) weakself = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = (id)weakself;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count<=1) {
        return NO;
    }
    return YES;
}

@end
