//
//  ParticleSystemViewController.m
//  ARDemo
//
//  Created by chenbin on 2018/7/7.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

#import "ParticleSystemViewController.h"
#import <ARKit/ARKit.h>

@interface ParticleSystemViewController ()
@property (nonatomic, strong) SCNView *scnView;
@end

@implementation ParticleSystemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scnView = [[SCNView alloc] initWithFrame:self.view.bounds options:@{SCNPreferLowPowerDeviceKey: @(YES)}];
    self.scnView.backgroundColor = UIColor.blackColor;
    self.scnView.scene = [SCNScene scene];
    self.scnView.allowsCameraControl = YES;
    [self.view addSubview:self.scnView];
    
    SCNCamera *camera = [SCNCamera camera];
    SCNNode *node = [SCNNode node];
    node.camera = camera;
    camera.automaticallyAdjustsZRange = YES;
    node.position = SCNVector3Make(0, 0, 50);
    [self.scnView.scene.rootNode addChildNode:node];
    
    SCNBox *box = [SCNBox boxWithWidth:10 height:10 length:10 chamferRadius:0];
    box.firstMaterial.diffuse.contents = UIColor.redColor;
    SCNNode *boxNode = [SCNNode nodeWithGeometry:box];
    boxNode.position = SCNVector3Make(0, 10, -100);
    [self.scnView.scene.rootNode addChildNode:boxNode];
    
    SCNParticleSystem *particleSystem = [SCNParticleSystem particleSystemNamed:@"fire.scnp" inDirectory:nil];
    SCNNode *fireNode = [SCNNode node];
    [fireNode addParticleSystem:particleSystem];
    fireNode.position = SCNVector3Make(0, -1, 0);
    [boxNode addChildNode:fireNode];
}

@end
