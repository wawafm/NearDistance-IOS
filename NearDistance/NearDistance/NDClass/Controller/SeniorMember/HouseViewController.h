//
//  HouseViewController.h
//  NearDistance
//
//  Created by 李世超 on 15/10/19.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseViewController.h"
#import "HouseTableView.h"

@interface HouseViewController : NDBaseViewController

@property (nonatomic,retain) NSMutableArray *villageArray;
@property (nonatomic,copy) NSString *houseID;
@property (weak, nonatomic) IBOutlet HouseTableView *houseTable;
@end
