//
//  MyTableView.h
//  NearDistance
//
//  Created by 李世超 on 15/10/14.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseTableView.h"
#import "MyTableViewCell.h"
#import "MyHeaderView.h"
#import "MemberInfoModel.h"

@protocol MyTableDelegate <NSObject>

- (void)clickIndexPath:(NSInteger)index;
@end
@interface MyTableView : NDBaseTableView
@property (nonatomic,retain) MemberInfoModel *memberModel;
@property (nonatomic,retain) NSString *isBind;
@property (nonatomic, retain) MyHeaderView *headerView;
@property (nonatomic,retain) MyTableViewCell *myTableCell;

@property (nonatomic ,assign) id<MyTableDelegate>myTabelDelegate;

@end
