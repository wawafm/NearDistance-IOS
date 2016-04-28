//
//  HomeTableView.h
//  NearDistance
//
//  Created by 李世超 on 15/10/10.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseTableView.h"
#import "FunctionView.h"
#import "HomeCell.h"
#import "DealModel.h"
#import "ShopModel.h"

@interface HomeTableView : NDBaseTableView

@property (nonatomic,retain) FunctionView *funView;
@property (nonatomic,retain) NSMutableArray *shopArray;
@property (nonatomic,retain) ShopModel *shopModel;
@property (nonatomic,retain) DealModel *dealModel;
@property (nonatomic,retain)HomeCell *homeCell;
@end
