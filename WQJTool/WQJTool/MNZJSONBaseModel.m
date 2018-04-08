//
//  MNZJSONBaseModel.m
//
//  Created by Apple on 2018/4/8.
//  Copyright © 2018年 王全金. All rights reserved.
//

#import "MNZJSONBaseModel.h"
#import <objc/runtime.h>

@implementation MNZJSONBaseModel

- (void)setValue:(id)value forKey:(NSString *)key {
    NSString *newKey = [[self mnz_replacedKeyFromPropertyName] valueForKey:key];
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
                [super setValue:object forKey:key];
                break;
            }
        }
    }else if ([value isKindOfClass:[NSArray class]]) {
        NSDictionary *dict = [self mnz_objectClassInArray];
        Class class = nil;
        if ([dict[key] isKindOfClass:[NSString class]]) {
            class = NSClassFromString(dict[key]);
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
                [super setValue:array forKey:key];
                break;
            }
        }
    }else{
        [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (NSDictionary *)mnz_replacedKeyFromPropertyName {
    return @{};
}

- (NSDictionary *)mnz_objectClassInArray {
    return @{};
}

@end
