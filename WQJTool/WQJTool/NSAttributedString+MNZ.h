//
//  NSAttributedString+MNZ.h
//  WQJTool
//
//  Created by 王全金 on 2017/11/21.
//  Copyright © 2017年 mnz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface NSAttributedString (MNZ)

+ (instancetype)setLineSpacing:(CGFloat)lineSpacing width:(CGFloat)width attrStr:(NSAttributedString *)attrStr testAttrStrBlock:(void(^)(NSMutableAttributedString *testAttrStr))testAttrStrBlock;

@end
