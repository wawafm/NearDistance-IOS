//
//  BlockButton.h
//  NearDistance
//
//  Created by 李世超 on 15/10/23.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BlockButton;
typedef void (^TouchButton)(BlockButton*);


@interface BlockButton : UIButton

- (id)initWithFrame:(CGRect)frame title:(NSString *)title;

@property(nonatomic,copy)TouchButton block;

@end
