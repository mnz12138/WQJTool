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

/**
 设置行间距

 @param lineSpacing 行间距
 @param width label的宽度
 @param attrStr label的属性文本
 @param testAttrStrBlock 测试多行的block回调，在回调中设置testAttrStr
 @return 返回设置好行间距的属性文本
 */
+ (instancetype)setLineSpacing:(CGFloat)lineSpacing width:(CGFloat)width attrStr:(NSAttributedString *)attrStr testAttrStrBlock:(void(^)(NSMutableAttributedString *testAttrStr))testAttrStrBlock;

@end
