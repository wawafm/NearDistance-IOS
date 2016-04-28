//
//  SeniorCell.h
//  NearDistance
//
//  Created by 李世超 on 15/10/16.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VillageModel.h"

@interface HouseCell : UITableViewCell

@property (nonatomic,retain) VillageModel *villageModel;
@property (weak, nonatomic) IBOutlet UILabel *propertyLabel;

@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
@end
