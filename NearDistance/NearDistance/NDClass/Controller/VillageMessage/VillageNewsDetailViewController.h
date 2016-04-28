//
//  VillageNewsDetailViewController.h
//  NearDistance
//
//  Created by 李世超 on 15/10/28.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseViewController.h"

@interface VillageNewsDetailViewController : NDBaseViewController

@property (nonatomic,retain) NSString *content;
@property (weak, nonatomic) IBOutlet UIWebView *newsWebView;
@end
