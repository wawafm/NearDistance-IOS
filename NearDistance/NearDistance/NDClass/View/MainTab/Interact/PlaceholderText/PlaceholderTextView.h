//
//  PlaceholderTextView.h
//  NearDistance
//
//  Created by 李世超 on 15/10/10.
//  Copyright (c) 2015年 李世超. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  要是用非 arc。。。。。。／／     -fno-objc-arc
 */
@interface PlaceholderTextView : UITextView

@property(copy,nonatomic) NSString *placeholder;
@property(strong,nonatomic) UIColor *placeholderColor;
@property(strong,nonatomic) UIFont * placeholderFont;
@end
