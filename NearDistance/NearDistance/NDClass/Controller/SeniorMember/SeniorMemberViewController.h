//
//  SeniorMemberViewController.h
//  NearDistance
//
//  Created by 李世超 on 15/10/16.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseViewController.h"
#import "SeniorTableView.h"
#import "AreaModel.h"

@interface SeniorMemberViewController : NDBaseViewController
{
    MJRefreshHeaderView *_header;
}
@property (nonatomic,retain) NSString *refreshTop;
@property (nonatomic,retain) AreaModel *areaModel;
@property (nonatomic,retain) NSMutableArray *areaArray;
@property (weak, nonatomic) IBOutlet SeniorTableView *seniorTableView;
@end
