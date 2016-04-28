//
//  UIImageView+TapGesture.h
//  NearDistance
//
//  Created by 李世超 on 15/10/12.
//  Copyright (c) 2015年 李世超. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^tapGestureBlock)(UIImageView *imageView);

@interface UIImageView (TapGesture)

- (void)addTapGesture:(tapGestureBlock)tapBlock;

@end
