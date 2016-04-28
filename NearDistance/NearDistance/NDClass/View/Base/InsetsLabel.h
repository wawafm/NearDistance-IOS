//
//  InsetsLabel.h
//  music
//
//  Created by 李世超 on 15/2/12.
//  Copyright (c) 2015年 李世超. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum VerticalAlignment {
    VerticalAlignmentTop,
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface InsetsLabel : UILabel
{
    @private VerticalAlignment verticalAlignment_;
}

@property (nonatomic, assign) VerticalAlignment verticalAlignment;
@end
