//
//  NDNavBascViewController.h
//  NearDistance
//
//  Created by wawa on 15/10/8.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBascViewController.h"

@interface NDNavBascViewController : NDBascViewController

//导航条
@property (nonatomic, strong) UIView *navView;
//返回按钮
@property (nonatomic, strong) UIButton *leftButton;
//主题
@property (nonatomic, strong) UILabel *titleLabel;
//右边按钮
@property (nonatomic, strong) UIButton *rightButton;

//返回方法
- (void)backMethod;

@end
