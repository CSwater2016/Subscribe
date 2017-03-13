//
//  UserContext.h
//  Sequence
//
//  Created by CSwater on 2017/3/2.
//  Copyright © 2017年 CSwater. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Observable.h"

@interface UserContext : NSObject

@property (nonatomic, strong) NSString *myText;

+ (instancetype)shareInstant;

@end
