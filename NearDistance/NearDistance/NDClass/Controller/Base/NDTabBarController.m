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
#import "NDLoginViewController.h"

@interface NDTabBarController ()<buttonViewDelegate>

@property (nonatomic,strong) NDButtonView *tabBarView;

@end

@implementation NDTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //隐藏TabBar
        [self.tabBar setHidden:YES];
        [NSNOTIFICATION addObserver:self selector:@selector(isShowTabbar:) name:@"hide_tabbar" object:nil];
    }
    return self;
}

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
    self.tabBarView.frame = CGRectMake(0, ScreenHeight-TABBAR_HEIGHTG,ScreenWidth, TABBAR_HEIGHTG);
    self.tabBarView.backgroundColor = [UIColor whiteColor];
    //成为代理
    self.tabBarView.delegate = self;
    _lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.3)];
    _lineLabel.backgroundColor = kUIColorFromAlphaRGB(MAIN_COLOR);
    [self.tabBarView addSubview:_lineLabel];
    [self.view addSubview:self.tabBarView];
}

#pragma mark -button代理
- (void)clickButtonWithIndex:(NSInteger)index{
    
    self.selectedIndex = index;
}

#pragma mark UINavigationController delegate
//监听五个导航控制器的push事件
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //导航控制器子控制器的个数
    NSInteger count = navigationController.viewControllers.count;
    if (count == 2) {
        [self showTabbar:NO];
    }else if(count == 1){
        [self showTabbar:YES];
    }
}

#pragma mark - 是否显示TabBar
- (void)showTabbar:(BOOL)show
{
    [UIView animateWithDuration:0.30 animations:^{
        if (show) {
            self.tabBarView.bottom = ScreenHeight;
        }else{
            self.tabBarView.bottom = ScreenHeight+TABBAR_HEIGHTG;
        }
    }];
    
    [self _resizeView:show];
}

#pragma mark - ui 私有的方法-初始化子控制器
- (void)_resizeView:(BOOL)showTarbar
{
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITransitionView")]) {
            if (showTarbar) {
                subView.height = ScreenHeight;
            }else{
                subView.height = ScreenHeight+TABBAR_HEIGHTG;
            }
        }
    }
}

#pragma mark - 是否显示tabbar notificaiton
- (void)isShowTabbar:(NSNotification *)notification
{
    NSString *isShow = [notification object];
    if ([isShow isEqualToString:@"hideTabbar"]) {
        [self showTabbar:NO];
    }else{
        [self showTabbar:YES];
    }
}

@end
