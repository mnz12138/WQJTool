//
//  NSObject+JSON.m
//  RACDemo
//
//  Created by Apple on 2018/4/8.
//  Copyright © 2018年 王全金. All rights reserved.
//

#import "NSObject+JSON.h"
#import <objc/runtime.h>

@implementation NSObject (JSON)

+ (void)swizzleMethod:(SEL)originalSelector andAnotherSelecor:(SEL)swizzledSelector {
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


+ (void)load {
    [self swizzleMethod:@selector(setValue:forKey:) andAnotherSelecor:@selector(mnz_setValue:forKey:)];
}

- (void)mnz_setValue:(id)value forKey:(NSString *)key {
    NSString *newKey = [[[self class] mnz_replacedKeyFromPropertyName] valueForKey:key];
    if (newKey!=nil) {
        key = newKey;
    }
    if ([value isKindOfClass:[NSDictionary class]]) {
        unsigned int count = 0;
        //获取属性列表
        Ivar *members = class_copyIvarList([self class], &count);
        //遍历属性列表
        for (int i = 0 ; i < count; i++) {
            Ivar var = members[i];
            //获取变量名称
            const char *memberName = ivar_getName(var);
            //获取变量类型
            const char *memberType = ivar_getTypeEncoding(var);
            //            NSLog(@"%s----%s", memberName, memberType);
            //            Ivar ivar = class_getInstanceVariable([self class], memberName);
            NSString *nameStr = [NSString stringWithCString:memberName encoding:NSUTF8StringEncoding];
            NSString *typeStr = [NSString stringWithCString:memberType encoding:NSUTF8StringEncoding];
            //判断类型
            if ([nameStr isEqualToString:key]||[nameStr isEqualToString:[NSString stringWithFormat:@"_%@",key]]||[nameStr isEqualToString:[key capitalizedString]]||[nameStr isEqualToString:[[NSString stringWithFormat:@"_%@",key] capitalizedString]]) {
                NSString *classStr = [[typeStr substringToIndex:typeStr.length-1] substringFromIndex:2];
                Class class = NSClassFromString(classStr);
                id object = [[class alloc] init];
                [object setValuesForKeysWithDictionary:value];
                //修改值
                //                object_setIvar(self, ivar, object);
                [self mnz_setValue:object forKey:key];
                break;
            }
        }
        free(members);
    }else if ([value isKindOfClass:[NSArray class]]) {
        NSDictionary *dict = [[self class] mnz_objectClassInArray];
        Class class = nil;
        if ([dict[key] isKindOfClass:[NSString class]]) {
            class = NSClassFromString(dict[key]);
        }else{
            class = dict[key];
        }
        if (class==nil) {
            return;
        }
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *memberDict in value) {
            id object = [[class alloc] init];
            [object setValuesForKeysWithDictionary:memberDict];
            [array addObject:object];
        }
        unsigned int count = 0;
        //获取属性列表
        Ivar *members = class_copyIvarList([self class], &count);
        //遍历属性列表
        for (int i = 0 ; i < count; i++) {
            Ivar var = members[i];
            //获取变量名称
            const char *memberName = ivar_getName(var);
            //获取变量类型
            //            const char *memberType = ivar_getTypeEncoding(var);
            //            NSLog(@"%s----%s", memberName, memberType);
            //            Ivar ivar = class_getInstanceVariable([self class], memberName);
            NSString *nameStr = [NSString stringWithCString:memberName encoding:NSUTF8StringEncoding];
            //判断类型
            if ([nameStr isEqualToString:key]||[nameStr isEqualToString:[NSString stringWithFormat:@"_%@",key]]||[nameStr isEqualToString:[key capitalizedString]]||[nameStr isEqualToString:[[NSString stringWithFormat:@"_%@",key] capitalizedString]]) {
                //修改值
                //                object_setIvar(self, ivar, array);
                [self mnz_setValue:array forKey:key];
                break;
            }
        }
        free(members);
    }else{
        [self mnz_setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (NSDictionary *)mnz_replacedKeyFromPropertyName {
    return @{};
}

+ (NSDictionary *)mnz_objectClassInArray {
    return @{};
}

@end
