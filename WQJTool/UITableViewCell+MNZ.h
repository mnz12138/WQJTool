//
//  UITableViewCell+MNZ.h
//  简化代码
//
//  Created by 王全金 on 2017/12/20.
//  Copyright © 2017年 王全金. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (MNZ)

/**简便获取cell方法，重用identifier是ClassName*/
+ (instancetype)cellForTableView:(UITableView *)tableView;

@end
