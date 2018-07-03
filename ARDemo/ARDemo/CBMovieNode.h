//
//  CBMovieNode.h
//  ARDemo
//
//  Created by ChenBin on 2018/7/3.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

#import <SceneKit/SceneKit.h>

NS_ASSUME_NONNULL_BEGIN

#define kNodeShareName @"ShareName"
#define kNodeCollectName @"collectName"

@interface CBMovie : NSObject

@property (nonatomic, assign) NSInteger score;
@property (nonatomic, strong) NSString *wishNum;
@property (nonatomic, strong) NSString *ticket;
@property (nonatomic, strong) NSString *desStr;
@property (nonatomic, strong) NSString *realBox;
@property (nonatomic, strong) UIImage *rightTopImg;
@property (nonatomic, strong) UIImage *rightBottomImg;

@end

@interface CBMovieNode : SCNNode

@property (nonatomic, weak) UIViewController *curVC;

- (instancetype)initWithMovie:(CBMovie *)movie;

@end

NS_ASSUME_NONNULL_END
