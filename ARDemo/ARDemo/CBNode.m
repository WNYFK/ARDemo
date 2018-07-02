//
//  CBNode.m
//  ARDemo
//
//  Created by chenbin on 2018/6/30.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

#import "CBNode.h"
#import "VideoPlayer.h"

@interface CBNode()

@property (nonatomic, strong) SCNNode *leftNode;
@property (nonatomic, strong) SCNNode *midNode;
@property (nonatomic, strong) SCNNode *rightNode;


@end

@implementation CBNode

- (instancetype)init {
    if (self = [super init]) {
        [self addChildNode:self.leftNode];
        [self addChildNode:self.midNode];
        [self addChildNode:self.rightNode];
    }
    return self;
}

- (SCNNode *)leftNode {
    
    return [self createTextNode:@"testNode" x:-0.01 y:0.01];
    
}

- (CALayer *)layer {
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 100, 100);
    layer.backgroundColor = [UIColor redColor].CGColor;
    
    return layer;
}

- (SCNNode *)midNode {
    SCNNode * tempNode = [SCNNode new];
    
    CGFloat w = 2;
    CGFloat h = 1;
    SCNBox * box = [SCNBox boxWithWidth:w / 10 height:h / 10 length:0.001 chamferRadius:0];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"freeVideo" withExtension:@"mp4"];
    VideoPlayer *player = [[VideoPlayer alloc] initWithUrl:url];
    [player play];
    
//    box.firstMaterial.multiply.contents = @"materals.png";
    box.firstMaterial.diffuse.contents = player.scene;
    box.firstMaterial.multiply.intensity = 0.5;
    box.firstMaterial.lightingModelName = SCNLightingModelConstant;
    tempNode.geometry = box;
    tempNode.eulerAngles = SCNVector3Make(-M_PI/2.0, 0, 0);
    tempNode.opacity = 2;//透明度
    return tempNode;
}

- (SCNNode *)rightNode {
    SCNNode * tempNode = [SCNNode new];
    
    CGFloat w = 1;
    CGFloat h = 1;
    SCNBox * box = [SCNBox boxWithWidth:w / 10 height:h / 10 length:0.001 chamferRadius:0];
    
    box.firstMaterial.multiply.contents = @"materals.png";
    box.firstMaterial.diffuse.contents = @"materals.png";
    box.firstMaterial.multiply.intensity = 0.5;
    box.firstMaterial.lightingModelName = SCNLightingModelConstant;
    tempNode.geometry = box;
    tempNode.eulerAngles = SCNVector3Make(-M_PI/2.0, 0, 0);
    tempNode.opacity = 1;//透明度
    tempNode.position = SCNVector3Make(0.3, 0, 0);
    return tempNode;
}

- (SCNNode *)createTextNode:(NSString *)title x:(CGFloat)x y:(CGFloat)y {
    SCNText *text = [SCNText textWithString:title extrusionDepth:0];
    text.firstMaterial.diffuse.contents = UIColor.blackColor;
    text.font = [UIFont fontWithName:@"Avenir Next" size:10];
    SCNNode *textNode = [SCNNode nodeWithGeometry:text];
    textNode.position = SCNVector3Make(x, y, 0);
    return textNode;
}



@end

@interface ScoreNode: SCNNode

@end

@interface CBMovieDetailNode ()

@property (nonatomic, strong) SCNNode *movieDetailNode;
@property (nonatomic, strong) SCNNode *scoreNode;
@property (nonatomic, strong) SCNNode *playerNode;
@property (nonatomic, strong) SCNNode *shareNode;

@end

@implementation CBMovieDetailNode

- (instancetype)init {
    self = [super init];
    if (self) {
        self.movieDetailNode = [SCNNode new];
        SCNBox *box = [SCNBox boxWithWidth:0.4 height:0.4 length:0.005 chamferRadius:0];
        box.firstMaterial.diffuse.contents = [UIColor.whiteColor colorWithAlphaComponent:0];
        self.movieDetailNode.geometry = box;
        self.movieDetailNode.position = SCNVector3Make(0.0, -0.008, 0.1);
        self.movieDetailNode.eulerAngles = SCNVector3Make(M_PI_2, 0.0f, 0.0f);
        self.movieDetailNode.name = @"MovieDetailNode";
        [self addChildNode:self.movieDetailNode];
//        [self addChildNode:[self redBackgroundNode]];
        
        SCNNode *redBackgroundNode = [self redBackgroundNode];
        [self.movieDetailNode addChildNode:redBackgroundNode];
        
        self.scoreNode = [ScoreNode new];
        
        self.scoreNode.position = SCNVector3Make(-0.2 - 0.1, -0.17, -0.003);
        [self.movieDetailNode addChildNode:self.scoreNode];
        
        self.playerNode = [self createPlayerNode];
        SCNVector3 redNodeBounds = [self getBoundingBox:redBackgroundNode];
        self.playerNode.position = SCNVector3Make(-redNodeBounds.x/ 2 + 0.1, redNodeBounds.y / 2 - 0.05, 0);
        [redBackgroundNode addChildNode:self.playerNode];
    
        SCNNode *desNode = [self descriptionNode];
        [redBackgroundNode addChildNode: desNode];
        desNode.position = SCNVector3Make(-0.16, -0.2, 0.1);
        
        SCNNode *rightTopNode = [SCNNode node];
        rightTopNode.name = @"rightTopNode";
        SCNBox *box1 = [SCNBox boxWithWidth:0.2 height:0.15 length:0.01 chamferRadius:0];
        box1.firstMaterial.diffuse.contents = UIColor.greenColor;
        rightTopNode.geometry = box1;
        rightTopNode.position = SCNVector3Make(0.02 + 0.1, -0.2 + 0.075, -0.003);
        [self.movieDetailNode addChildNode:rightTopNode];
        
        SCNNode *rightBottomNode = [SCNNode node];
        rightBottomNode.name = @"rightBottomNode";
        SCNBox *box2 = [SCNBox boxWithWidth:0.2 height:0.15 length:0.01 chamferRadius:0];
        box2.firstMaterial.diffuse.contents = UIColor.yellowColor;
        rightBottomNode.geometry = box2;
        rightBottomNode.position = SCNVector3Make(0.02 + 0.1, 0.075, -0.003);
        [self.movieDetailNode addChildNode:rightBottomNode];
        
        self.shareNode = [self createShareNode];
        self.shareNode.position = SCNVector3Make(-0.1, -0.1, -0.02);
        [redBackgroundNode addChildNode:self.shareNode];
    }
    return self;
}

