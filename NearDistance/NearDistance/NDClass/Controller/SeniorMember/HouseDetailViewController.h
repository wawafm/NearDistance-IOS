//
//  HouseViewController.h
//  NearDistance
//
//  Created by 李世超 on 15/10/19.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseViewController.h"
#import "HouseDetailTableView.h"
#import "CustomDialogView.h"
#import "MemberInfoModel.h"

@interface HouseDetailViewController : NDBaseViewController<RoomDelegate>

@property (nonatomic,retain) MemberInfoModel *memberModel;
@property (nonatomic,retain) NSMutableArray *roomArray;
@property (nonatomic,retain) NSString *villageID;
@property (nonatomic,retain) NSString *houseID;
@property (weak, nonatomic) IBOutlet HouseDetailTableView *houseDetailTable;
@end
