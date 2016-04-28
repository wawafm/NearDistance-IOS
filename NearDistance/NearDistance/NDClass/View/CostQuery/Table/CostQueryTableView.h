//
//  CostQueryTableView.h
//  NearDistance
//
//  Created by 李世超 on 15/10/16.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseTableView.h"
#import "CostQueryCell.h"
#import "CostQueryModel.h"

@interface CostQueryTableView : NDBaseTableView

@property (nonatomic,retain) CostQueryModel *costModel;
@property (nonatomic,retain) CostQueryCell *costQuery;
@end
