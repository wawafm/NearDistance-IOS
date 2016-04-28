//
//  NDRegistViewController.m
//  NearDistance
//
//  Created by wawa on 15/10/14.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDRegistViewController.h"
#import "CDPMonitorKeyboard.h"//引入头文件
#import "NDLoginViewController.h"
#import "BlockButton.h"

@interface NDRegistViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation NDRegistViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        secondsCountDown = 60;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self keyBoardAndButton];
}

#pragma mark - 键盘监听事件 返回 登录
- (void)keyBoardAndButton
{
    //此模式输入视图在主视图上，superView传self.view
    [[CDPMonitorKeyboard defaultMonitorKeyboard] sendValueWithSuperView:self.registerView higherThanKeyboard:0 andMode:CDPMonitorKeyboardDefaultMode navigationControllerTopHeight:0];
    
    //返回button
    BlockButton *button = [[BlockButton alloc] initWithFrame:CGRectMake(15, 30, 45, 25) title:@"返回"];
    [button setBlock:^(BlockButton *button){
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.view addSubview:button];
    
    
    if ([self.registerOrReset isEqualToString:@"register"]) {
        [self.registerButton setTitle:@"注册" forState:UIControlStateNormal];
    }else{
        [self.registerButton setTitle:@"重置密码" forState:UIControlStateNormal];
    }
    [self.registerButton spinerAnimation];
    [[CommonViews shareInstance] isAutoLayout:nil regView:self.registerButton codeView:self.codeButton];
    [self.registerButton addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 注册action
- (void)registerAction:(HyLoglnButton *)sender {
    [self registerValue:sender];
}

#pragma mark - 获取验证码
- (IBAction)getCodeAction:(id)sender {
    [_phoneTextField resignFirstResponder];
    BOOL isMatch = [[CommonUtil shareInstance] regexPhone:_phoneTextField.text];
    if (_phoneTextField.text.length==0) {
        [CommonUtil NotiTip:EMPTY_PHONE color:TIP_COLOR];
    }else if (!isMatch){
        [CommonUtil NotiTip:ISMATCH_PHONE color:TIP_COLOR];
    }else{
        countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timeFireAction) userInfo:nil repeats:YES];
        [self httpGetCode:_phoneTextField.text];
    }
}

#pragma mark-actions 计时器
- (void)timeFireAction
{
    secondsCountDown --;
    if (secondsCountDown == 0) {
        secondsCountDown = 60;
        [countDownTimer invalidate];
        _codeButton.width = 67.0f;
        _codeButton.left = _codeTextField.right+9;
        _codeButton.userInteractionEnabled = YES;
        [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_codeButton addTarget:self action:@selector(getCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        _codeButton.width = 80.0f;
        _codeButton.left = _codeTextField.right-3;
        _codeButton.userInteractionEnabled = NO;
        [_codeButton setTitle:[NSString stringWithFormat:@"%ld秒后重新获取",(long)secondsCountDown] forState:UIControlStateNormal];
    }
}

#pragma mark - 获取验证码
- (void)httpGetCode:(NSString *)phone
{
    [CommonUtil NavigationLoading:self.view];
    app.httpUrl = [NSString stringWithFormat:AF_SMSSEND_URL,AF_WEBURL,phone];
    [[[HttpAFNetworing shareInstance] httpMgr] GET:app.httpUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        app.code = [responseObject objectForKey:@"code"];
        app.msg = [responseObject objectForKey:@"msg"];
        if ([app.code isEqualToString:@"1"]) {
            [CommonUtil NotiTip:app.msg color:SUCCESS_COLOR];
        }else{
            [CommonUtil NotiTip:app.msg color:WARNNING_COLOR];
        }
        [[KIProgressViewManager manager] hideProgressView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"=====failure %@",error);
        [CommonUtil NotiTip:RequestTimeOut color:TIP_COLOR];
        [[KIProgressViewManager manager] hideProgressView];
    }];
}

#pragma mark -注册判断
- (void)registerValue:(HyLoglnButton *)regButton
{
    [self regisnFirstResponder];
    BOOL isMatch = [[CommonUtil shareInstance] regexPhone:_phoneTextField.text];
    if (!isMatch) {
        app.tip = ISMATCH_PHONE;
        [self registerError:self.registerButton];
    }else if (_phoneTextField.text.length==0) {
        app.tip = EMPTY_PHONE;
        [self registerError:self.registerButton];
    }else if (_codeTextField.text.length==0){
        app.tip = EMPTY_CODE;
        [self registerError:self.registerButton];
    }else if(_passTextField.text.length==0){
        app.tip = EMPTY_PWD;
        [self registerError:self.registerButton];
    }else{
        if ([self.registerOrReset isEqualToString:@"register"]) {
            [self httpRegisterUser:_phoneTextField.text pwd:_passTextField.text smsCode:_codeTextField.text];
        }else if ([self.registerOrReset isEqualToString:@"reset"]){
            [self httpResetUser:_phoneTextField.text pwd:_passTextField.text smsCode:_codeTextField.text];
        }
    }
}

#pragma mark - 注册用户
- (void)httpRegisterUser:(NSString *)phone pwd:(NSString *)pwd smsCode:(NSString *)smsCode
{
    app.httpUrl = [NSString stringWithFormat:AF_REGISTER_URL,AF_WEBURL,phone,pwd,smsCode];
    
    [[[HttpAFNetworing shareInstance] httpMgr] GET:app.httpUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        app.code = [responseObject objectForKey:@"code"];
        app.msg = [responseObject objectForKey:@"msg"];
        
        if ([app.code isEqualToString:@"1"]) {
            [self RegisterSuccButton:self.registerButton phone:phone pwd:pwd];
        }else{
            [CommonUtil NotiTip:app.msg color:WARNNING_COLOR];
            [self RegisterErrorButton:self.registerButton];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"=====failure %@",error);
        [self RegisterErrorButton:self.registerButton];
        [CommonUtil NotiTip:RequestTimeOut color:TIP_COLOR];
    }];
}

#pragma mark - 重置用户密码
- (void)httpResetUser:(NSString *)phone pwd:(NSString *)pwd smsCode:(NSString *)smsCode
{
    app.httpUrl = [NSString stringWithFormat:AF_RESETPWD_URL,AF_WEBURL,phone,pwd,smsCode];
    
    [[[HttpAFNetworing shareInstance] httpMgr] GET:app.httpUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        app.code = [responseObject objectForKey:@"code"];
        app.msg = [responseObject objectForKey:@"msg"];
        
        if ([app.code isEqualToString:@"1"]) {
            [CommonUtil NotiTip:app.msg color:SUCCESS_COLOR];
            [self RegisterSuccButton:self.registerButton phone:phone pwd:pwd];
        }else{
            [CommonUtil NotiTip:app.msg color:WARNNING_COLOR];
            [self RegisterErrorButton:self.registerButton];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [CommonUtil NotiTip:RequestTimeOut color:TIP_COLOR];
        [self RegisterErrorButton:self.registerButton];
    }];
    
}

#pragma mark - textField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    textField = [self.view viewWithTag:textField.tag];
    if(textField.returnKeyType==UIReturnKeyNext){//显示下一个
        if (textField.tag==10) {
            [_codeTextField becomeFirstResponder];
        }else{
            [_passTextField becomeFirstResponder];
        }
    }else if (textField.returnKeyType==UIReturnKeyDone){
        [_passTextField resignFirstResponder];
    }
    return YES;
}

