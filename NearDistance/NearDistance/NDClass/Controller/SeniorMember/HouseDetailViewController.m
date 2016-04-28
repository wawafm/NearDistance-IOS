//
//  HouseViewController.m
//  NearDistance
//
//  Created by 李世超 on 15/10/19.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "HouseDetailViewController.h"
#import "NDMyViewController.h"

@interface HouseDetailViewController ()

@end

@implementation HouseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [super setNavigationTitle:@"选择房号"];
    self.houseDetailTable.data = _roomArray;
    self.houseDetailTable.roomDelegate = self;
    [self.houseDetailTable reloadData];
}

- (void)roomID:(NSString *)roomID
{
    CustomDialogView *dialog = [[CustomDialogView alloc]initWithTitle:@"提示" message:@"确定绑定当前房号吗？" buttonTitles:@"确定",@"取消", nil];
    [dialog showWithCompletion:^(NSInteger selectIndex) {
        NSLog(@"action selected %ld",selectIndex);
        if (selectIndex==0) {
            [self httpBindArea:roomID];
        }
    }];
}

#pragma mark - 绑定区域信息
- (void)httpBindArea:(NSString *)roomID
{
    NSString *mobile = [USERDEFAULT objectForKey:@"member_mobile"];
    app.httpUrl = [NSString stringWithFormat:AF_CREATEBIND_URL,AF_WEBURL,MID,mobile,self.houseID,self.villageID,roomID];
    NSLog(@"area:%@",app.httpUrl);
    [[[HttpAFNetworing shareInstance] httpMgr] GET:app.httpUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        app.code = [responseObject objectForKey:@"code"];
        app.msg = [responseObject objectForKey:@"msg"];
        if ([app.code isEqualToString:@"1"]) {
            [CommonUtil NotiTip:app.msg color:TIP_COLOR];
            NDMyViewController *myCtrl = (NDMyViewController *)[CommonUtil popCtrl:self count:4];
            myCtrl.isBind = @"bind";
            NSData *hunterData = MEMBER;
            _memberModel = [NSKeyedUnarchiver unarchiveObjectWithData:hunterData];
            _memberModel.address = [responseObject objectForKey:@"id"];
            [CommonUtil userDefaultModel:_memberModel modelKey:@"member_session"];
            [self.navigationController popToViewController:myCtrl animated:YES];
        }else{
            [CommonUtil NotiTip:app.msg color:WARNNING_COLOR];
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
