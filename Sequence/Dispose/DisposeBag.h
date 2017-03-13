//
//  DisposeBag.h
//  Sequence
//
//  Created by CSwater on 2017/3/3.
//  Copyright © 2017年 CSwater. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Disposable.h"

@interface DisposeBag : NSObject

@end

@interface Disposable(Bag)

- (void)addToDisposeBag:(DisposeBag *)bag;

@end
