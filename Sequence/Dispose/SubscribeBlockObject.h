//
//  SubscribeBlockObject.h
//  Sequence
//
//  Created by CSwater on 2017/3/2.
//  Copyright © 2017年 CSwater. All rights reserved.
//
//  ·订阅·功能的思路：把所有需要执行的block都存储起来，数据变更的时候挨个执行一遍。
//  block不能存入数组，因此，用当前类来存block，再把类存入数组。

#import <Foundation/Foundation.h>

typedef void(^SubscribeBlock)(id subscriber);

@interface SubscribeBlockObject : NSObject

@property (nonatomic, copy) SubscribeBlock block;
+ (instancetype)blockObjectWithBlock:(SubscribeBlock)block;

@end
