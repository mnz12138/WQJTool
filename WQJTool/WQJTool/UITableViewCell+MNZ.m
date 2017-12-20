//
//  UITableViewCell+MNZ.m
//  简化代码
//
//  Created by 王全金 on 2017/12/20.
//  Copyright © 2017年 王全金. All rights reserved.
//

#import "UITableViewCell+MNZ.h"

@implementation UITableViewCell (MNZ)

+ (instancetype)cellForTableView:(UITableView *)tableView {
    static NSString *identifier;
    Class cellClassName = [self class];
    identifier = NSStringFromClass(cellClassName);
    if (cellClassName) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell==nil) {
            cell = [[cellClassName alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        return cell;
    }
    return [self new];
}

@end
