//
//  HouseRentViewController.m
//  NearDistance
//
//  Created by 李世超 on 15/10/14.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "HouseRentViewController.h"

@interface HouseRentViewController ()

@end

@implementation HouseRentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super setNavigationTitle:@"房屋租赁"];
    [self _initMJRefresh:self.houseWebView.scrollView];
    [self _hederFooterMJRefresh];
    [self loadHttpUrl];
}

#pragma mark - 请求url
-(void)loadHttpUrl
{
    [CommonUtil NavigationLoading:self.view];
    NSURL *url = [NSURL URLWithString:AF_RENT_URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self.houseWebView loadRequest:request];
}

#pragma mark - 请求失败
- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
    [self performSelector:@selector(reloadDeals) withObject:nil afterDelay:0.5];
}
#pragma mark - 请求完成
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self performSelector:@selector(reloadDeals) withObject:nil afterDelay:0.5];
}

#pragma mark - webView delegate
- (void) webViewDidFinishLoad:(UIWebView *)webView {
    [self performSelector:@selector(reloadDeals) withObject:nil afterDelay:0.5];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self performSelector:@selector(reloadDeals) withObject:nil afterDelay:0.5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - 商圈下拉刷新
- (void)_hederFooterMJRefresh
{
    __unsafe_unretained HouseRentViewController *district = self;
    _header.beginRefreshingBlock =  ^(MJRefreshBaseView *refreshView) {
        [district loadHttpUrl];
    };
//    [_header beginRefreshing];
}

#pragma mark - MJRefresh reloadDeals
- (void)reloadDeals
{
    [_header endRefreshing];
    [[KIProgressViewManager manager] hideProgressView];
}
@end
