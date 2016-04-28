//
//  SeniorMemberViewController.m
//  NearDistance
//
//  Created by 李世超 on 15/10/16.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "SeniorMemberViewController.h"

@interface SeniorMemberViewController ()

@end

@implementation SeniorMemberViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _areaArray = [NSMutableArray array];
    [super setNavigationTitle:@"选择物业"];
    
    [self _initMJRefresh:self.seniorTableView];
    [self _hederFooterMJRefresh];
    [self httpGetArea:nil];
}

#pragma mark - 获取物业
- (void)httpGetArea:(MJRefreshBaseView *)refreshView
{
    [CommonUtil NavigationLoading:self.view];
    app.httpUrl = [NSString stringWithFormat:AF_GETAREAS_URL,AF_WEBURL];
    NSLog(@"area:%@",app.httpUrl);
    [[[HttpAFNetworing shareInstance] httpMgr] GET:app.httpUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        app.code = [responseObject objectForKey:@"code"];
        app.msg = [responseObject objectForKey:@"msg"];
        if ([app.code isEqualToString:@"1"]) {
            [self httpResponseAreaData:responseObject];
        }else{
            [CommonUtil NotiTip:app.msg color:WARNNING_COLOR];
        }
        [self performSelector:@selector(reloadDeals) withObject:refreshView afterDelay:0.5];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"=====failure %@",error);
        [CommonUtil NotiTip:RequestTimeOut color:TIP_COLOR];
        [self performSelector:@selector(reloadDeals) withObject:refreshView afterDelay:0.5];
    }];
}

#pragma mark - area data
- (void)httpResponseAreaData:(id)responseObject
{
    if ([_refreshTop isEqualToString:@"downRefresh"]) {
        [_areaArray removeAllObjects];
    }
    id listObj = [responseObject objectForKey:@"list"];
    for (NSDictionary *dict in listObj) {
        _areaModel = [[AreaModel alloc] AreaModelWithDict:dict];
        [_areaArray addObject:_areaModel];
    }
    _seniorTableView.data = _areaArray;
    [_seniorTableView reloadData];
}

#pragma mark - 初始化刷新视图
- (void)_initMJRefresh:(UIScrollView *)srollView
{
    // 3.3行集成下拉刷新控件
    if (_header==nil) {
        _header = [MJRefreshHeaderView header];
        _header.backgroundColor = [UIColor clearColor];
        _header.scrollView = srollView;
    }
}

#pragma mark - 收货地址下拉刷新
- (void)_hederFooterMJRefresh
{
    __unsafe_unretained SeniorMemberViewController *recAddress = self;
    _header.beginRefreshingBlock =  ^(MJRefreshBaseView *refreshView) {
        [recAddress httpGetArea:refreshView];
        _refreshTop = @"downRefresh";
    };
//    [_header beginRefreshing];
}

#pragma mark - MJRefresh reloadDeals
- (void)reloadDeals
{
    [_header endRefreshing];
    [[KIProgressViewManager manager] hideProgressView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
