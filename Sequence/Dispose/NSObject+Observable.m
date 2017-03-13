//
//  ObservableObject.m
//  Sequence
//
//  Created by CSwater on 2017/3/2.
//  Copyright © 2017年 CSwater. All rights reserved.
//

#import "NSObject+Observable.h"
#import <objc/runtime.h>

@interface NSObject()

@property (nonatomic, strong) NSArray<SubscribeBlockObject *> *blockObjects;

@end

@implementation NSObject (Observable)

static char *BlockObjectsKey = "BlockObjectsKey";

#pragma mark - dynamic property

- (NSArray<SubscribeBlockObject *> *)blockObjects {
    NSArray *blockObjects = objc_getAssociatedObject(self, BlockObjectsKey);
    return blockObjects ? blockObjects : [NSArray new];
}

- (void)setBlockObjects:(NSArray<SubscribeBlockObject *> *)blockObjects {
    objc_setAssociatedObject(self, BlockObjectsKey, blockObjects, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark - actions

- (Disposable *)subscribeUserContext:(SubscribeBlock)block {
    if ([self respondsToSelector: @selector(observeTargetFirstValue)]) {
        block([self observeTargetFirstValue]);
    }
    
    SubscribeBlockObject *blockObject = [SubscribeBlockObject blockObjectWithBlock: block];
    self.blockObjects = [self.blockObjects arrayByAddingObject: blockObject];
    
    __weak typeof(self) weakSelf = self;
    return [AnonymousDisposable disposableWithDisposeAction:^{
        NSMutableArray *blockObjects = [NSMutableArray arrayWithArray: weakSelf.blockObjects];
        [blockObjects removeObject: blockObject];
        weakSelf.blockObjects = blockObjects;
    }];
}

- (void)dispatch:(id)value {
    for (SubscribeBlockObject *blockObject in self.blockObjects) {
        blockObject.block(value);
    }
}

@end
