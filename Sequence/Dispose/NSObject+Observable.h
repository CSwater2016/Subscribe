//
//  ObservableObject.h
//  Sequence
//
//  Created by CSwater on 2017/3/2.
//  Copyright © 2017年 CSwater. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubscribeBlockObject.h"
#import "Disposable.h"

//  如果订阅的时候需要立即派发，就实现这个协议(返回监听的对象)
@protocol ObserveFirstProtocol <NSObject>

@optional
- (id)observeTargetFirstValue;

@end

@interface NSObject (Observable)<ObserveFirstProtocol>

- (Disposable *)subscribeUserContext:(SubscribeBlock)block;

// 开始派发 (在子类需要监听的属性的set方法中赋值)
- (void)dispatch:(id)value;

@end
