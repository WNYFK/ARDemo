//
//  CBMovieNode.m
//  ARDemo
//
//  Created by ChenBin on 2018/7/3.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

#import "CBMovieNode.h"
#import "VideoPlayer.h"
#import "CBPlaneNode.h"
#import "UIView+DHSmartScreenshot.h"
#import "CBStartNode.h"

@interface CBMovieNode ()

@property (nonatomic, strong) CBMovie *movie;

@end

@implementation CBMovieNode

- (instancetype)initWithMovie:(CBMovie *)movie {
    self = [super init];
    if (self) {
        self.movie = movie;
        [self setup];
    }
    return self;
}

- (void)setup {
    CBPlaneNode *baseNode = [self baseNode];
    [self addChildNode:baseNode];
    
    SCNNode *earthNode = [self earthNode];
    [baseNode addChildNode:earthNode];
    
    SCNNode *startNode = [CBStartNode stars];
    [baseNode addChildNode:startNode];
    
    CBPlaneNode *leftNode = [self leftNode];
    CBPlaneNode *midNode = [self midNode];
    CBPlaneNode *rightNode = [self rightNode];
    
    earthNode.position = SCNVector3Make(-0.12, midNode.height / 2 + 0.1, 0.1);
    startNode.position = SCNVector3Make(-0.1, earthNode.position.y, 0.1);

    midNode.position = SCNVector3Zero;
    leftNode.position = SCNVector3Make(-midNode.width / 2 - 0.01 - leftNode.width / 2, 0, 0);
    rightNode.position = SCNVector3Make(midNode.width / 2 + 0.01 + rightNode.width / 2, 0, 0);

    [baseNode addChildNode:leftNode];
    [baseNode addChildNode:midNode];
    [baseNode addChildNode:rightNode];
    
    SCNCamera *camera = [SCNCamera camera];
    camera.usesOrthographicProjection = YES;
    camera.orthographicScale = 10;
    
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.position = SCNVector3Make(-4, 0, 10);
    [baseNode addChildNode:cameraNode];
    
    SCNNode *lightNode = [SCNNode node];
    SCNLight *light = [SCNLight light];
    light.type = SCNLightTypeOmni;
    lightNode.light = light;
    lightNode.position = cameraNode.position;
    [baseNode addChildNode:lightNode];
}

- (CBPlaneNode *)baseNode {
    CBPlaneNode *node = [CBPlaneNode planeWithWidth:0.6 withHeight:0.6 withMaterialContents:[UIColor.whiteColor colorWithAlphaComponent:0]];
    node.eulerAngles = SCNVector3Make(-M_PI_2, 0, 0);
    return node;
}

- (SCNNode *)earthNode {
    SCNNode *node = [SCNNode node];
    SCNSphere *earth = [SCNSphere sphereWithRadius:0.2];
    earth.firstMaterial.diffuse.contents = @"earth-diffuse.jpg";
    node.geometry = earth;
    
    SCNAction *rotate = [SCNAction repeatActionForever:[SCNAction rotateByX:0 y:2 z:0 duration:1]];
    SCNAction *scale = [SCNAction scaleTo:0.2 duration:1];
    SCNAction *fadeIn = [SCNAction fadeInWithDuration:1];
    SCNAction *group = [SCNAction group:@[scale, fadeIn, rotate]];
    [node runAction:group];
    return node;
}

- (CBPlaneNode *)leftNode {
    CBPlaneNode *node = [CBPlaneNode planeWithWidth:0.2 withHeight:0.6 withMaterialContents:UIColor.clearColor];
    
    //wishnum
    SCNNode *wishNode = [self createTextNodeWithText:[NSString stringWithFormat:@"%@人想看", self.movie.wishNum] withColor:UIColor.whiteColor];
    [node addChildNode:wishNode];
    wishNode.position = SCNVector3Make(-node.width / 2, 0.15, 0.01);
    
    //ticket
    SCNNode *ticketNode = [self createTextNodeWithText:[NSString stringWithFormat:@"票价:%@", self.movie.ticket] withColor:UIColor.greenColor];
    [node addChildNode:ticketNode];
    ticketNode.position = SCNVector3Make(-node.width / 2, 0, 0.01);
    
    //realBox
    SCNNode *realBox = [self createTextNodeWithText:[NSString stringWithFormat:@"总票房:%@",self.movie.realBox] withColor:UIColor.greenColor];
    [node addChildNode:realBox];
    realBox.position = SCNVector3Make(-node.width / 2, -0.15, 0.01);
    node.opacity = 0;
    [node runAction:[SCNAction fadeOpacityTo:1 duration:1]];
    return node;
}

- (SCNNode *)createTextNodeWithText:(NSString *)text withColor:(UIColor *)color {
    SCNNode *wishNode = [SCNNode node];
    SCNText *wishText = [SCNText textWithString:text extrusionDepth:0.01];
    wishText.font = [UIFont systemFontOfSize:0.9];
    wishText.containerFrame = CGRectMake(0, 0, 0.2, 1.8);
    wishText.alignmentMode = kCAAlignmentRight;
    SCNMaterial *material = [SCNMaterial new];
    material.diffuse.contents = color;
    wishText.firstMaterial = material;
    wishNode.geometry = wishText;
    wishNode.scale = SCNVector3Make(0.03, 0.03, 0.03);
    return wishNode;
}

