//
//  NSAttributedString+SizeLab.m
//  NearDistance
//
//  Created by 李世超 on 15/10/28.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NSAttributedString+SizeLab.h"
#import "UIDevice+Ligs.h"

@implementation NSAttributedString (SizeLab)

- (CGSize)heightWithLabelWidth:(CGFloat)width {
    CGRect bounds = CGRectZero;
    
    //UIDevic的类别，用来判断是否是iOS7
    if ([UIDevice isIOS7]) {
        //iOS7计算文字高度的方法。
//        bounds = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        bounds = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin context:nil];
        
    }else if ([UIDevice isIOS8]){
        
        bounds = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin context:nil];
        
    }
    else {
        //iOS6计算文字高度的方法。
        
//        bounds.size = [self sizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT)];
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
