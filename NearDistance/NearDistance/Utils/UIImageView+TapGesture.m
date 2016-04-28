//
//  UIImageView+TapGesture.m
//  NearDistance
//
//  Created by 李世超 on 15/10/12.
//  Copyright (c) 2015年 李世超. All rights reserved.
//

#import "UIImageView+TapGesture.h"

static tapGestureBlock _tapBlock;
@implementation UIImageView (TapGesture)

- (void)addTapGesture:(tapGestureBlock)tapBlock
{
    _tapBlock = [tapBlock copy];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:recognizer];
}

- (void)imageViewTap
{
    _tapBlock(self);
}

@end
