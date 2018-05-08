//
//  DetailViewController.m
//  WQJTool
//
//  Created by Apple on 2018/5/7.
//  Copyright © 2018年 mnz. All rights reserved.
//

#import "DetailViewController.h"
#import "WQJTool.h"

@interface DetailViewController ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //创建一个timer，不用自己释放timer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(test:) userInfo:@"123" repeats:YES];
    [self.timer fire];
}

- (void)test:(NSTimer *)timer {
    NSLog(@"timer:%@",timer.userInfo);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"收到了:%@",change[NSKeyValueChangeNewKey]);
}

- (void)dealloc {
    NSLog(@"DetailViewController-dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
