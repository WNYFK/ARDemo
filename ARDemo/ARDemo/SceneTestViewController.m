//
//  SceneTestViewController.m
//  ARDemo
//
//  Created by ChenBin on 2018/7/3.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

#import "SceneTestViewController.h"
#import <ARKit/ARKit.h>
#import "CBPlaneNode.h"
#import "UIView+DHSmartScreenshot.h"

@interface SceneTestViewController ()
@property (nonatomic, strong) ARSCNView *scnView;
@end

@implementation SceneTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scnView = [[ARSCNView alloc] initWithFrame:self.view.bounds];
    self.scnView.scene = [SCNScene scene];
    [self.view addSubview:self.scnView];
    self.scnView.allowsCameraControl = YES;
    
    CBPlaneNode *planeNode = [CBPlaneNode planeWithWidth:0.8 withHeight:0.3 withMaterialContents:UIColor.whiteColor];
    planeNode.eulerAngles = SCNVector3Make(M_PI_2, M_PI_2, 0);
    [self.scnView.scene.rootNode addChildNode:planeNode];
}

@end
