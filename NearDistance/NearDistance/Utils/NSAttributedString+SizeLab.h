//
//  NSAttributedString+SizeLab.h
//  NearDistance
//
//  Created by 李世超 on 15/10/28.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (SizeLab)

/**
 *  计算一个字符串在限定的宽度和字体下的长度
 *
 *  @param font  限定的字体
 *  @param width 限定的宽度
 *
 *  @return 字符串的长度
 */

- (CGSize)heightWithLabelWidth:(CGFloat)width;
- (NSString*)setCreatedDateFormatAt:(NSString *)createdAt;
@end
