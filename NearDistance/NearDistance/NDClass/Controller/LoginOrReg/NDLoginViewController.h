//
//  NDLoginViewController.h
//  NearDistance
//
//  Created by wawa on 15/10/10.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseViewController.h"
#import "NDTabBarController.h"
#import "MemberInfoModel.h"
#import "KIProgressViewManager.h"
#import "HyTransitions.h"
#import "HyLoglnButton.h"

@interface NDLoginViewController : NDBaseViewController<UITextFieldDelegate>
{
    NSTimer *timer;
}
@property (weak, nonatomic) IBOutlet HyLoglnButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (nonatomic,copy) NSString *phoneText;
@property (nonatomic,copy) NSString *pwdText;
@property (nonatomic,retain) MemberInfoModel *memberInfoModel;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passTextField;

- (IBAction)registerAction:(id)sender;
- (IBAction)forgetPwdAction:(id)sender;
@end
