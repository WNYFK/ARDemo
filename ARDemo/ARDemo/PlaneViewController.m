//
//  PlaneViewController.m
//  ARDemo
//
//  Created by chenbin on 2018/6/30.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

#import "PlaneViewController.h"
#import <ARKit/ARKit.h>

@interface PlaneViewController ()<ARSCNViewDelegate>
@property (nonatomic, strong) ARSCNView *scnView;

@end

@implementation PlaneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scnView = [[ARSCNView alloc] initWithFrame:self.view.bounds];
    self.scnView.scene = [SCNScene new];
    [self.view addSubview:self.scnView];
    
    SCNPlane *plane = [SCNPlane planeWithWidth:10 height:3];
    SCNNode *geoNode = [SCNNode nodeWithGeometry:plane];

    plane.firstMaterial.multiply.contents = @"materals.png";
    plane.firstMaterial.diffuse.contents = @"materals.png";
    plane.firstMaterial.multiply.intensity = 0.5;
    plane.firstMaterial.lightingModelName = SCNLightingModelConstant;
    geoNode.name = @"geonode";
    geoNode.position = SCNVector3Make(0, 6, -20);
    [self.scnView.scene.rootNode addChildNode:geoNode];
    [geoNode runAction:[SCNAction moveByX:5 y:5 z:0 duration:1]];
    [geoNode runAction:[SCNAction moveBy:SCNVector3Make(5, 5, 0) duration:1]];
}

- (void)addNode {
    SCNNode *newNode = [SCNNode node];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    ARWorldTrackingConfiguration *config = [ARWorldTrackingConfiguration new];
//    [self.scnView.session runWithConfiguration:config options:ARSessionRunOptionResetTracking |ARSessionRunOptionRemoveExistingAnchors];
    
}

- (void)renderer:(id<SCNSceneRenderer>)renderer didRemoveNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    NSLog(@"%@", node.name);
}
@end
