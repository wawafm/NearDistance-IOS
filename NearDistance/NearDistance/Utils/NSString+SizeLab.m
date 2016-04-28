//
//  NSString+SizeLab.m
//  挖哇
//
//  Created by wahua on 14-10-9.
//  Copyright (c) 2014年 谢阳晴. All rights reserved.
//

#import "NSString+SizeLab.h"
#import "UIDevice+Ligs.h"

@implementation NSString (SizeLab)

- (CGSize)heightWithFont:(UIFont* )font width:(CGFloat)width {
    CGRect bounds = CGRectZero;
    
    //UIDevic的类别，用来判断是否是iOS7
    if ([UIDevice isIOS7]) {
        //iOS7计算文字高度的方法。
        bounds = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        
    }else if ([UIDevice isIOS8]){
        
        bounds = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        
    }
    else {
        //iOS6计算文字高度的方法。

        bounds.size = [self sizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT)];
    }
    
    //float，向上取整 :10.3 ===> 11
    return bounds.size;
}
- (NSString*)setCreatedDateFormatAt:(NSString *)createdAt
{
    
    // 2014-09-17 07:11:08
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //时间格式要一侄
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* createdAtDate = [dateFormatter dateFromString:createdAt];
    [dateFormatter setDateFormat:@"MM-dd"];
    
    return [dateFormatter stringFromDate:createdAtDate];
}

@end
