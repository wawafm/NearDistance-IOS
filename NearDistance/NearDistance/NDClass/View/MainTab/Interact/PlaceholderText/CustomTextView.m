//
//  CustomTextView.m
//  music
//
//  Created by 李世超 on 15/8/24.
//  Copyright (c) 2015年 李世超. All rights reserved.
//

#import "CustomTextView.h"

@implementation CustomTextView

//光标高度
- (CGRect)caretRectForPosition:(UITextPosition *)position {
    CGRect originalRect = [super caretRectForPosition:position];
    originalRect.size.height = 18.;
    return originalRect;
}

@end
