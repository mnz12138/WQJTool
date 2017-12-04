//
//  UITableView+MNZ.m
//  WQJTool
//
//  Created by 王全金 on 2017/12/4.
//  Copyright © 2017年 mnz. All rights reserved.
//

#import "UITableView+MNZ.h"
#import "NSObject+MNZ.h"

@implementation UITableView (MNZ)

+ (void)load {
    [self swizzleMethod:@selector(initWithFrame:style:) andAnotherSelecor:@selector(mnz_initWithFrame:style:)];
    [self swizzleMethod:@selector(initWithCoder:) andAnotherSelecor:@selector(mnz_initWithCoder:)];
}

- (instancetype)mnz_initWithCoder:(NSCoder *)coder {
    UITableView *tableView = [self mnz_initWithCoder:coder];
    [self setupParams];
    return tableView;
}

- (instancetype)mnz_initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    UITableView *tableView = [self mnz_initWithFrame:frame style:style];
    [self setupParams];
    return tableView;
}
//初始化一些信息
- (void)setupParams {
    //iOS11上tableView有预估值，刷新表格是会跳动
    self.estimatedRowHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
}

@end
