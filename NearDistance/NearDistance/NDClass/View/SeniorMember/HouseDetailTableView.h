//
//  SeniorTableView.h
//  NearDistance
//
//  Created by 李世超 on 15/10/16.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseTableView.h"
#import "HouseDetailCell.h"
#import "RoomModel.h"

@protocol RoomDelegate <NSObject>
-(void)roomID:(NSString *)roomID;
@end

@interface HouseDetailTableView : NDBaseTableView

@property (nonatomic,retain) RoomModel *roomModel;
@property (nonatomic,retain) HouseDetailCell *houseCell;

@property (nonatomic ,assign) id<RoomDelegate>roomDelegate;
@end
