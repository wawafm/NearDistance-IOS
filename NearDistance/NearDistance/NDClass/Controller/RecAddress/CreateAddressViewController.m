//
//  CreateAddressViewController.m
//  NearDistance
//
//  Created by 李世超 on 15/10/14.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "CreateAddressViewController.h"
#import "ProvinceViewController.h"
#import "CDPMonitorKeyboard.h"//引入头文件
#import "RecAddressViewController.h"
#import "BlockButton.h"

@interface CreateAddressViewController ()

@end

@implementation CreateAddressViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_cityText.length!=0) {
        self.cityLabel.text = _cityText;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [super setNavigationTitle:@"创建收货地址"];
    
    //此模式输入视图在主视图上，superView传self.view
    [[CDPMonitorKeyboard defaultMonitorKeyboard] sendValueWithSuperView:self.view higherThanKeyboard:0 andMode:CDPMonitorKeyboardDefaultMode navigationControllerTopHeight:0];
    
    [self saveAddressInfo];
    [self _assigmentXib];
}

#pragma mark - 修改地址赋值
- (void)_assigmentXib
{
    _nameTextField.text = _addressModel.userName;
    _phoneTextField.text = _addressModel.userPhone;
    _cityLabel.text = _addressModel.city;
    _addressTextView.text = _addressModel.address;
    _zipCodeTextField.text = _addressModel.zipCode;
}

#pragma mark - 保存地址信息
- (void)saveAddressInfo
{
    BlockButton *saveButton = [[BlockButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30) title:@"保存"];
    [saveButton setBlock:^(BlockButton *button){
        [self saveHttpAddress];
    }];
    UIBarButtonItem *sendBar = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
    self.navigationItem.rightBarButtonItem = sendBar;
}

#pragma mark - 保存
- (void)saveHttpAddress
{
    [self resFirstResponder];
    if (_addressModel!=nil) {
        if (_cityText.length==0) {
            _cityText = _addressModel.city;
        }
        [self httpUpdateAddress:_nameTextField.text phone:_phoneTextField.text provice:_cityText address:_addressTextView.text zipCode:_zipCodeTextField.text];
    }else{
        if (_nameText.length==0) {
            app.tip = EMPTY_NAME;
            app.tipColor = TIP_COLOR;
            [CommonUtil NotiTip:app.tip color:app.tipColor];
        }else if (_phoneText.length==0){
            app.tip = EMPTY_PHONE;
            app.tipColor = TIP_COLOR;
            [CommonUtil NotiTip:app.tip color:app.tipColor];
        }else if (_cityText.length==0){
            app.tip = EMPTY_CITY;
            app.tipColor = TIP_COLOR;
            [CommonUtil NotiTip:app.tip color:app.tipColor];
        }else if (_addressTextView.text.length==0){
            app.tip = EMPTY_ADDRESS;
            app.tipColor = TIP_COLOR;
            [CommonUtil NotiTip:app.tip color:app.tipColor];
        }else{
            [self httpCreateAddress:_nameText phone:_phoneText provice:_cityText address:_addressTextView.text zipCode:_zipCodeText];
        }
    }
}

#pragma mark - 键盘消失
- (void)resFirstResponder
{
    [_nameTextField resignFirstResponder];
    [_phoneTextField resignFirstResponder];
    [_addressTextView resignFirstResponder];
    [_zipCodeTextField resignFirstResponder];
}

#pragma mark - 触摸视图键盘消失
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - textField delegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag==10) {
        _nameText = textField.text;
    }else if (textField.tag==11){
        _phoneText = textField.text;
    }else if (textField.tag==13){
        _zipCodeText = textField.text;
    }
}

//输入框字数和输入字符限制
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHANUM] invertedSet];
    //限制输入6位数字
    if ([string isEqualToString:@"\n"]){
        return YES;
    }
    NSString * aString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    UITextField *text = (UITextField *)[self.view viewWithTag:11];
    if (text == textField) {
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUM] invertedSet];
        if ([aString length] > 11) {
            return NO;
        }
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    
    return YES;
}

#pragma mark -城市tap
- (IBAction)cityTapAction:(id)sender {
    ProvinceViewController *provinceCtrl = [[ProvinceViewController alloc] init];
    [self.navigationController pushViewController:provinceCtrl animated:YES];
}

#pragma mark - 创建收货地址
- (void)httpCreateAddress:(NSString *)name phone:(NSString *)phone provice:(NSString *)province address:(NSString *)address zipCode:(NSString *)zipCode
{
    app.httpUrl = [NSString stringWithFormat:AF_ADDRESS_URL,AF_WEBURL,name,phone,province,address,zipCode,MID];
    app.httpUrl = [app.httpUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[[HttpAFNetworing shareInstance] httpMgr] GET:app.httpUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        app.resObject = (NSDictionary *)responseObject;
        if ([AF_CODE isEqualToString:@"1"]) {
            RecAddressViewController *recAddress = (RecAddressViewController *)[CommonUtil popCtrl:self count:2];
            recAddress.isAddAddress = @"addAddress";
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [CommonUtil NotiTip:AF_MSG color:WARNNING_COLOR];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"=====failure %@",error);
        [CommonUtil NotiTip:RequestTimeOut color:TIP_COLOR];
    }];
}

#pragma mark - 修改收货地址
- (void)httpUpdateAddress:(NSString *)name phone:(NSString *)phone provice:(NSString *)province address:(NSString *)address zipCode:(NSString *)zipCode
{
    app.httpUrl = [NSString stringWithFormat:AF_UPDATEADDRESSS_URL,AF_WEBURL,name,phone,province,address,zipCode,MID,_addressModel.addressID];
    app.httpUrl = [app.httpUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"updateAddres:%@",app.httpUrl);
    [[[HttpAFNetworing shareInstance] httpMgr] GET:app.httpUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        app.resObject = (NSDictionary *)responseObject;
        if ([AF_CODE isEqualToString:@"1"]) {
            RecAddressViewController *recAddress = (RecAddressViewController *)[CommonUtil popCtrl:self count:2];
            recAddress.isAddAddress = @"addAddress";
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [CommonUtil NotiTip:AF_MSG color:WARNNING_COLOR];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"=====failure %@",error);
        [CommonUtil NotiTip:RequestTimeOut color:TIP_COLOR];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
