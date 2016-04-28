//
//  CostQueryViewController.h
//  NearDistance
//
//  Created by 李世超 on 15/10/14.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseViewController.h"
#import "CostQueryTableView.h"
#import "CostQueryModel.h"

@interface CostQueryViewController : NDBaseViewController

@property (nonatomic,retain) CostQueryModel *costModel;
@property (nonatomic,retain) NSMutableArray *costArray;
@property (weak, nonatomic) IBOutlet CostQueryTableView *costTableView;
@end
