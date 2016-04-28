//
//  NDLoginViewController.m
//  NearDistance
//
//  Created by wawa on 15/10/10.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDLoginViewController.h"
#import "NDRegistViewController.h"
#import "CDPMonitorKeyboard.h"//引入头文件

@interface NDLoginViewController ()<UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UIView *phoneLine;

@property (weak, nonatomic) IBOutlet UIView *pwdLine;


@end

@implementation NDLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _phoneText = [USERDEFAULT objectForKey:@"member_mobile"];
        _pwdText = [USERDEFAULT objectForKey:@"member_pwd"];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    self.phoneTextField.text = _phoneText;
    self.passTextField.text = _pwdText;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self keyBoradAndButton];
}

#pragma mark - 键盘监听事件 登录animation
- (void)keyBoradAndButton
{
    [[CDPMonitorKeyboard defaultMonitorKeyboard] sendValueWithSuperView:self.view higherThanKeyboard:0 andMode:CDPMonitorKeyboardDefaultMode navigationControllerTopHeight:0];
    [self.loginButton spinerAnimation];
    [[CommonViews shareInstance] isAutoLayout:self.loginButton regView:self.registerButton codeView:nil];
    [self.loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 登录action
- (void)loginAction:(HyLoglnButton *)sender {
    [self loginValue:sender];
}

#pragma mark - 登录判断
- (void)loginValue:(HyLoglnButton *)logButton
{
    [_phoneTextField resignFirstResponder];
    [_passTextField resignFirstResponder];
    BOOL isMatch = [[CommonUtil shareInstance] regexPhone:_phoneTextField.text];
    if (_phoneTextField.text.length==0) {
        app.tip = EMPTY_PHONE;
        [self loginError:logButton];
    }else if (!isMatch){
        app.tip = ISMATCH_PHONE;
        [self loginError:logButton];
    }else if (_passTextField.text.length==0){
        app.tip = EMPTY_PWD;
        [self loginError:logButton];
    }else{
        [self httpLoginUser:_phoneTextField.text pwd:_passTextField.text button:logButton];
    }
}

#pragma mark - 用户登录
- (void)httpLoginUser:(NSString *)phone pwd:(NSString *)pwd button:(HyLoglnButton *)logButton
{
    app.httpUrl = [NSString stringWithFormat:AF_LOGINUSER_URL,AF_WEBURL,phone,pwd];
    [[[HttpAFNetworing shareInstance] httpMgr] GET:app.httpUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        app.code = [responseObject objectForKey:@"code"];
        app.msg = [responseObject objectForKey:@"msg"];
        if ([app.code isEqualToString:@"1"]) {
            [self httpResponseData:phone pwd:pwd resObject:responseObject];
        }else{
            [self LoginErrorButton:logButton];
            [CommonUtil NotiTip:app.msg color:WARNNING_COLOR];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self LoginErrorButton:logButton];
        [CommonUtil NotiTip:RequestTimeOut color:TIP_COLOR];
    }];
}

#pragma mark - 响应数据处理
- (void)httpResponseData:(NSString *)phone pwd:(NSString *)pwd resObject:(id )resObject
{
    [USERDEFAULT setObject:phone forKey:@"member_mobile"];
    [USERDEFAULT setObject:pwd forKey:@"member_pwd"];
    NSDictionary *dict = [resObject objectForKey:@"memberinfo"];
    _memberInfoModel = [MemberInfoModel memberInfo:dict];
    [USERDEFAULT setObject:_memberInfoModel.mid forKey:@"M_ID"];
    [CommonUtil userDefaultModel:_memberInfoModel modelKey:@"member_session"];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(loginSuccess:) userInfo:nil repeats:NO];
}

#pragma mark - 登录成功
- (void)loginSuccess:(NSTimer *)timer
{
    [self LoginSuccButton:self.loginButton];
}

#pragma mark - 注册
- (IBAction)registerAction:(id)sender {
    NDRegistViewController *registerCtrl = [[NDRegistViewController alloc] init];
    registerCtrl.registerOrReset = @"register";
    [self.navigationController pushViewController:registerCtrl animated:YES];
}

#pragma mark - 重置密码
- (IBAction)forgetPwdAction:(id)sender {
    NDRegistViewController *registerCtrl = [[NDRegistViewController alloc] init];
    registerCtrl.registerOrReset = @"reset";
    [self.navigationController pushViewController:registerCtrl animated:YES];
}

#pragma mark - textField delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return [[CommonViews shareInstance] textField:textField string:string view:self.view range:range];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField.returnKeyType==UIReturnKeyNext){
        [_passTextField becomeFirstResponder];
    }else if (textField.returnKeyType==UIReturnKeyDone){
        [_passTextField resignFirstResponder];
    }
    return YES;
}

//点击空白处结束编辑状态
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - 网络正常 或者是密码账号正确跳转动画
-(void)LoginSuccButton:(HyLoglnButton *)button
{
    typeof(self) __weak weak = self;
    [button ExitAnimationCompletion:^{
        [weak LoginPresentController];
    }];
}

#pragma mark - 网络错误 或者是密码不正确还原动画
-(void)LoginErrorButton:(HyLoglnButton *)button
{
    typeof(self) __weak weak = self;
    [button ErrorRevertAnimationCompletion:^{
        [weak LoginPresentController];
    }];
}

- (void)loginError:(HyLoglnButton *)button
{
    [self LoginErrorButton:button];
    [CommonUtil NotiTip:app.tip color:TIP_COLOR];
}

#pragma mark - 跳转action
- (void)LoginPresentController
{
    NDTabBarController *tabBarCtrl = [[NDTabBarController alloc] init];
    tabBarCtrl.transitioningDelegate = self;
    [self presentViewController:tabBarCtrl animated:YES completion:nil];
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
