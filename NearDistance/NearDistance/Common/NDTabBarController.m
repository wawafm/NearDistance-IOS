//
//  NDTabBarController.m
//  NearDistance
//
//  Created by wawa on 15/10/8.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDTabBarController.h"
#import "NDButtonView.h"

@interface NDTabBarController ()<buttonViewDelegate>

@property (nonatomic,strong) NDButtonView *tabBarView;

@end

@implementation NDTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    //自定义tabbar的View
    self.tabBarView = [NDButtonView buttonView];
    self.tabBarView.frame =self.tabBar.bounds;
    self.tabBarView.backgroundColor = [UIColor whiteColor];
    //成为代理
    self.tabBarView.delegate = self;
    [self.tabBar addSubview:self.tabBarView];
    
}
#pragma mark -button代理
- (void)clickButtonWithIndex:(NSInteger)index{
    
    self.selectedIndex = index;
    
}

- (void)viewWillAppear:(BOOL)animated{
    //放到系统tabbar的前面
    [self.tabBar bringSubviewToFront:self.tabBarView];
}


@end
