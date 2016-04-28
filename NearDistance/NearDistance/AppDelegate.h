//
//  AppDelegate.h
//  NearDistance
//
//  Created by 李世超 on 15/9/28.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemberInfoModel.h"
#import <PgySDK/PgyManager.h>
#import <PgyUpdate/PgyUpdateManager.h>

#define PGY_APPKEY @"b7a4e4ec50ef0006c765b5544ff5c647"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic,retain) MemberInfoModel *memberInfoModel;

@property (nonatomic,retain) NSDictionary *resObject;
@property (nonatomic,retain) NSString *code;
@property (nonatomic,retain) NSString *msg;
@property (nonatomic,retain) NSString *tip;
@property (nonatomic,retain) UIColor *tipColor;
@property (nonatomic,retain) NSString *httpUrl;
@property (nonatomic,assign) int      pageIndex;
@property (strong, nonatomic) UIWindow *window;

@end

