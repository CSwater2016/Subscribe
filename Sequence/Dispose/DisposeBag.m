//
//  DisposeBag.m
//  Sequence
//
//  Created by CSwater on 2017/3/3.
//  Copyright © 2017年 CSwater. All rights reserved.
//

#import "DisposeBag.h"

@interface DisposeBag()

@property (nonatomic, strong) NSMutableArray<Disposable *> *disposables;    //  存储销毁对象
@property (nonatomic, assign) BOOL isDisposed;                              //  标记是否销毁
@property (nonatomic, strong) NSRecursiveLock *lock;                        //  递归锁

@end

@implementation DisposeBag

- (instancetype)init {
    if (self = [super init]) {
        self.disposables = [NSMutableArray new];
        self.lock = [NSRecursiveLock new];
    }
    return self;
}

//  存储`销毁block`类，如果已经开始执行销毁操作，则立即销毁。
- (void)addDisposable:(Disposable *)disposable {
    [[self _addDisposable: disposable] dispose];
}

- (Disposable *)_addDisposable:(Disposable *)disposable {
    [self.lock lock];
    
    if (self.isDisposed) {
        [self.lock unlock];
        return disposable;
    } else {
        [self.disposables addObject: disposable];
        [self.lock unlock];
        return nil;
    }
}

//  取到所有的`销毁block`，并删除self对`销毁block`的引用
- (void)dispose {
    NSArray<Disposable *> *disposables = [self _dispose];
    for (Disposable *disposable in disposables) {
        [disposable dispose];
    }
}

- (NSArray<Disposable *> *)_dispose {
    [self.lock lock];
    
    NSArray<Disposable *> * disposables = [NSArray arrayWithArray: self.disposables];
    [self.disposables removeAllObjects];
    self.isDisposed = YES;
    
    [self.lock unlock];
    return disposables;
}

//  dealloc 的时候，执行销毁操作
- (void)dealloc {
    [self dispose];
}

@end


@implementation Disposable(Bag)

- (void)addToDisposeBag:(DisposeBag *)bag {
    [bag addDisposable: self];
}

@end
