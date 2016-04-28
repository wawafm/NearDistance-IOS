//
//  OfferDetailViewController.h
//  NearDistance
//
//  Created by 李世超 on 15/10/12.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseViewController.h"

@interface OfferDetailViewController : NDBaseViewController
{
    NSURLConnection *theConnection;
    MJRefreshHeaderView *_header;
}
@property (nonatomic,retain) NSString *popTag;
@property (nonatomic,retain) NSString *dealUrl;
@property (weak, nonatomic) IBOutlet UIWebView *offerWebView;
@end
