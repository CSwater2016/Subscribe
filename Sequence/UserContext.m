//
//  UserContext.m
//  Sequence
//
//  Created by CSwater on 2017/3/2.
//  Copyright © 2017年 CSwater. All rights reserved.
//

#import "UserContext.h"

@interface UserContext()

@end

@implementation UserContext

+ (instancetype)shareInstant {
    static UserContext *userContext;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userContext = [[UserContext alloc] init];
    });
    return userContext;
}

- (void)setMyText:(NSString *)myText {
    _myText = myText;
    
    [self dispatch: myText];          // 派发
}

- (id)observeTargetFirstValue {
    return self.myText;
}

@end
