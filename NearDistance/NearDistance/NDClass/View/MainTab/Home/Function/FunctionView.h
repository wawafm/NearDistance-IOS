//
//  FunctionView.h
//  NearDistance
//
//  Created by 李世超 on 15/10/10.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YearTableView.h"

@interface FunctionView : UIView<YearDelegate>

@property (nonatomic,strong) NSString *dismissTag;
@property (nonatomic,retain) YearTableView *yearTable;
@property (strong, nonatomic) UIButton *funButton;
@property (strong, nonatomic) UILabel  *titleLabel;
@property (strong, nonatomic) UILabel  *lineLabel;
@property (strong, nonatomic) UILabel  *colorLabel;
@property (strong, nonatomic) UILabel  *todayTitleLabel;
@property (strong, nonatomic) NSArray *images;   //图片的数组
@property (strong, nonatomic) NSArray *titles;   //标题的数组
- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images titles:(NSArray *)titles;
@end
