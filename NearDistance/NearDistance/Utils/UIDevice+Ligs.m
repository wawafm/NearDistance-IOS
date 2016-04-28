//
//  UIDevice+Ligs.m
//  挖哇
//
//  Created by wahua on 14-10-9.
//  Copyright (c) 2014年 谢阳晴. All rights reserved.
//

#import "UIDevice+Ligs.h"

@implementation UIDevice (Ligs)

#pragma mark - Public
+ (BOOL)isIOS6 {
    static BOOL isIOS6 = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isIOS6 = [[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0f;
    });
    
    return isIOS6;
}
+ (BOOL)isIOS7 {
    static BOOL isIOS7 = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isIOS7 = [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f;
    });

    return isIOS7;
}
+ (BOOL)isIOS8 {
    static BOOL isIOS8 = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isIOS8 = [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f;
    });
    
    return isIOS8;
}

@end
