//
//  AdvertisViewController.h
//  NearDistance
//
//  Created by 李世超 on 15/10/28.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseViewController.h"

@interface AdvertisViewController : NDBaseViewController
{
    NSURLConnection *theConnection;
    MJRefreshHeaderView *_header;
}
@property (nonatomic,retain) NSString *advertisUrl;
@property (weak, nonatomic) IBOutlet UIWebView *advertisWebView;
@end
