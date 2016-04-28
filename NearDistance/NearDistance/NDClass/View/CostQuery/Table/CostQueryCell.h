//
//  CostQueryCell.h
//  NearDistance
//
//  Created by 李世超 on 15/10/16.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CostQueryModel.h"

@interface CostQueryCell : UITableViewCell

@property (nonatomic,retain) CostQueryModel *costModel;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
@property (weak, nonatomic) IBOutlet UILabel *ownerLabel;
@property (weak, nonatomic) IBOutlet UILabel *houseLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *waterLabel;
@property (weak, nonatomic) IBOutlet UILabel *electricLabel;
@property (weak, nonatomic) IBOutlet UILabel *gasLabel;
@property (weak, nonatomic) IBOutlet UILabel *propertyLabel;
@property (weak, nonatomic) IBOutlet UILabel *parkingLabel;
@property (weak, nonatomic) IBOutlet UILabel *generLabel;
@property (weak, nonatomic) IBOutlet UILabel *lateFreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@end
