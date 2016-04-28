//
//  YearTableView.h
//  NearDistance
//
//  Created by 李世超 on 15/10/16.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseTableView.h"
#import "AreaCell.h"

@interface AreaTableView : NDBaseTableView
@property (nonatomic,retain) NSMutableArray *cityArray;
@property (nonatomic,retain) AreaCell *areaCell;
@property (nonatomic,retain) NSString *provinceCity;
@end
