//
//  CBAction.m
//  ARDemo
//
//  Created by chenbin on 2018/6/30.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

#import "CBAction.h"

@interface CBAction()
@property (nonatomic, strong) NSString *title;

@end

@implementation CBAction

- (instancetype)initWithTitle:(NSString *)title callback:(void (^)(void))callback {
    if (self = [super init]) {
        self.title = title;
        self.callback = callback;
    }
    return self;
}

+ (instancetype)actionWithTitle:(NSString *)title callback:(CallBack)callback {
    return [[CBAction alloc] initWithTitle:title callback:callback];
}
@end
