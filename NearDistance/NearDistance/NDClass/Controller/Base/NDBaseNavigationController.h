//
//  BaseNavigationController.h
//  NearDistance
//
//  Created by 李世超 on 14-1-16.
//  Copyright (c) 2014年 李世超. All rights reserved.
//

#import <UIKit/UIKit.h>
#define KEY_WINDOW  [[UIApplication sharedApplication]keyWindow]

#define iOS7  ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )

#define startX -200;

@interface NDBaseNavigationController : UINavigationController
{
    BOOL animating;
    
    CGFloat startBackViewX;
    BOOL firstTouch;
}
// Enable the drag to back interaction, Defalt is YES.
@property (nonatomic,assign) BOOL canDragBack;

@end
