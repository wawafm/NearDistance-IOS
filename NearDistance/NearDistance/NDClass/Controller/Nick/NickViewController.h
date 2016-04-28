//
//  NickViewController.h
//  NearDistance
//
//  Created by 李世超 on 15/10/14.
//  Copyright (c) 2015年 李世超. All rights reserved.
//

#import "NDBaseViewController.h"
#import "MemberInfoModel.h"

@interface NickViewController : NDBaseViewController

@property (nonatomic,retain) MemberInfoModel *memberModel;
@property (strong, nonatomic) IBOutlet UITextField *nickTextField;
@property (nonatomic, retain) NSString *nickName;
- (IBAction)editChange:(id)sender;
@end
