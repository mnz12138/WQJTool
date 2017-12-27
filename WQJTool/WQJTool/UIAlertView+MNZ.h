//
//  UIAlertView+MNZ.h
//  WQJTool
//
//  Created by 王全金 on 2017/12/21.
//  Copyright © 2017年 mnz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompletionHandler)(UIAlertView *alert, NSUInteger buttonIndex);
@interface UIAlertView (MNZ) <UIAlertViewDelegate>

/**显示UIAlertView*/
- (void)showWithHandler:(CompletionHandler)handler;

@end
