//
//  MyHeaderView.h
//  NearDistance
//
//  Created by 李世超 on 15/10/14.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemberInfoModel.h"

@interface MyHeaderView : UIView

@property (nonatomic,copy) NSString *faceImgUrl;
@property (nonatomic,copy) NSString *nickName;
@property (nonatomic,retain) MemberInfoModel *memberInfoModel;
@property (weak, nonatomic) IBOutlet UILabel *borderLabel;

@property (weak, nonatomic) IBOutlet UIImageView *faceImg;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;


- (void)nickAssigment;
@end
