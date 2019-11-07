//
//  NSAttributedString+MNZ.m
//  WQJTool
//
//  Created by 王全金 on 2017/11/21.
//  Copyright © 2017年 mnz. All rights reserved.
//

#import "NSAttributedString+MNZ.h"

@implementation NSAttributedString (MNZ)

+ (instancetype)setLineSpacing:(CGFloat)lineSpacing width:(CGFloat)width attrStr:(NSAttributedString *)attrStr testAttrStrBlock:(void (^)(NSMutableAttributedString *))testAttrStrBlock {
    if (lineSpacing<0||attrStr==nil) {
        return attrStr;
    }
    NSMutableAttributedString *mAttrStr = [[NSMutableAttributedString alloc] initWithAttributedString:attrStr];
    NSMutableAttributedString *testAttrStr = [[NSMutableAttributedString alloc] init];
    if (testAttrStrBlock) {
        testAttrStrBlock(testAttrStr);
    }
    CGFloat oneHeight = [testAttrStr boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    CGFloat rowHeight = [mAttrStr boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    // 如果超出一行，则offset=0;
    if(rowHeight > oneHeight){
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = lineSpacing;
        [mAttrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, mAttrStr.length)];
    }
    return [mAttrStr copy];
}

@end
