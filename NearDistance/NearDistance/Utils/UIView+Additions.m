//
//  UIView+Additions.m
//  Wawa
//
//  Created by WAWA on 14-12-30.
//  Copyright (c) 2014年 李世超. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)

- (UIViewController *)viewController
{
    //事件响应链 下一个响应者
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
           return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);

    return nil;
}
@end
