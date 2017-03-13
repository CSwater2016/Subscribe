//
//  Disposable.m
//  Sequence
//
//  Created by CSwater on 2017/3/2.
//  Copyright © 2017年 CSwater. All rights reserved.
//

#import "Disposable.h"

@implementation Disposable

- (void)dispose{}

@end

@interface AnonymousDisposable()

@property(nonatomic, copy) DisposeAction disposeAction;     //  执行销毁操作的block
@property(nonatomic, assign, readwrite) BOOL disposed;      //  是否已销毁的标记

@end

@implementation AnonymousDisposable

+ (instancetype)disposableWithDisposeAction:(DisposeAction)disposeAction {
    AnonymousDisposable *disposable = [[AnonymousDisposable alloc] init];
    disposable.disposeAction = disposeAction;
    return disposable;
}

//  销毁操作
- (void)dispose {
    if (self.disposed) { return; }  // 如果已被销毁，就不再执行（如果此时已被销毁，可以提前退出）
    
    @synchronized (self) {
        if (self.disposed) { return; }  // 加锁之后，再判断是否被销毁（必要的保险措施）
        
        self.disposed = YES;
        // 这样就不会导致action中的对象强引用self
        DisposeAction action = self.disposeAction;
        self.disposeAction = nil;
        action();
    }
}

@end
