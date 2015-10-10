//
//  NDBascViewController.h
//  NearDistance
//
//  Created by wawa on 15/10/8.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NDBaseViewController : UIViewController

@property(nonatomic, assign) BOOL isRightButton;
@property(nonatomic, assign) BOOL isBackButton;

//导航条
@property (nonatomic, strong) UIView *navView;
//标题logo按钮
@property (nonatomic, strong) UIButton *logoButton;

- (void)setNavigationTitle:(NSString *)title;
- (void)setNavigationLeft:(NSString *)title;
- (void)setNavigationImg:(UIImage *)image;

@end
