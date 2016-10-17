//
//  ViewController.m
//  删除
//
//  Created by 杜帅 on 16/10/10.
//  Copyright © 2016年 杜帅. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

/** <#(id)#> */
@property (nonatomic, strong) NSDate *now;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _now = [NSDate date];
    NSLog(@"%@", _now);
    [self addObserver:self forKeyPath:@"now" options:NSKeyValueObservingOptionNew  context:nil];
   
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _now = [NSDate date];
        NSLog(@"%@", _now);
        [self willChangeValueForKey:@"now"]; // “手动触发self.now的KVO”，必写。
        [self didChangeValueForKey:@"now"]; // “手动触发self.now的KVO”，必写。
    });
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"时间变化");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
