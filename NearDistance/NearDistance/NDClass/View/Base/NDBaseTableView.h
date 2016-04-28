//
//  BaseTableView.h
//  AutoParts
//
//  Created by 李世超 on 14-1-16.
//  Copyright (c) 2014年 李世超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NDBaseTableView : UITableView <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain)NSMutableArray *data;
@end
