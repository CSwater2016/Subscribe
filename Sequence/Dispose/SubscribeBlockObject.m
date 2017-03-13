//
//  SubscribeBlockObject.m
//  Sequence
//
//  Created by CSwater on 2017/3/2.
//  Copyright © 2017年 CSwater. All rights reserved.
//

#import "SubscribeBlockObject.h"

@implementation SubscribeBlockObject

+ (instancetype)blockObjectWithBlock:(SubscribeBlock)block {
    SubscribeBlockObject *blockObject = [[SubscribeBlockObject alloc] init];
    blockObject.block = block;
    return blockObject;
}

@end
