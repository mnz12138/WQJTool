//
//  ViewController.m
//  WQJTool
//
//  Created by 王全金 on 2017/11/21.
//  Copyright © 2017年 mnz. All rights reserved.
//

#import "ViewController.h"
//#import "DetailViewController.h"
//#import "WQJTool.h"

@interface ViewController ()

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    __weak typeof(self) weakSelf = self;
//    if (@available(iOS 10.0, *)) {
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
//            weakSelf.name = [NSString stringWithFormat:@"%d",arc4random()];
//            NSLog(@"name:%@",weakSelf.name);
//        }];
//        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
//    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    //发送一个无效的消息，并不会奔溃
//    [self performSelector:@selector(run:) withObject:@"123"];
//    //测试数组和字典
//    NSArray *array = @[@"1",@"2"];
//    NSLog(@"%@",array[5]);
//
//    NSMutableArray *mArray = [NSMutableArray arrayWithObjects:@"123", nil, @"456", nil];
//    [mArray addObject:nil];
//    mArray[0] = nil;
//    mArray[6] = nil;
//    NSLog(@"%@",mArray[5]);
//
//    NSString *str = nil;
//    NSDictionary *dict = @{@"a":@"1", @"b":str, str:str, @"d":@"4"};
//
//    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithDictionary:@{@"a":@"1", @"b":@"2",str:str,@"c":str,@"e":@"5"}];
//    mDict[@"c"] = nil;
//    mDict[str] = nil;
//    [mDict setObject:nil forKey:nil];
//    NSLog(@"%@",mDict[@"d"]);
//
//    DetailViewController *detailVc = [[DetailViewController alloc] init];
//    [self addObserver:detailVc forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
//    [detailVc guard_addDeallocBlock:^{
//        NSLog(@"detailVc-dealloc");
//    }];
//    [self.navigationController pushViewController:detailVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
