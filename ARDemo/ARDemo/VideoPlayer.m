//
//  VideoPlayer.m
//  ARDemo
//
//  Created by chenbin on 2018/6/30.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

#import "VideoPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface VideoPlayer()
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) SKVideoNode *videoNode;
@end

@implementation VideoPlayer

- (instancetype)initWithUrl:(NSURL *)url {
    if (self = [super init]) {
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
        self.player = [AVPlayer playerWithPlayerItem:playerItem];
        self.videoNode = [SKVideoNode videoNodeWithAVPlayer:self.player];
        CGSize size = CGSizeMake(1600, 900);
        _videoNode.size = size;
        _videoNode.position = CGPointMake(size.width / 2, size.height / 2);
        
        _videoNode.yScale = -1;
        self.scene = [SKScene sceneWithSize:size];
        [self.scene addChild:self.videoNode];
    }
    return self;
}

- (void)play {
    [self.player play];
}

@end
