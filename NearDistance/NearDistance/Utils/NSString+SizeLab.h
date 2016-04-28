//
//  NSString+SizeLab.h
//  挖哇
//
//  Created by wahua on 14-10-9.
//  Copyright (c) 2014年 谢阳晴. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SizeLab)
/**
 *  计算一个字符串在限定的宽度和字体下的长度
 *
 *  @param font  限定的字体
 *  @param width 限定的宽度
 *
 *  @return 字符串的长度
 */

- (CGSize)heightWithFont:(UIFont* )font width:(CGFloat)width;
- (NSString*)setCreatedDateFormatAt:(NSString *)createdAt;

@end
