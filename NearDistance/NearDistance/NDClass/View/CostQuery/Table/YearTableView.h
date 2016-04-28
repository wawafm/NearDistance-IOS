//
//  YearTableView.h
//  NearDistance
//
//  Created by 李世超 on 15/10/16.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseTableView.h"
#import "YearCell.h"
#import "CostQueryModel.h"

@protocol YearDelegate <NSObject>

- (void)dismissYearView;

@end
@interface YearTableView : NDBaseTableView

@property (nonatomic,retain) CostQueryModel *costModel;
@property (nonatomic ,assign) id<YearDelegate>yearDelegate;

@property (nonatomic,retain) NSMutableArray *costArray;
@property (nonatomic,assign) BOOL isMonth;
@property (nonatomic,retain) YearCell *yearCell;
@end
