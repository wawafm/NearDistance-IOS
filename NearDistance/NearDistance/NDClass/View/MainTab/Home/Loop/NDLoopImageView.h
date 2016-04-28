//
//  NDLoopImageView.h
//  NearDistance
//
//  Created by 李世超 on 15/10/10.
//  Copyright (c) 2015年 李世超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdvertisModel.h"

@interface NDLoopImageView : UIView

@property (nonatomic,retain) AdvertisModel *advertisModel;
@property (assign, nonatomic) int bannerCount;   // 多少个Imgae循环滚动，默认为2
@property (strong, nonatomic) NSArray *images;   // 滚动图片的数组

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images;
- (void)steup;

@end