#pragma mark - textField delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return [[CommonViews shareInstance] textField:textField string:string view:self.view range:range];
}

#pragma mark -键盘失去焦点
- (void)regisnFirstResponder
{
    [_phoneTextField resignFirstResponder];
    [_passTextField resignFirstResponder];
    [_codeTextField resignFirstResponder];
}

//点击空白处结束编辑状态
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.registerView endEditing:YES];
}

#pragma mark - 网络正常 或者是密码账号正确跳转动画
-(void)RegisterSuccButton:(HyLoglnButton *)button phone:(NSString *)phone pwd:(NSString *)pwd
{
    typeof(self) __weak weak = self;
    [button ExitAnimationCompletion:^{
        [weak popLoginViewController:phone pwd:pwd];
    }];
}

#pragma mark - 网络错误 或者是密码不正确还原动画
-(void)RegisterErrorButton:(HyLoglnButton *)button
{
    typeof(self) __weak weak = self;
    [button ErrorRevertAnimationCompletion:^{
        [weak popLoginViewController:nil pwd:nil];
    }];
}

- (void)registerError:(HyLoglnButton *)button
{
    [self RegisterErrorButton:button];
    [CommonUtil NotiTip:app.tip color:TIP_COLOR];
}

#pragma mark - 跳转action
- (void)popLoginViewController:(NSString *)phone pwd:(NSString *)pwd
{
    NDLoginViewController *loginCtrl = [[NDLoginViewController alloc] init];
    loginCtrl.phoneText = phone;
    loginCtrl.pwdText = pwd;
    loginCtrl.transitioningDelegate = self;
    [self presentViewController:loginCtrl animated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    
    return [[HyTransitions alloc]initWithTransitionDuration:0.4f StartingAlpha:0.5f isBOOL:true];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
    return [[HyTransitions alloc]initWithTransitionDuration:0.4f StartingAlpha:0.8f isBOOL:false];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
