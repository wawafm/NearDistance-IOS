//
//  HouseMessageViewController.m
//  NearDistance
//
//  Created by 李世超 on 15/10/14.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "HouseMessageViewController.h"

@interface HouseMessageViewController ()

@end

@implementation HouseMessageViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *offer = [USERDEFAULT objectForKey:@"mess_detail"];
    if ([offer isEqualToString:@"messageDetail"]) {
        self.houseMessTable.height = ScreenHeight-NAVIGATIONHEIGHT;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _newsArray = [NSMutableArray array];
    
    [super setNavigationTitle:@"小区消息"];
    [self _initMJRefresh:self.houseMessTable];
    [self _hederFooterMJRefresh];
    [self httpHouseMessage:app.pageIndex refreshView:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [USERDEFAULT removeObjectForKey:@"mess_detail"];
}

#pragma mark - 小区消息
- (void)httpHouseMessage:(int)pageIndex refreshView:(MJRefreshBaseView *)refreshView;
{
    [CommonUtil NavigationLoading:self.view];
    [VillageNewsModel getVillageNewsList:pageIndex success:^(AFHTTPRequestOperation* operation, NSObject* result){
        app.resObject = (NSDictionary *)result;
        if ([AF_CODE isEqualToString:@"1"]) {
            [self httpResponseData:app.resObject];
        }else{
            [CommonUtil NotiTip:AF_MSG color:WARNNING_COLOR];
        }
        [self dismissRefresh];
    } failure:^(NSError* error){
        [CommonUtil NotiTip:RequestTimeOut color:TIP_COLOR];
        [self dismissRefresh];
    }];
}

#pragma mark - 响应数据处理
- (void)httpResponseData:(id)responseObject
{
    if ([_refreshTop isEqualToString:@"downRefresh"]) {
        [_newsArray removeAllObjects];
    }
    id resObject = [responseObject objectForKey:@"list"];
    for (NSDictionary *dict in resObject) {
        _newsModel = [[VillageNewsModel alloc] initWithDictionary:dict];
        [_newsArray addObject:_newsModel];
    }
    self.houseMessTable.data = _newsArray;
    [self.houseMessTable reloadData];
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
    if (_footer==nil) {
        _footer = [MJRefreshFooterView footer];
        _footer.backgroundColor = [UIColor clearColor];
        _footer.scrollView = srollView;
    }
}

#pragma mark - 下拉刷新
- (void)_hederFooterMJRefresh
{
    __unsafe_unretained HouseMessageViewController *interactCtrl = self;
    _header.beginRefreshingBlock =  ^(MJRefreshBaseView *refreshView) {
        
        interactCtrl.refreshTop = @"downRefresh";
        app.pageIndex = 1;
        
        [interactCtrl httpHouseMessage:app.pageIndex refreshView:refreshView];
    };
    //    [_header beginRefreshing];
    _footer.beginRefreshingBlock =  ^(MJRefreshBaseView *refreshView) {
        interactCtrl.refreshTop = @"upRefresh";
        app.pageIndex++;
        [interactCtrl httpHouseMessage:app.pageIndex refreshView:refreshView];
    };
}

#pragma mark - MJRefresh reloadDeals
- (void)reloadDeals
{
    [_header endRefreshing];
    [_footer endRefreshing];
    [[KIProgressViewManager manager] hideProgressView];
}

#pragma mark - 刷新消失
- (void)dismissRefresh
{
    [self performSelector:@selector(reloadDeals) withObject:nil afterDelay:0.5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
