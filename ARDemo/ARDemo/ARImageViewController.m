//
//  ARImageViewController.m
//  ARDemo
//
//  Created by ChenBin on 2018/6/29.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

#import "ARImageViewController.h"
#import <ARKit/ARKit.h>
#import "CBNode.h"
#import "VideoPlayer.h"

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

    [self.scnView.session runWithConfiguration:config options:ARSessionRunOptionResetTracking];
    
    

}

- (SCNVector3)positionWithWorldTransform:(matrix_float4x4)worldTransform
{
    // 从世界坐标系中的一个位姿中提取位置
    return SCNVector3Make(worldTransform.columns[3].x, worldTransform.columns[3].y, worldTransform.columns[3].z);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[touches allObjects] firstObject];
    // 获取场景坐标
    // 获取屏幕坐标
    
    CGPoint point = [touch locationInView:self.scnView];
    
    // 命中测试，类型为已存在的平面
    NSArray<SCNHitTestResult *> *resultArray = [self.scnView hitTest:point options:nil];
    
    if (nil!=resultArray && resultArray.count>0)
    {
        // 拿到命中测试结果，取出位置
        SCNHitTestResult *result = [resultArray firstObject];
        NSLog(@"点击：%@",result.node.name);
//        SCNVector3 vector = [self positionWithWorldTransform:result.worldTransform];
        
        // 获取模型场景
//        SCNScene *scene = [SCNScene sceneNamed:@"scene.scn"];
//        SCNNode *node = [scene.rootNode clone];
//        node.position = vector;
//        
//        // 添加到根节点中
//        [self.scnView.scene.rootNode addChildNode:node];
    }
//    // 显示点击位置
//
//    // 搜索节点
//    [self.scnView hitTest:<#(CGPoint)#> types:<#(ARHitTestResultType)#>]
//    NSArray <scnn *>* nodes = [self.scnView.scene nodesAtPoint:skPoint];
//    SKNode *node = nodes.firstObject;
//    if (node)
//    {
//        // 如果能搜索到，则移除
//        [node removeFromParent];
//    }else
//    {
//        // 搜索不到时，添加一个节点到场景中
//        ARFrame *currentFrame = self.skView.session.currentFrame;
//
//        if (currentFrame)
//        {
//            // 使用相机的位姿信息来确定节点的位姿
//            matrix_float4x4 translation = matrix_identity_float4x4;
//            translation.columns[3].z  = -0.3;
//
//            matrix_float4x4 transform = matrix_multiply(currentFrame.camera.transform, translation);
//
//            // 新建锚点添加到场景中
//            ARAnchor *anchor = [[ARAnchor alloc] initWithTransform:transform];
//            [self.skView.session addAnchor:anchor];
//        }
//    }
}

//- (nullable SCNNode *)renderer:(id <SCNSceneRenderer>)renderer nodeForAnchor:(ARAnchor *)anchor {
//    return nil;
//}

- (void)renderer:(id<SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    
    ARImageAnchor * imageAnchor = (ARImageAnchor *)anchor;
    
    //获取参考图片对象
    ARReferenceImage * referenceImage = imageAnchor.referenceImage;
    NSLog(@"识别出：%@",referenceImage.name);
    
    if ([referenceImage.name isEqualToString:@"lcw"]) {
        
//        SCNNode * tempNode = [SCNNode new];
//        
//        CGFloat w = referenceImage.physicalSize.width;
//        CGFloat h = referenceImage.physicalSize.height;
//        SCNBox * box = [SCNBox boxWithWidth:w / 10 height:h / 10 length:0.001 chamferRadius:0];
//
////        SCNPlane *plane = [SCNPlane planeWithWidth:w / 10 height:h / 10];
//        
//        box.firstMaterial.multiply.contents = @"materals.png";
//        box.firstMaterial.diffuse.contents = @"materals.png";
//        box.firstMaterial.multiply.intensity = 0.5;
//        box.firstMaterial.lightingModelName = SCNLightingModelConstant;
//        tempNode.geometry = box;
//        tempNode.eulerAngles = SCNVector3Make(-M_PI/2.0, 0, 0);
//        tempNode.opacity = 0;//透明度
//        
//        [tempNode runAction:[SCNAction scaleBy:20 duration:0.5]];
//        [tempNode runAction:[SCNAction fadeOpacityTo:1 duration:0.5]];
        
        
        [node addChildNode:[CBMovieDetailNode new]];
    }
}

- (void)renderer:(id<SCNSceneRenderer>)renderer willUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    if ([anchor isKindOfClass:[ARReferenceImage class]]) {
        
    }
}

- (void)renderer:(id <SCNSceneRenderer>)renderer didUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    NSLog(@"didupdate");
}

- (void)renderer:(id<SCNSceneRenderer>)renderer didRemoveNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    NSLog(@"remove");
}

@end
