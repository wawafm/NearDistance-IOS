//
//  SJAvatarBrowser.h
//  zhitu
//
//  Created by 李世超 on 13-11-1.
//  Copyright (c) 2013年 李世超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VIPhotoView.h"

@interface SJAvatarBrowser : NSObject<UIGestureRecognizerDelegate>
{
    CGFloat lastScale;
    
    UIView *backgroundView;
    
    UIImageView *imageView;
    
    VIPhotoView *photoView;
}

+ (id)shareInstance;
/**
 *	@brief	浏览头像
 *
 *	@param 	oldImageView 	头像所在的imageView
 */

-(void)showImage:(UIImageView*)avatarImageView;

@end
