//
//  YearTableView.h
//  NearDistance
//
//  Created by 李世超 on 15/10/16.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseTableView.h"
#import "CityCell.h"

@interface CityTableView : NDBaseTableView
@property (nonatomic,retain) NSString *province;
@property (nonatomic,retain) NSMutableArray *cityArray;
@property (nonatomic,retain) CityCell *cityCell;
@end
