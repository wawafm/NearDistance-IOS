//
//  LLARingSpinnerView.h
//  NearDistance
//
//  Created by wawa on 15/04/14.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLARingSpinnerView : UIView

@property (nonatomic, readonly) BOOL isAnimating;
@property (nonatomic) CGFloat lineWidth;

- (void)startAnimating;
- (void)stopAnimating;

@end
