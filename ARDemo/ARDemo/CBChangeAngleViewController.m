//
//  CBChangeAngleViewController.m
//  ARDemo
//
//  Created by ChenBin on 2018/7/6.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

#import "CBChangeAngleViewController.h"
#import <ARKit/ARKit.h>

@interface CBChangeAngleViewController ()

@property (nonatomic, strong) ARSCNView *scnView;

@end

@implementation CBChangeAngleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scnView = [[ARSCNView alloc] initWithFrame:self.view.bounds options:@{SCNPreferLowPowerDeviceKey: @(YES)}];
    self.scnView.scene = [SCNScene scene];
    self.scnView.backgroundColor = [UIColor blackColor];
}

- (void)createSunNode {
    SCNNode *sunNode = [SCNNode node];
    sunNode.geometry = [SCNSphere sphereWithRadius:3];
    
}

@end
