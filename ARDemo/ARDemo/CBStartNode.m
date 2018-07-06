//
//  CBStartNode.m
//  ARDemo
//
//  Created by ChenBin on 2018/7/5.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

#import "CBStartNode.h"

@implementation CBStartNode

- (instancetype)init {
    if (self = [super init]) {
        UIBezierPath *star = [self starPathWithInnerRadius:0.02 outerRadius:0.04];
        //
        SCNShape *shape = [SCNShape shapeWithPath:star extrusionDepth:0.01];
        shape.chamferRadius = 0.02;
//        shape.chamferProfile = [self chamferProfileForOutline];
        shape.chamferMode = SCNChamferModeFront;
        // that way only the outline of the model will be visible
        SCNMaterial *outlineMaterial = [SCNMaterial material];
        outlineMaterial.diffuse.contents = UIColor.yellowColor;
        outlineMaterial.ambient.contents = UIColor.yellowColor;
        outlineMaterial.specular.contents = UIColor.yellowColor;
        outlineMaterial.emission.contents = UIColor.yellowColor;
        outlineMaterial.doubleSided = YES;
        
        SCNMaterial *tranparentMaterial = [SCNMaterial material];
        tranparentMaterial.transparency = 0.0;
        
//        shape.materials = @[tranparentMaterial, tranparentMaterial, tranparentMaterial, outlineMaterial, outlineMaterial];
        
        SCNNode *_starOutline = [SCNNode node];
        _starOutline.geometry = shape;
        _starOutline.geometry.firstMaterial.diffuse.contents = UIColor.yellowColor;
        _starOutline.position = SCNVector3Make(0, 0, 0);
        [self addChildNode:_starOutline];
    }
    return self;
}

- (UIBezierPath *)chamferProfileForOutline {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(1, 1)];
    [path addLineToPoint:CGPointMake(0, 1)];
    return path;
}

- (UIBezierPath *)starPathWithInnerRadius:(CGFloat)innerRadius outerRadius:(CGFloat)outerRadius {
    NSUInteger raysCount = 5;
    CGFloat delta = 2.0 * M_PI / raysCount;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    for (NSUInteger i = 0; i < raysCount; ++i) {
        CGFloat alpha = i * delta + M_PI_2;
        
        if (i == 0){
            [path moveToPoint:CGPointMake(outerRadius * cos(alpha), outerRadius * sin(alpha))];
        }
        else{
            [path addLineToPoint:CGPointMake(outerRadius * cos(alpha), outerRadius * sin(alpha))];
        }
        
        alpha += 0.5 * delta;
        [path addLineToPoint:CGPointMake(innerRadius * cos(alpha), innerRadius * sin(alpha))];
    }
    
    return path;
}

+ (SCNNode *)stars {
    SCNNode *node = [SCNNode node];
    SCNVector3 position = SCNVector3Make(0, 0, 0);
    for (int i = 0; i < 5; i++) {
        CBStartNode *starNode = [CBStartNode node];
        starNode.position = SCNVector3Make(position.x, 1, position.z);
        position = SCNVector3Make(position.x + 0.1, position.y, position.z);
        [node addChildNode:starNode];
        SCNAction *waitAction = [SCNAction waitForDuration:i * 0.3];
        SCNAction *flyAction = [SCNAction moveTo:SCNVector3Make(position.x, 0, position.z) duration:0.3];
        [starNode runAction: [SCNAction sequence:@[waitAction, flyAction]]];
    }
    SCNAction *rotateAction = [SCNAction repeatActionForever:[SCNAction rotateByX:M_PI*2 y:0 z:0 duration:5]];
    [node runAction:rotateAction];
    return node;
}

@end
