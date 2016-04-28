//
//  CityListViewController.h
//  NearDistance
//
//  Created by 李世超 on 15/10/16.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseViewController.h"
#import "CityTableView.h"

@interface CityListViewController : NDBaseViewController

@property (nonatomic,strong) NSString *province;
@property (weak, nonatomic) IBOutlet CityTableView *cityTableView;
@property (nonatomic,retain) NSMutableArray *citiesArray;
@end
