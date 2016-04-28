//
//  BlockButton.m
//  NearDistance
//
//  Created by 李世超 on 15/10/23.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "BlockButton.h"

@implementation BlockButton

- (id)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        if ([title isEqualToString:@"返回"]) {
            [self setImage:[UIImage imageNamed:LOGIN_BACK_IMG] forState:UIControlStateNormal];
            [self imgTitleEdgeInsets];
            [self setTitleColor:kUIColorFromRGB(WHITE) forState:UIControlStateNormal];
            self.titleLabel.font = FONG_14;
            [self setTitle:title forState:UIControlStateNormal];
        }else if([title isEqualToString:@"发布新话题"]){
            [self setImage:[UIImage imageNamed:NAVIGATIONBAR_PUBLISH_IMG] forState:UIControlStateNormal];
            self.titleLabel.font = FONG_13;
            self.titleEdgeInsets = UIEdgeInsetsMake(2, 10, 0, 0);
            [self setTitleColor:kUIColorFromRGB(MAIN_COLOR) forState:UIControlStateNormal];
            [self setTitle:title forState:UIControlStateNormal];
        }else if([title isEqualToString:@"public"]){
            [self imgTitleEdgeInsets];
            [self setImage:[UIImage imageNamed:NAVIGATIONBAR_BACK_IMG] forState:UIControlStateNormal];
            [self setTitleColor:kUIColorFromRGB(GRAY_COLOR) forState:UIControlStateNormal];
            self.titleLabel.font = FONG_14;
            [self setTitle:@"返回" forState:UIControlStateNormal];
        }else{
            self.titleLabel.font = FONG_14;
            [self setTitleColor:kUIColorFromRGB(GRAY_COLOR) forState:UIControlStateNormal];
            [self setTitle:title forState:UIControlStateNormal];
            [self setTitle:@"完成" forState:UIControlStateSelected];
        }
        self.showsTouchWhenHighlighted = YES;
        [self addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)imgTitleEdgeInsets
{
    self.imageEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -33, 0, 0);
}

- (void)touchAction:(id)sender{
    _block(self);
}

@end
