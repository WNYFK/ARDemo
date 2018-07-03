//
//  CBPlaneNode.m
//  ARDemo
//
//  Created by ChenBin on 2018/7/3.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

#import "CBPlaneNode.h"

@interface CBPlaneNode ()

@property (nonatomic, strong) SCNPlane *plane;

@end

@implementation CBPlaneNode

+ (instancetype)planeWithWidth:(CGFloat)width withHeight:(CGFloat)height withMaterialContents:(nonnull id)contents {
    return [CBPlaneNode planeWithWidth:width withHeight:height withMaterialContents:contents cornerRadius:0];
}

+ (instancetype)planeWithWidth:(CGFloat)width withHeight:(CGFloat)height withMaterialContents:(nonnull id)contents cornerRadius:(CGFloat)cornerRadius {
    CBPlaneNode *node = [CBPlaneNode node];
    
    node.plane = [SCNPlane planeWithWidth:width height:height];
    node.plane.cornerRadius = cornerRadius;
    node.plane.firstMaterial.diffuse.contents = contents;
    node.geometry = node.plane;
    
    return node;
}

- (CGFloat)width {
    return self.plane.width;
}

- (CGFloat)height {
    return self.plane.height;
}

- (CGFloat)right {
    return self.position.x + self.plane.width;
}

@end
