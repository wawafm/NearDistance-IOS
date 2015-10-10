//
//  NDDistrictViewController.h
//  NearDistance
//
//  Created by wawa on 15/10/8.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseViewController.h"

@interface NDDistrictViewController : NDBaseViewController
{
    NSURLConnection *theConnection;
    MJRefreshHeaderView *_header;
}
@property (weak, nonatomic) IBOutlet UIWebView *districtWebView;
@end
