//
//  NSString+MNZ.m
//  WQJTool
//
//  Created by 王全金 on 2017/11/21.
//  Copyright © 2017年 mnz. All rights reserved.
//

#import "NSString+MNZ.h"
#import <UIKit/UIKit.h>

@implementation NSString (MNZ)

//根据url取后面的参数
+ (NSArray*)getParamsWithUrlString:(NSString*)urlString {
    if(urlString.length==0) {
        NSLog(@"链接为空！");
        return @[@"",@{}];
    }
    //先截取问号
    NSArray*allElements = [urlString componentsSeparatedByString:@"?"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];//待set的参数字典
    if(allElements.count==2) {
        //有参数或者?后面为空
        NSString*myUrlString = allElements[0];
        NSString*paramsString = allElements[1];
        //获取参数对
        NSArray*paramsArray = [paramsString componentsSeparatedByString:@"&"];
        if(paramsArray.count>=2) {
            for(NSInteger i =0; i < paramsArray.count; i++) {
                NSString*singleParamString = paramsArray[i];
                NSArray*singleParamSet = [singleParamString componentsSeparatedByString:@"="];
                if(singleParamSet.count==2) {
                    NSString*key = singleParamSet[0];
                    NSString*value = singleParamSet[1];
                    if(key.length>0|| value.length>0) {
                        [params setObject:value.length>0?value:@""forKey:key.length>0?key:@""];
                    }
                }
            }
        }else if(paramsArray.count==1) {
            //无 &。url只有?后一个参数
            NSString*singleParamString = paramsArray[0];
            NSArray*singleParamSet = [singleParamString componentsSeparatedByString:@"="];
            if(singleParamSet.count==2) {
                NSString*key = singleParamSet[0];
                NSString*value = singleParamSet[1];
                if(key.length>0|| value.length>0) {
                    [params setObject:value.length>0?value:@""forKey:key.length>0?key:@""];
                }
            }else{
                //问号后面啥也没有 xxxx?  无需处理
            }
        }
        //整合url及参数
        return@[myUrlString,params];
    }else if(allElements.count>2) {
        NSLog(@"链接不合法！链接包含多个\"?\"");
        return @[@"",@{}];
    }else{
        NSLog(@"链接不包含参数！");
        return@[urlString,@{}];
    }
}

+ (instancetype)formatNumber:(NSNumber *)number {
    return [self formatNumber:number decimalCount:2];
}

+ (NSString *)formatNumber:(NSNumber *)number decimalCount:(NSInteger)decimalCount{
    double fdouble = [number doubleValue];
    NSString *ftotal;
    switch (decimalCount) {
        case 1:
            ftotal = [NSString stringWithFormat:@"%.1f", fdouble];
            break;
        case 2:
            ftotal = [NSString stringWithFormat:@"%.2f", fdouble];
            break;
        case 3:
            ftotal = [NSString stringWithFormat:@"%.3f", fdouble];
            break;
        case 4:
            ftotal = [NSString stringWithFormat:@"%.4f", fdouble];
            break;
        case 5:
            ftotal = [NSString stringWithFormat:@"%.5f", fdouble];
            break;
        case 6:
            ftotal = [NSString stringWithFormat:@"%.6f", fdouble];
            break;
        default:
            break;
    }
    while ([ftotal hasSuffix:@"0"]) {
        ftotal = [ftotal substringToIndex:[ftotal length]-1];
    }
    
    if ([ftotal hasSuffix:@"."]) {
        ftotal = [ftotal substringToIndex:[ftotal length]-1];
    }
    return ftotal;
}

+ (BOOL)isEmptyString:(NSString*)string {
    if ( string == nil || string == (NSString *)[NSNull null] ||(![string respondsToSelector:@selector(isEqualToString:)]) || [string isEqualToString:@"(null)"] || [string isEqualToString:@"<null>"]){
        return YES;
    }else if ((![string respondsToSelector:@selector(stringByTrimmingCharactersInSet:)]) || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0){
        return YES;
    }
    return NO;
}

+ (NSString *)getLaunchImageName {
    CGSize viewSize = [[UIScreen mainScreen] bounds].size;
    NSString *viewOrientation = @"Portrait";//横屏请设置成 @"Landscape"
    NSString *launchImage = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            launchImage = dict[@"UILaunchImageName"];
        }
    }
    return launchImage;
}

@end
