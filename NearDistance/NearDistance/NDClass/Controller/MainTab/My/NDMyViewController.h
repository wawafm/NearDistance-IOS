//
//  NDMyViewController.h
//  NearDistance
//
//  Created by wawa on 15/10/8.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseViewController.h"
#import "MyTableView.h"
#import "MyHeaderView.h"
#import "HYActivityView.h"
#import "MemberInfoModel.h"

@interface NDMyViewController : NDBaseViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,MyTableDelegate>
{
    NSData *imageData;
    UIImagePickerController *imagePickerController;
}
@property (nonatomic,retain) NSString *isBind;
@property (nonatomic,retain) MemberInfoModel *memberModel;
@property (nonatomic,retain) NSString *faceImgUrl;
@property (nonatomic,copy) NSString *isNick;
@property (nonatomic,assign)int sourceType;
@property (nonatomic, retain)HYActivityView *activityView;
@property (weak, nonatomic) IBOutlet MyTableView *myTableView;
@property (nonatomic,retain) MyHeaderView *headerView;
@end
