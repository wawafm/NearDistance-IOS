//
//  AreaViewController.h
//  NearDistance
//
//  Created by 李世超 on 15/10/16.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseViewController.h"
#import "AreaTableView.h"

@interface AreaViewController : NDBaseViewController

@property (nonatomic,strong) NSString *area;
@property (nonatomic,retain) NSMutableArray *areaArray;
@property (weak, nonatomic) IBOutlet AreaTableView *areaTableView;
@end
