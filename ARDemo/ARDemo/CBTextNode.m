//
//  CBTextNode.m
//  ARDemo
//
//  Created by ChenBin on 2018/7/6.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

#import "CBTextNode.h"

@implementation CBTextNode

+ (SCNNode *)textNodeWithStr:(NSString *)string {
    SCNText *text = [SCNText textWithString:string extrusionDepth:1];
    text.font = [UIFont systemFontOfSize:1];
    text.firstMaterial.diffuse.contents = @"my_logo.png";
    SCNNode *node = [SCNNode nodeWithGeometry:text];
    node.physicsBody = [SCNPhysicsBody bodyWithType:SCNPhysicsBodyTypeDynamic shape:[SCNPhysicsShape shapeWithGeometry:[SCNBox boxWithWidth:1 height:1 length:1 chamferRadius:0] options:nil]];
    return node;
}

@end
