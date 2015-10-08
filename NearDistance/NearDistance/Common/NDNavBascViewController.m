//
//  NDNavBascViewController.m
//  NearDistance
//
//  Created by wawa on 15/10/8.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDNavBascViewController.h"



#define kUINavHeigh 72

@interface NDNavBascViewController ()

@end

@implementation NDNavBascViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //自定义导航条
    self.navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, kUINavHeigh)];
    self.navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.navView];
    
    //自定义返回按钮
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.frame = CGRectMake(20, 20, 120, 44);
    [self.leftButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.leftButton setImage:[UIImage imageNamed:@"shouye-logo"] forState:UIControlStateNormal];
    [self.leftButton setTitle:@"" forState:UIControlStateNormal];
    self.leftButton.contentHorizontalAlignment = 1;
    //136 197 38
    
    [self.leftButton setTitleColor:[UIColor colorWithRed:136/255.0 green:197/255.0 blue:38/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self.navView addSubview:self.leftButton];
    
    
    // 添加标题
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake( 90, 20, 180, 44)];
    self.titleLabel.text = @"首页";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.navView addSubview:self.titleLabel];
    
    
    //添加右边按钮
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.backgroundColor = [UIColor clearColor];
    self.rightButton.frame = CGRectMake(kUIScreenWidth - 44, 20, 44, 44);
    [self.navView addSubview:self.rightButton];

    
}


//监听返回按钮
- (void)backMethod{
    
    NSLog(@"点击了返回按钮");
}

@end
