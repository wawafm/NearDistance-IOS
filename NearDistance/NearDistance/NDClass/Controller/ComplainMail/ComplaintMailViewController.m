//
//  AdviceViewController.m
//  music
//
//  Created by 李世超 on 15/5/28.
//  Copyright (c) 2015年 李世超. All rights reserved.
//

#import "ComplaintMailViewController.h"
#import "BlockButton.h"

@interface ComplaintMailViewController ()

@end

@implementation ComplaintMailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kUIColorFromRGB(BGGRAY);
    [super setNavigationTitle:@"投诉信箱"];
    
    _textView.placeholder = @"写下您的投诉内容";
    _textView.placeholderFont = FONG_13;
    
//    [_textView becomeFirstResponder];
    _textView.returnKeyType = UIReturnKeySend;
    
    [self _initRightSend];
}

#pragma mark - 发送
- (void)_initRightSend
{
    BlockButton *sendButton = [[BlockButton alloc] initWithFrame:CGRectMake(0, 0, 45, 30) title:@"发送"];
    [sendButton setBlock:^(BlockButton *button){
        if ([_textView.text isEqualToString:@""]||_textView.text==nil) {
            [CommonUtil NotiTip:@"内容不能为空" color:TIP_COLOR];
        }else{
            [self httpComplaint:_textView.text];
        }
    }];
    
    UIBarButtonItem *sendBar = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
    self.navigationItem.rightBarButtonItem = sendBar;
}

#pragma mark - 投诉信箱
- (void)httpComplaint:(NSString *)content;
{
    [CommonUtil NavigationLoading:self.view];
    app.httpUrl = [NSString stringWithFormat:AF_COMPLAIN_URL,AF_WEBURL,content,MID];
    app.httpUrl = [app.httpUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"complaint:%@",app.httpUrl);
    [[[HttpAFNetworing shareInstance] httpMgr] GET:app.httpUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        app.resObject = (NSDictionary *)responseObject;
        if ([AF_CODE isEqualToString:@"1"]) {
            [CommonUtil NotiTip:AF_MSG color:SUCCESS_COLOR];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [CommonUtil NotiTip:AF_MSG color:WARNNING_COLOR];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"=====failure %@",error);
        [CommonUtil NotiTip:RequestTimeOut color:TIP_COLOR];
    }];
}

#pragma mark - UITextView delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    NSString *new = [textView.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger res = 140-[new length];
    _numberLabel.text = [NSString stringWithFormat:@"%d字",(int)res];
    
    if ([text isEqualToString:@"\n"])
    {
        if ([_textView.text isEqualToString:@""]||_textView.text==nil) {
            [CommonUtil NotiTip:@"内容不能为空" color:TIP_COLOR];
        }else{
            [self httpComplaint:_textView.text];
        }
        [textView resignFirstResponder];
    }
    if(res >= 0){
        return YES;
    }else{
        if (res<0) {
            _numberLabel.text = [NSString stringWithFormat:@"0字"];
            _textView.text = [new substringToIndex:140];
            return NO;
        }
        return NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
