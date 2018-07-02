//
//  CBAction.h
//  ARDemo
//
//  Created by chenbin on 2018/6/30.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CallBack)(void);

@interface CBAction : NSObject

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, copy) CallBack callback;

- (instancetype)initWithTitle:(NSString *)title callback:(CallBack)callback;

+ (instancetype)actionWithTitle:(NSString *)title callback:(CallBack)callback;

@end
