//
//  HouseRentViewController.h
//  NearDistance
//
//  Created by 李世超 on 15/10/14.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseViewController.h"
#import "HouseRentTableView.h"

@interface HouseRentViewController : NDBaseViewController
{
    NSURLConnection *theConnection;
    MJRefreshHeaderView *_header;
}
@property (weak, nonatomic) IBOutlet HouseRentTableView *houseRentTable;
@property (weak, nonatomic) IBOutlet UIWebView *houseWebView;
@end
