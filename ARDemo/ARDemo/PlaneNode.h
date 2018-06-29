//
//  PlaneNode.h
//  ARDemo
//
//  Created by ChenBin on 2018/6/29.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

#import <SceneKit/SceneKit.h>
#import <ARKit/ARPlaneAnchor.h>

@interface PlaneNode : SCNNode

+ (instancetype)planeNodeWithAnchor:(ARPlaneAnchor *)anchor;

- (void)updatePlaneNodeWithAnchor:(ARPlaneAnchor *)anchor;

- (void)removePlaneNodeWithAnchor:(ARPlaneAnchor *)anchor;

@end
