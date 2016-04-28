//
//  SeniorTableView.h
//  NearDistance
//
//  Created by 李世超 on 15/10/16.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseTableView.h"
#import "SeniorCell.h"
#import "AreaModel.h"

@interface SeniorTableView : NDBaseTableView

@property (nonatomic,retain) AreaModel *areaModel;
@property (nonatomic,retain) SeniorCell *seniorCell;
@end
