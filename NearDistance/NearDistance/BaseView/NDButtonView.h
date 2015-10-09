//
//  NDButtonView.h
//  NearDistance
//
//  Created by wawa on 15/10/8.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol buttonViewDelegate;

#pragma mark -
@interface NDButtonView : UIView

//代理属性
@property (nonatomic,weak) id<buttonViewDelegate> delegate;

+ (instancetype)buttonView;

@end

#pragma mark - 协议
@protocol buttonViewDelegate <NSObject>
@optional
- (void)clickButtonWithIndex:(NSInteger)index;

@end

