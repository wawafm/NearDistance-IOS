//
//  AboutViewController.h
//  NearDistance
//
//  Created by 李世超 on 15/10/16.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseViewController.h"

@interface AboutViewController : NDBaseViewController
{
    NSURLConnection *theConnection;
    MJRefreshHeaderView *_header;
}
@property (weak, nonatomic) IBOutlet UIWebView *aboutWebView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@end
