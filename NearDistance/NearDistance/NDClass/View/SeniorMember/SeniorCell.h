//
//  SeniorCell.h
//  NearDistance
//
//  Created by 李世超 on 15/10/16.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AreaModel.h"

@interface SeniorCell : UITableViewCell

@property (nonatomic,retain) AreaModel *areaModel;

@property (weak, nonatomic) IBOutlet UILabel *propertyLabel;

@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
@end
