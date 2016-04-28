//
//  CommonViews.h
//  NearDistance
//
//  Created by 李世超 on 15/10/28.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TYDotIndicatorView.h"
#import "HYActivityView.h"
#import "HyLoglnButton.h"

@interface CommonViews : NSObject
{
    TYDotIndicatorView  *darckCircleDot;
    NSData              *imageData;
    
    HYActivityView      *activityView;
}
+ (id)shareInstance;


-(TYDotIndicatorView *)darckCircleDot:(CGFloat)pointY view:(UIView *)view;

- (void)stopHideAnimating;

- (void)startShowAnimating;

- (NSData *) saveImage:(UIImage *)currentImage withName:(NSString *)imageName;

- (HYActivityView *)activityView:(UIView *)view title:(NSString *)title;

- (UIImagePickerController *)photoCarmer;

- (HyLoglnButton *)buttonView:(UIView *)view frame:(CGRect)frame;

- (BOOL)textField:(UITextField *)textField string:(NSString *)string view:(UIView *)view range:(NSRange)range;

- (void)isAutoLayout:(UIView *)loginView regView:(UIView *)regView codeView:(UIButton *)codeView;

@end
