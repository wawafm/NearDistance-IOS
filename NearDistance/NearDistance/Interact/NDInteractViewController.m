//
//  NDInteractViewController.m
//  NearDistance
//
//  Created by wawa on 15/10/8.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDInteractViewController.h"
#import "PublishTopicViewController.h"

@interface NDInteractViewController ()

@end

@implementation NDInteractViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super setNavigationLeft:@"邻居圈"];
    [self _initNavBarRight];
}

#pragma mark - 初始化右侧视图
- (void)_initNavBarRight
{
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame = CGRectMake(0, 0, 100, 64);
    [self.rightButton setImage:[UIImage imageNamed:NAVIGATIONBAR_PUBLISH_IMG] forState:UIControlStateNormal];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    self.rightButton.titleEdgeInsets = UIEdgeInsetsMake(2, 10, 0, 0);
    [self.rightButton setTitleColor:kUIColorFromRGB(MAIN_COLOR) forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(publishTopic:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton setTitle:@"发布新话题" forState:UIControlStateNormal];
    self.rightButton.contentHorizontalAlignment = 1;
    UIBarButtonItem *logonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    self.navigationItem.rightBarButtonItem = logonItem;
}

#pragma mark - 发布话题action
- (void)publishTopic:(UIButton *)sender
{
    PublishTopicViewController *publishTop = [[PublishTopicViewController alloc] init];
    [self.navigationController pushViewController:publishTop animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
