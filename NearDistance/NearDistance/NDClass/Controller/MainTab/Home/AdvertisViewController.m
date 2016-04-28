//
//  AdvertisViewController.m
//  NearDistance
//
//  Created by 李世超 on 15/10/28.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "AdvertisViewController.h"

@interface AdvertisViewController ()

@end

@implementation AdvertisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super setNavigationTitle:@"详情"];
    
    self.advertisWebView.autoresizesSubviews = YES;//自动调整大小
    self.advertisWebView.scalesPageToFit =YES;//自动对页面进行缩放以适应屏幕
    [self _initMJRefresh:self.advertisWebView.scrollView];
    [self _hederFooterMJRefresh];
    [self loadHttpUrl];
}

#pragma mark - 请求url
-(void)loadHttpUrl
{
    [CommonUtil NavigationLoading:self.view];
    NSURL *url = [NSURL URLWithString:_advertisUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self.advertisWebView loadRequest:request];
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
    __unsafe_unretained AdvertisViewController *district = self;
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
