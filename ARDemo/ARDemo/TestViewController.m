//
//  TestViewController.m
//  ARDemo
//
//  Created by chenbin on 2018/7/1.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

#import "TestViewController.h"
#import <SceneKit/SceneKit.h>

@interface TestViewController ()

@property (nonatomic, strong) SCNView *scnView;

@end

@implementation TestViewController

- (void)addCamera {
    SCNCamera *camera = [SCNCamera camera];
//    [camera setFieldOfView:20];
    camera.usesOrthographicProjection = YES;
    camera.orthographicScale = 10;
    SCNNode *node = [SCNNode node];
    node.camera = camera;
    node.position = SCNVector3Make(0, 0, 50);
    [self.scnView.scene.rootNode addChildNode:node];
    
    SCNBox *box1 = [SCNBox boxWithWidth:10 height:10 length:10 chamferRadius:0];
    box1.firstMaterial.diffuse.contents = UIColor.redColor;
    [self.scnView.scene.rootNode addChildNode:[SCNNode nodeWithGeometry:box1]];
    
    SCNBox *box2 = [SCNBox boxWithWidth:10 height:10 length:10 chamferRadius:0];
    box2.firstMaterial.diffuse.contents = UIColor.greenColor;
    SCNNode *boxNode2 = [SCNNode nodeWithGeometry:box2];
    boxNode2.position = SCNVector3Make(0, 10, -20);
    [self.scnView.scene.rootNode addChildNode:boxNode2];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scnView = [[SCNView alloc] initWithFrame:self.view.bounds];
    _scnView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:_scnView];
    _scnView.scene = [SCNScene scene];
    
    [self addCamera];
//    SCNLight *light = [SCNLight light];
//    light.type = SCNLightTypeSpot;
//    light.castsShadow = YES;
//    light.color = UIColor.yellowColor;
//    SCNNode *lightNode = [SCNNode node];
//    lightNode.light = light;
//    lightNode.position = SCNVector3Make(0, 0, 100);
//    [scnView.scene.rootNode addChildNode:lightNode];
//
//
//    SCNBox *box = [SCNBox boxWithWidth:0.1 height:0.1 length:0.1 chamferRadius:0];
//    box.firstMaterial.diffuse.contents = UIColor.whiteColor;
//
//    SCNNode *boxNode = [SCNNode nodeWithGeometry:box];
//    boxNode.position = SCNVector3Make(-0.1, 0.5, 1);
//    [scnView.scene.rootNode addChildNode:boxNode];
    _scnView.allowsCameraControl = YES;
//
//
//    SCNNode *sphereNode = [SCNNode node];
//    SCNSphere *sphere = [SCNSphere sphereWithRadius:0.5];
//    sphere.firstMaterial.diffuse.contents = UIColor.whiteColor;
//    sphereNode.geometry = sphere;
//    sphereNode.position = SCNVector3Make(-0.6, 0, 1);
//    [scnView.scene.rootNode addChildNode:sphereNode];
//
//    SCNNode *textNode = [SCNNode node];
//    textNode.position = SCNVector3Make(0, -0.3, 1);
//    SCNText *text = [SCNText textWithString:@"让学习成为一种习惯" extrusionDepth:0.03];
//    text.firstMaterial.diffuse.contents = UIColor.whiteColor;
//    text.font = [UIFont systemFontOfSize:0.15];
//    textNode.geometry = text;
//    [scnView.scene.rootNode addChildNode:textNode];
//
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
