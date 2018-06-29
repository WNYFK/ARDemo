//
//  ARImageViewController.m
//  ARDemo
//
//  Created by ChenBin on 2018/6/29.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

#import "ARImageViewController.h"
#import <ARKit/ARKit.h>

@interface ARImageViewController ()<ARSCNViewDelegate>

@property (nonatomic, strong) ARSCNView *scnView;
@property (nonatomic, strong) ARReferenceImage *referenceImage;

@end

@implementation ARImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scnView = [[ARSCNView alloc] initWithFrame:self.view.bounds];
    self.scnView.delegate = self;
    [self.view addSubview:self.scnView];
    self.scnView.scene = [SCNScene new];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    ARWorldTrackingConfiguration *config = [ARWorldTrackingConfiguration new];
//    config.detectionImages = [ARReferenceImage referenceImagesInGroupNamed:@"AR Resources" bundle:nil];
    config.detectionImages = [ARReferenceImage referenceImagesInGroupNamed:@"AR Resources" bundle:nil];

    [self.scnView.session runWithConfiguration:config options:ARSessionRunOptionResetTracking |ARSessionRunOptionRemoveExistingAnchors];

}

- (void)renderer:(id<SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    
    ARImageAnchor * imageAnchor = (ARImageAnchor *)anchor;
    
    //获取参考图片对象
    ARReferenceImage * referenceImage = imageAnchor.referenceImage;
    NSLog(@"识别出：%@",referenceImage.name);
    
    if ([referenceImage.name isEqualToString:@"lcw"]) {
        
        SCNNode * tempNode = [SCNNode new];
        
        CGFloat w = referenceImage.physicalSize.width;
        CGFloat h = referenceImage.physicalSize.height;
        
        SCNBox * box = [SCNBox boxWithWidth:w height:h length:0.01 chamferRadius:0];
        tempNode.geometry = box;
        tempNode.eulerAngles = SCNVector3Make(-M_PI/2.0, 0, 0);
        tempNode.opacity = 0.5;//透明度
        
        [node addChildNode:tempNode];
    }
    
}

@end
