//
//  YearCell.h
//  NearDistance
//
//  Created by 李世超 on 15/10/16.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YearCell : UITableViewCell
@property (nonatomic,retain) NSString *date;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
@end
