//
//  VideoPlayer.h
//  ARDemo
//
//  Created by chenbin on 2018/6/30.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface VideoPlayer : NSObject

@property (nonatomic, strong) SKScene *scene;

- (instancetype)initWithUrl:(NSURL *)url;
- (void)play;

@end
