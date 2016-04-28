//
//  HouseMessageViewController.h
//  NearDistance
//
//  Created by 李世超 on 15/10/14.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseViewController.h"
#import "HouseMessTableView.h"
#import "VillageNewsModel.h"

@interface HouseMessageViewController : NDBaseViewController
{
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
}
@property (nonatomic,retain) NSMutableArray *newsArray;
@property (nonatomic,retain) VillageNewsModel *newsModel;
@property (nonatomic,retain) NSString *refreshTop;
@property (weak, nonatomic) IBOutlet HouseMessTableView *houseMessTable;
@end
