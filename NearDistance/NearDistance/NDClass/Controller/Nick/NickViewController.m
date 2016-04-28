//
//  NickViewController.m
//  NearDistance
//
//  Created by 李世超 on 15/10/10.
//  Copyright (c) 2015年 李世超. All rights reserved.
//

#import "NickViewController.h"
#import "BlockButton.h"
#import "NDMyViewController.h"

@interface NickViewController ()

@end

@implementation NickViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    NSData *hunterData = MEMBER;
    _memberModel = [NSKeyedUnarchiver unarchiveObjectWithData:hunterData];
    _nickTextField.text = _memberModel.nickname;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [super setNavigationTitle:@"昵称"];
    self.view.backgroundColor = kUIColorFromRGB(BGGRAY);
    [self _initRightSave];
}

#pragma mark - 右边保存
- (void)_initRightSave
{
    BlockButton *saveButton = [[BlockButton alloc] initWithFrame:CGRectMake(0, 0, 45, 30) title:@"保存"];
    [saveButton setBlock:^(BlockButton *button){
        if (_nickTextField.text.length==0) {
            [CommonUtil NotiTip:@"昵称不能为空" color:TIP_COLOR];
        }else{
            [self httpUpdateNick:_nickTextField.text userID:MID];
        }
    }];
    UIBarButtonItem *saveBar = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
    self.navigationItem.rightBarButtonItem = saveBar;
}

#pragma mark - textField delgate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - textField监听字符
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *new = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSInteger res = 16-[new length];
    if(res >= 0){
        return YES;
    }else{
        if (res<0) {
            _nickTextField.text = [new substringToIndex:16];
            return NO;
        }
        return NO;
    }
}

#pragma mark - 改变昵称.
- (IBAction)editChange:(id)sender {
    _nickName = _nickTextField.text;
}

#pragma mark - 修改昵称
- (void)httpUpdateNick:(NSString *)nick userID:(NSString *)userID
{
    app.httpUrl = [NSString stringWithFormat:AF_NICKNAME_URL,AF_WEBURL,userID,nick];
    app.httpUrl = [app.httpUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[[HttpAFNetworing shareInstance] httpMgr] GET:app.httpUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        app.resObject = (NSDictionary *)responseObject;
        if ([AF_CODE isEqualToString:@"1"]) {
            [self httpResonseNick:nick];
        }else{
            [CommonUtil NotiTip:AF_MSG color:WARNNING_COLOR];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"=====failure %@",error);
        [CommonUtil NotiTip:RequestTimeOut color:TIP_COLOR];
    }];
}

#pragma mark - 修改昵称返回数据处理
- (void)httpResonseNick:(NSString *)nick
{
    _memberModel.nickname = nick;
    [CommonUtil userDefaultModel:_memberModel modelKey:@"member_session"];
    NDMyViewController *myCtrl = (NDMyViewController *)[CommonUtil popCtrl:self count:2];
    myCtrl.isNick = @"update";
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 内存警告⚠️
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