- (CBPlaneNode *)midNode {
    CBPlaneNode *whiteNode = [CBPlaneNode planeWithWidth:0.4 withHeight:0.6 withMaterialContents:UIColor.whiteColor cornerRadius:0.01];
    CBPlaneNode *redNode = [CBPlaneNode planeWithWidth:whiteNode.width - 0.02 withHeight:whiteNode.height - 0.02 withMaterialContents:UIColor.redColor cornerRadius:0.01];
    redNode.position = SCNVector3Make(0, 0, 0.01);
    [whiteNode addChildNode:redNode];
    
    CBPlaneNode *payerNode = [self playerNode];
    [redNode addChildNode:payerNode];
    payerNode.position = SCNVector3Make(0, redNode.height / 2 - payerNode.height / 2, 0.1);
    
    CBPlaneNode *desNode = [self desNode];
    [redNode addChildNode:desNode];
    desNode.position = SCNVector3Make(0, payerNode.position.y - payerNode.height / 2 - desNode.height / 2 - 0.01, 0.01);
    
    CBPlaneNode *shareNode = [self shareNode];
    [redNode addChildNode:shareNode];
    shareNode.position = SCNVector3Make(-redNode.width / 4, desNode.position.y - desNode.height / 2 - shareNode.height / 2 - 0.02, 0.01);
    shareNode.callback = ^{
        [self alertWithMsg:@"您点击了“分享按钮"];
    };
    
    CBPlaneNode *collectNode = [self collectNode];
    [redNode addChildNode:collectNode];
    collectNode.position = SCNVector3Make(redNode.width / 4, shareNode.position.y, 0.01);
    collectNode.callback = ^{
        [self alertWithMsg:@"点击了”收藏按钮"];
    };
    return whiteNode;
}

- (void)alertWithMsg:(NSString *)msg {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"点击提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self.curVC presentViewController:alertVC animated:YES completion:nil];
}

- (CBPlaneNode *)desNode {
    __block UIImage *img;
    dispatch_sync(dispatch_get_main_queue(), ^{
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
        label.numberOfLines = 10;
        label.text = self.movie.desStr;
        label.font = [UIFont systemFontOfSize:20];
        label.textColor = [UIColor.whiteColor colorWithAlphaComponent:0.7];
        label.backgroundColor = UIColor.clearColor;
        [label sizeToFit];
        [label setNeedsLayout];
        img = [label screenshot];
    });

    return [CBPlaneNode planeWithWidth:0.36 withHeight:0.36 / img.size.width * img.size.height withMaterialContents:img];
}

- (CBPlaneNode *)shareNode {
    CBPlaneNode *node = [CBPlaneNode planeWithWidth:0.1 withHeight:0.1 withMaterialContents:[UIImage imageNamed:@"icon_share"]];
    node.name = kNodeShareName;
    return node;
}

- (CBPlaneNode *)collectNode {
    CBPlaneNode *node = [CBPlaneNode planeWithWidth:0.1 withHeight:0.1 withMaterialContents:[UIImage imageNamed:@"icon_collect"]];
    node.name = kNodeCollectName;
    return node;
}

- (CBPlaneNode *)playerNode {
    CBPlaneNode *node = [CBPlaneNode planeWithWidth:0.3 withHeight:0.15 withMaterialContents:UIColor.whiteColor];
    
    SCNNode * tempNode = [SCNNode new];
    SCNBox * box = [SCNBox boxWithWidth:node.width - 0.02 height:node.height - 0.01 length:0.02 chamferRadius:0];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"freeVideo" withExtension:@"mp4"];
    VideoPlayer *player = [[VideoPlayer alloc] initWithUrl:url];
    [player play];
    SCNMaterial *playerMaterial = [SCNMaterial material];
    playerMaterial.diffuse.contents = player.scene;
    SCNMaterial *lightMaterial = [SCNMaterial material];
    lightMaterial.diffuse.contents = UIColor.whiteColor;
    lightMaterial.lightingModelName = SCNLightingModelConstant;
    box.materials = @[playerMaterial, lightMaterial, lightMaterial, lightMaterial, lightMaterial, lightMaterial];
    box.firstMaterial.multiply.intensity = 0.5;
    box.firstMaterial.lightingModelName = SCNLightingModelConstant;
    tempNode.geometry = box;
    tempNode.name = @"playerNode";
    tempNode.position = SCNVector3Make(0.005, 0, 0.01);
    node.rotation = SCNVector4Make(0, 0, -0.1, 0);
    [node addChildNode:tempNode];
    return node;
}

- (CBPlaneNode *)rightNode {
    CBPlaneNode *node = [CBPlaneNode planeWithWidth:0.3 withHeight:0.6 withMaterialContents:UIColor.clearColor];

    //top
    CBPlaneNode *topNode = [CBPlaneNode planeWithWidth:node.width withHeight:0.25 withMaterialContents:UIColor.whiteColor cornerRadius:0.01];
    topNode.position = SCNVector3Make(0, node.height / 2 - topNode.height / 2, 0.01);
    CBPlaneNode *topImgNode = [CBPlaneNode planeWithWidth:topNode.width - 0.01 withHeight:topNode.height - 0.01 withMaterialContents:self.movie.rightTopImg];
    [topNode addChildNode:topImgNode];
    topImgNode.position = SCNVector3Make(0, 0, 0.01);
    [node addChildNode:topNode];
    
    CBPlaneNode *bottomNode = [CBPlaneNode planeWithWidth:node.width withHeight:0.25 withMaterialContents:UIColor.whiteColor cornerRadius:0.01];
    bottomNode.position = SCNVector3Make(0, node.height / 2 - bottomNode.height - 0.2, 0.01);
    CBPlaneNode *bottomImgNode = [CBPlaneNode planeWithWidth:bottomNode.width - 0.01 withHeight:bottomNode.height - 0.01 withMaterialContents:self.movie.rightBottomImg];
    [bottomNode addChildNode:bottomImgNode];
    bottomImgNode.position = SCNVector3Make(0, 0, 0.01);
    [node addChildNode:bottomNode];
    return node;
}

@end

@implementation CBMovie
@end
