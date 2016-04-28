//
//  SJAvatarBrowser.m
//  zhitu
//
//  Created by 李世超 on 13-11-1.
//  Copyright (c) 2013年 李世超. All rights reserved.
//

#import "SJAvatarBrowser.h"

static SJAvatarBrowser *singleton;

static CGRect oldframe;
@implementation SJAvatarBrowser

+ (id)shareInstance
{
    if (singleton == nil) {
        singleton = [[[self class] alloc] init];
    }
    return singleton;
}

#pragma mark - 放大图片
- (void)showImage:(UIImageView *)avatarImageView{
    
    UIImage *image = avatarImageView.image;
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    
    oldframe=[avatarImageView convertRect:avatarImageView.bounds toView:window];
    
    photoView = [[VIPhotoView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) andImage:image];
    photoView.backgroundColor=[UIColor blackColor];
//    photoView.userInteractionEnabled = YES;
    photoView.alpha = 0;
//    photoView.autoresizingMask = (1 << 6) -1;
    [window addSubview:photoView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [photoView addGestureRecognizer:tap];
//
    [UIView animateWithDuration:0.3 animations:^{
        photoView.alpha = 1;
    } completion:^(BOOL finished) {
        //显示状态栏
        [UIApplication sharedApplication].statusBarHidden = YES;
    }];
}

- (void)hideImage:(UITapGestureRecognizer*)tap{
    UIView *view = tap.view;
    [UIView animateWithDuration:0.3 animations:^{
//        imageView.frame = oldframe;
        photoView.alpha=0;
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
    }];
    //显示状态栏
    [UIApplication sharedApplication].statusBarHidden = NO;
}
@end
