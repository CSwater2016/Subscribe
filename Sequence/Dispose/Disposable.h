//
//  Disposable.h
//  Sequence
//
//  Created by CSwater on 2017/3/2.
//  Copyright © 2017年 CSwater. All rights reserved.
//
//  ·销毁类·
//  用于存储销毁`功能block`操作(`销毁block`)的对象

#import <Foundation/Foundation.h>

@interface Disposable : NSObject

- (void)dispose;

@end

typedef void(^DisposeAction)();

@interface AnonymousDisposable : Disposable

// 创建一个存储销毁操作的对象
+ (instancetype)disposableWithDisposeAction:(DisposeAction) disposeAction;

@end
