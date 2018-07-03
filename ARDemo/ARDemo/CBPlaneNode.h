//
//  CBPlaneNode.h
//  ARDemo
//
//  Created by ChenBin on 2018/7/3.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

#import <SceneKit/SceneKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^NodeClicked)(void);
@interface CBPlaneNode : SCNNode

@property (nonatomic, copy) NodeClicked callback;
@property (nonatomic, assign, readonly) CGFloat width;
@property (nonatomic, assign, readonly) CGFloat height;
@property (nonatomic, assign, readonly) CGFloat right;

+ (instancetype)planeWithWidth:(CGFloat)width withHeight:(CGFloat)height withMaterialContents:(nonnull id)contents cornerRadius:(CGFloat)cornerRadius;

+ (instancetype)planeWithWidth:(CGFloat)width withHeight:(CGFloat)height withMaterialContents:(nonnull id)contents;

@end

NS_ASSUME_NONNULL_END
