//
//  NDTabBarController.m
//  NearDistance
//
//  Created by wawa on 15/10/8.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDTabBarController.h"
#import "NDButtonView.h"
#import "NDHomeViewController.h"
#import "NDInteractViewController.h"
#import "NDDistrictViewController.h"
#import "NDMyViewController.h"
#import "NDBaseNavigationController.h"

@interface NDTabBarController ()<buttonViewDelegate>

@property (nonatomic,strong) NDButtonView *tabBarView;

@end

@implementation NDTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customTabBar];
    [self _initViews];
}

#pragma mark - ui 初始化控制器
- (void)_initViews
{
    NDHomeViewController *homeCtrl = [[NDHomeViewController alloc] init];
    NDInteractViewController *interactCtrl = [[NDInteractViewController alloc] init];
    NDDistrictViewController *districtCtrl = [[NDDistrictViewController alloc] init];
    NDMyViewController *myCtrl = [[NDMyViewController alloc] init];
    
    NSArray *arrayViews = @[homeCtrl,interactCtrl,districtCtrl,myCtrl];
    
    viewControllers = [NSMutableArray arrayWithCapacity:4];
    for (UIViewController *viewController in arrayViews) {
        NDBaseNavigationController *baseNav = [[NDBaseNavigationController alloc] initWithRootViewController:viewController];
        [viewControllers addObject:baseNav];
        baseNav.delegate = self;
    }
    self.viewControllers = viewControllers;
}

#pragma mark - 自定义tabbar的View
- (void)customTabBar
{
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
