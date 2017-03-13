//
//  TestViewController.m
//  Sequence
//
//  Created by CSwater on 2017/3/2.
//  Copyright © 2017年 CSwater. All rights reserved.
//

#import "TestViewController.h"
#import "UserContext.h"
#import "DisposeBag.h"

@interface TestViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) DisposeBag *disposeBag;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.disposeBag = [[DisposeBag alloc] init];
    
    [[[UserContext shareInstant] subscribeUserContext:^(id subscriber) {
        NSLog(@"后一个控制器：%@",subscriber);
    }] addToDisposeBag: self.disposeBag] ;
}

- (IBAction)onFirst:(id)sender {
    [UserContext shareInstant].myText = @"First";
}

- (IBAction)onSecond:(id)sender {
    [UserContext shareInstant].myText = @"second";
}

- (IBAction)onThird:(id)sender {
    [UserContext shareInstant].myText = @"third";
}

@end
