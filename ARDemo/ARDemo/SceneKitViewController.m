//
//  SceneKitViewController.m
//  ARDemo
//
//  Created by chenbin on 2018/6/30.
//  Copyright © 2018年 ChenBin. All rights reserved.
//

#import "SceneKitViewController.h"
#import "CBAction.h"
#import "PlaneViewController.h"

@interface SceneKitViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<CBAction *> *dataArr;


@end

@implementation SceneKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    self.dataArr = [NSMutableArray array];
    
    //plane
    [self.dataArr addObject:[CBAction actionWithTitle:@"SCNPlane" callback:^{
        [self.navigationController pushViewController:[PlaneViewController new] animated:YES];
    }]];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentidier = @"cellItsaa";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentidier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentidier];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    cell.textLabel.text = self.dataArr[indexPath.row].title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.dataArr[indexPath.row].callback();
}

- (void)addPlane {
    
}






@end
