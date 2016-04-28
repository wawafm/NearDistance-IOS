//
//  NDRegistViewController.h
//  NearDistance
//
//  Created by wawa on 15/10/14.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseViewController.h"
#import "HyLoglnButton.h"

@interface NDRegistViewController : NDBaseViewController<UITextFieldDelegate>
{
    NSTimer *countDownTimer;
    NSInteger secondsCountDown;
}
@property (weak, nonatomic) IBOutlet HyLoglnButton *registerButton;
@property (nonatomic,copy) NSString *registerOrReset;

@property (weak, nonatomic) IBOutlet UIView *registerView;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passTextField;
- (IBAction)getCodeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@end
