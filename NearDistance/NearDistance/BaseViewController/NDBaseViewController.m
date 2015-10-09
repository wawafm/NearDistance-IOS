//
//  NDBascViewController.m
//  NearDistance
//
//  Created by wawa on 15/10/8.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseViewController.h"

@interface NDBaseViewController ()

@end

@implementation NDBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.isBackButton = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationBackView];
    //设置背景（测试用）
//    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
    //顶格
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - 导航栏返回
- (void)navigationBackView
{
    NSArray *viewController = self.navigationController.viewControllers;
    if (viewController.count > 1 && self.isBackButton) {

      UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
      button.imageEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
      [button setImage:[UIImage imageNamed:NAVIGATIONBAR_BACK_IMG]
              forState:UIControlStateNormal];
      [button setImage:[UIImage imageNamed:NAVIGATIONBAR_BACK_IMG]
              forState:UIControlStateHighlighted];
      button.userInteractionEnabled = YES;
      button.imageView.contentMode = UIViewContentModeScaleAspectFit;
      button.titleEdgeInsets = UIEdgeInsetsMake(0, -33, 0, 0);
      [button setTitleColor:kUIColorFromRGB(0x898989)
                   forState:UIControlStateNormal];
      [button setTitle:@"返回" forState:UIControlStateNormal];
      button.titleLabel.font = [UIFont systemFontOfSize:14.0f]; //
      button.showsTouchWhenHighlighted = YES;
      button.frame = CGRectMake(0, 0, 45, 25);
      [button addTarget:self
                    action:@selector(backAction)
          forControlEvents:UIControlEventTouchUpInside];

      UIBarButtonItem *backItem =
          [[UIBarButtonItem alloc] initWithCustomView:button];
      self.navigationItem.leftBarButtonItem = backItem;
    }
}

#pragma mark - override 设置导航栏字体的属性
- (void) setNavigationTitle:(NSString *)title
{
    UILabel *labelTitle           = [[UILabel alloc] initWithFrame:CGRectZero];
    labelTitle.textColor          = kUIColorFromRGB(0x828282);
    labelTitle.font               = [UIFont systemFontOfSize:16.0f];
    labelTitle.backgroundColor    = [UIColor clearColor];
    labelTitle.text               = title;
    [labelTitle sizeToFit];
    self.navigationItem.titleView = labelTitle;
}

#pragma mark - override 设置导航栏图片
- (void) setNavigationImg:(UIImage *)image
{
    UIImageView *imageView        = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.frame               = CGRectMake(0, 0, 60, 15);
    imageView.backgroundColor     = [UIColor clearColor];
    imageView.contentMode         = UIViewContentModeScaleAspectFit;
    imageView.image               = image;
    self.navigationItem.titleView = imageView;
}

#pragma mark - 导航栏左侧视图
- (void)setNavigationLeft:(NSString *)title
{
    self.logoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.logoButton.frame = CGRectMake(20, 20, 120, 44);
    [self.logoButton setImage:[UIImage imageNamed:NAVIGATIONBAR_LOGO_IMG] forState:UIControlStateNormal];
    self.logoButton.titleEdgeInsets = UIEdgeInsetsMake(2, 10, 0, 0);
    [self.logoButton setTitleColor:kUIColorFromRGB(MAIN_COLOR) forState:UIControlStateNormal];
    [self.logoButton setTitle:title forState:UIControlStateNormal];
    self.logoButton.contentHorizontalAlignment = 1;
    UIBarButtonItem *logonItem =
    [[UIBarButtonItem alloc] initWithCustomView:_logoButton];
    self.navigationItem.leftBarButtonItem = logonItem;
}

#pragma mark -actions
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
