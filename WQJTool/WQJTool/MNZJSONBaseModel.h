//
//  MNZJSONBaseModel.h
//
//  Created by Apple on 2018/4/8.
//  Copyright © 2018年 王全金. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 字典转模型基类，属性首字母不区分大小写
 */
@interface MNZJSONBaseModel : NSObject

/**
 *  将属性名换为其他key去字典中取值
 *
 *  @return 字典中的key是属性名，value是从字典中取值用的key
 */
- (NSDictionary *)mnz_replacedKeyFromPropertyName;
/**
 *  数组中需要转换的模型类
 *
 *  @return 字典中的key是数组属性名，value是数组中存放模型的Class（Class类型或者NSString类型）
 */
- (NSDictionary *)mnz_objectClassInArray;

@end
