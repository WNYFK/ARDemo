//
//  ARImageViewController.m
//  ARDemo
//
//  Created by ChenBin on 2018/6/29.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

#import "ARImageViewController.h"
#import <ARKit/ARKit.h>
#import "VideoPlayer.h"
#import "UIView+DHSmartScreenshot.h"
#import "CBMovieNode.h"
#import "CBPlaneNode.h"

@interface ARImageViewController ()<ARSCNViewDelegate>

@property (nonatomic, strong) ARSCNView *scnView;

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
//    config.maximumNumberOfTrackedImages = 1;
//
//    ARImageTrackingConfiguration *imgConfig = [ARImageTrackingConfiguration new];
//    imgConfig.trackingImages = config.detectionImages;
//    imgConfig.maximumNumberOfTrackedImages = 1;

    [self.scnView.session runWithConfiguration:config options:ARSessionRunOptionResetTracking | ARSessionRunOptionRemoveExistingAnchors];
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
        if ([result.node isKindOfClass:[CBPlaneNode class]]) {
            ((CBPlaneNode *)result.node).callback();
        }
    }
}

- (SCNNode *)renderer:(id<SCNSceneRenderer>)renderer nodeForAnchor:(ARAnchor *)anchor {
    if ([anchor isKindOfClass:[ARImageAnchor class]]) {
        ARReferenceImage *referenceImage = [(ARImageAnchor *)anchor referenceImage];
        if ([referenceImage.name isEqualToString:@"lcw"] || [referenceImage.name isEqualToString:@"yd"]) {
            CBMovie *movie = [[CBMovie alloc] init];
            movie.score = 7;
            movie.wishNum = @"2354234";
            movie.ticket = @"60元";
            movie.desStr = @"123阿萨德法师法师法师打发士大夫撒旦法师法师的法师打发斯蒂芬阿斯顿发送到发送到吧是；劳动法卡水电费离开；阿斯蒂芬静安寺达拉斯的发票是打飞机啊十字路口；的GV阿半年还是东风路卡士大夫；阿萨德了开发商拿到发卡拉收件人爱哦委托方嘎婆is多个或阿萨德法师法师法师打发士大夫撒旦法师法师的法师打发斯蒂芬阿斯顿发送到发送到吧是；劳动法卡水电费离开；阿斯蒂芬静安寺达拉斯的发票是打飞机啊十字路口；的GV阿半年还是东风路卡士大夫；阿萨德了开发商拿到发卡拉收件人爱哦委托方嘎婆is多个或阿萨德法师法师法师打发士大夫撒旦法师法师的法师打发斯蒂芬阿斯顿发送到发送到吧是；劳动法卡水电费离开；阿斯蒂芬静安寺达拉斯的发票是打飞机啊十字路口；的GV阿半年还是东风路卡士大夫；阿萨德了开发商拿到发卡拉收件人爱哦委托方嘎婆is多个或阿萨德法师法师法师打发士大夫撒旦法师法师的法师打发斯蒂芬阿斯顿发送到发送到吧是；劳动法卡水电费离开；阿斯蒂芬静安寺达拉斯的发票是打飞机啊十字路口；的GV阿半年还是东风路卡士大夫；阿萨德了开发商拿到发卡拉收件人爱哦委托方嘎婆is多个或阿萨德法师法师法师打发士大夫撒旦法师法师的法师打发斯蒂芬阿斯顿发送到发送到吧是；劳动法卡水电费离开；阿斯蒂芬静安寺达拉斯的发票是打飞机啊十字路口；的GV阿半年还是东风路卡士大夫；阿萨德了开发商拿到发卡拉收件人爱哦委托方嘎婆is多个或阿萨德法师法师法师打发士大夫撒旦法师法师的法师打发斯蒂芬阿斯顿发送到发送到吧是；劳动法卡水电费离开；阿斯蒂芬静安寺达拉斯的发票是打飞机啊十字路口；的GV阿半年还是东风路卡士大夫；阿萨德了开发商拿到发卡拉收件人爱哦委托方嘎婆is多个或阿萨德法师法师法师打发士大夫撒旦法师法师的法师打发斯蒂芬阿斯顿发送到发送到吧是；劳动法卡水电费离开；阿斯蒂芬静安寺达拉斯的发票是打飞机啊十字路口；的GV阿半年还是东风路卡士大夫；阿萨德了开发商拿到发卡拉收件人爱哦委托方嘎婆is多个或阿萨德法师法师法师打发士大夫撒旦法师法师的法师打发斯蒂芬阿斯顿发送到发送到吧是；劳动法卡水电费离开；阿斯蒂芬静安寺达拉斯的发票是打飞机啊十字路口；的GV阿半年还是东风路卡士大夫；阿萨德了开发商拿到发卡拉收件人爱哦委托方嘎婆is多个或";
            movie.realBox = @"15亿";
            movie.rightTopImg = [UIImage imageNamed:@"rightTop.jpg"];
            movie.rightBottomImg = [UIImage imageNamed:@"rightBottom.jpg"];
            CBMovieNode *movieNode = [[CBMovieNode alloc] initWithMovie:movie];
            movieNode.curVC = self;
            return movieNode;
        }
    }
    return nil;
}

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
        
        
//        [node addChildNode:[CBMovieDetailNode new]];
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
