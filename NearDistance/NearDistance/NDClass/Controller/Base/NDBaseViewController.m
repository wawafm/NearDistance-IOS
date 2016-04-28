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
    
    self.navigationController.navigationBar.shadowImage = [UIImage imageWithColor:kUIColorFromAlphaRGB(MAIN_COLOR) size:CGSizeMake(ScreenWidth, 0.3)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //顶格
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - 导航栏返回
- (void)navigationBackView
{
    NSArray *viewController = self.navigationController.viewControllers;
    if (viewController.count > 1 && self.isBackButton) {

      UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
      button.frame = CGRectMake(0, 0, STATUSWIDHT, HOME_BUTTONY_SPACE);
      button.imageEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
      [button setImage:[UIImage imageNamed:NAVIGATIONBAR_BACK_IMG]
              forState:UIControlStateNormal];
      [button setImage:[UIImage imageNamed:NAVIGATIONBAR_BACK_IMG]
              forState:UIControlStateHighlighted];
      button.userInteractionEnabled = YES;
      button.imageView.contentMode = UIViewContentModeScaleAspectFit;
      button.titleEdgeInsets = UIEdgeInsetsMake(0, -33, 0, 0);
      [button setTitleColor:kUIColorFromRGB(GRAY_COLOR)
                   forState:UIControlStateNormal];
      [button setTitle:@"返回" forState:UIControlStateNormal];
      button.titleLabel.font = FONG_14; //
      button.showsTouchWhenHighlighted = YES;
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
    labelTitle.textColor          = kUIColorFromRGB(BLACK_COLOR);
    labelTitle.font               = FONG_16;
    labelTitle.backgroundColor    = [UIColor clearColor];
    labelTitle.text               = title;
    [labelTitle sizeToFit];
    self.navigationItem.titleView = labelTitle;
}

#pragma mark - override 设置导航栏图片
- (void) setNavigationImg:(UIImage *)image
{
    UIImageView *imageView        = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.frame               = CGRectMake(0, 0, WIDHT_SPACE, 15);
    imageView.backgroundColor     = [UIColor clearColor];
    imageView.contentMode         = UIViewContentModeScaleAspectFit;
    imageView.image               = image;
    self.navigationItem.titleView = imageView;
}

#pragma mark - 导航栏左侧视图
- (void)setNavigationLeft:(NSString *)title
{
    self.logoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.logoButton.frame = CGRectMake(STATUSHEIGHT, STATUSHEIGHT, 120, IP5TARBBARHEIGHT);
    [self.logoButton setImage:[UIImage imageNamed:NAVIGATIONBAR_LOGO_IMG] forState:UIControlStateNormal];
    self.logoButton.userInteractionEnabled = NO;
    self.logoButton.titleEdgeInsets = UIEdgeInsetsMake(2, LEFT_BIG_MARGIN, 0, 0);
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
