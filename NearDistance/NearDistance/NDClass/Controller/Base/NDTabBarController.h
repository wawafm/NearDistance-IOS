//
//  NDTabBarController.h
//  NearDistance
//
//  Created by wawa on 15/10/8.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NDTabBarController : UITabBarController<UINavigationControllerDelegate>
{
    NSMutableArray *viewControllers;
}
- (void)showTabbar:(BOOL)show;
@property (nonatomic,strong) UILabel *lineLabel;
@end
