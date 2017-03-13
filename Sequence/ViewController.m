//
//  ViewController.m
//  Sequence
//
//  Created by CSwater on 2017/3/2.
//  Copyright © 2017年 CSwater. All rights reserved.
//

#import "ViewController.h"
#import "UserContext.h"
#import "DisposeBag.h"

@interface ViewController ()

@property (nonatomic, strong) DisposeBag *disposeBag;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.disposeBag = [[DisposeBag alloc] init];
    
    [[[UserContext shareInstant] subscribeUserContext:^(id subscriber) {
        NSLog(@"前一个控制器: %@", subscriber);
    }] addToDisposeBag: self.disposeBag];
}

@end