- (SCNNode *)createShareNode {
    SCNNode *node = [SCNNode node];
    SCNText *text = [SCNText textWithString:@"分享" extrusionDepth:0.01];
    text.font = [UIFont systemFontOfSize:0.13];
    text.firstMaterial.diffuse.contents = UIColor.orangeColor;
    node.geometry = text;
    return node;
}

- (SCNNode *)descriptionNode {
    SCNNode *node = [SCNNode node];
    SCNText *text = [SCNText textWithString:@"aadfasdfasjdbasuidfbaisudbfnasdjkfbasdpkjbfauiehfasdkjbfaskdjfbaasdfasdfjbasdiufbasdkjfbasdfbasiudfbasdjkbfasdjbf啊速度快解放把水地方吧菩萨水电费爱上的看法napUI色部分让五二班飞机123123" extrusionDepth:0.0001];
    text.font = [UIFont systemFontOfSize:0.13];
    text.firstMaterial.diffuse.contents = UIColor.whiteColor;
    node.geometry = text;
    node.scale = SCNVector3Make(0.2, 0.2, 0.2);
    node.name = @"destion";
    return node;
}

- (SCNNode *)createPlayerNode {
    SCNNode * tempNode = [SCNNode new];
    
    CGFloat w = 2;
    CGFloat h = 1;
    SCNBox * box = [SCNBox boxWithWidth:w / 10 height:h / 10 length:0.001 chamferRadius:0];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"freeVideo" withExtension:@"mp4"];
    VideoPlayer *player = [[VideoPlayer alloc] initWithUrl:url];
    [player play];
    
    //    box.firstMaterial.multiply.contents = @"materals.png";
    box.firstMaterial.diffuse.contents = player.scene;
    box.firstMaterial.multiply.intensity = 0.5;
    box.firstMaterial.lightingModelName = SCNLightingModelConstant;
    tempNode.geometry = box;
//    tempNode.eulerAngles = SCNVector3Make(-M_PI/2.0, 0, 0);
    tempNode.opacity = 2;//透明度
    tempNode.name = @"playerNode";
    return tempNode;
}

- (SCNNode *)redBackgroundNode {
    SCNNode *node = [SCNNode node];
    SCNPlane *plane = [SCNPlane planeWithWidth:0.2 height:0.36];
    plane.firstMaterial.diffuse.contents = UIColor.redColor;
    node.geometry = plane;
    node.eulerAngles = SCNVector3Make(M_PI, 0, 0);
    node.position = SCNVector3Make(-0.1, -0, -0.0026);
    return node;
}

- (SCNVector3)getBoundingBox:(SCNNode *)node {
    SCNVector3 min = SCNVector3Zero;
    SCNVector3 max = SCNVector3Zero;
    [node getBoundingBoxMin:&min max:&max];
    
    CGFloat width = max.x - min.x;
    CGFloat height = max.y - min.y;
    CGFloat length = max.z - min.z;
    
    return SCNVector3Make(width, height, length);
}



@end

@implementation ScoreNode

- (instancetype)init {
    self = [super init];
    if (self) {
        self.name = @"score";
        SCNText *geometry = [self createTimeGeometryWithFrame:CGRectMake(0.0f, 0.0f, 1.8f, 1.5f)];
        geometry.alignmentMode = kCAAlignmentRight;
        
        SCNMaterial *mainMaterial = [SCNMaterial new];
        mainMaterial.diffuse.contents = [UIColor blackColor];
        geometry.firstMaterial = mainMaterial;
        self.scale = SCNVector3Make(0.02f, 0.02f, 0.02f);
        [self setGeometry:geometry];
        self.eulerAngles = SCNVector3Make(M_PI, 0, 0);

    }
    return self;
}

- (SCNText *)createTimeGeometryWithFrame:(CGRect)frame {
    SCNText *timeGeometry = [SCNText textWithString:@"猫眼评分" extrusionDepth:0.1f];
    timeGeometry.font = [UIFont systemFontOfSize:0.9f];
    timeGeometry.containerFrame = frame;
    timeGeometry.flatness = 0.005f;
    
    return timeGeometry;
}

@end








