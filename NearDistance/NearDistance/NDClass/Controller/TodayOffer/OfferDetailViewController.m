//
//  OfferDetailViewController.m
//  NearDistance
//
//  Created by 李世超 on 15/10/12.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "OfferDetailViewController.h"

@interface OfferDetailViewController ()

@end

@implementation OfferDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self.popTag isEqualToString:@"pop"]) {
        [USERDEFAULT setObject:@"offerDetail" forKey:@"offer_detail"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [super setNavigationTitle:@"团购详情"];
    [self _initMJRefresh:self.offerWebView.scrollView];
    [self _hederFooterMJRefresh];
    [self loadOfferHttpUrl];
    [self xibHeight];
}

- (void)xibHeight
{
    if (iPhone6) {
        self.offerWebView.height = ScreenHeight-NAVIGATIONHEIGHT;
    }
    if (iPhone5||IPhone5S) {
        self.offerWebView.height = ScreenHeight+IP5TARBBARHEIGHT;
        if (iPhone4) {
            self.offerWebView.height = ScreenHeight+NAVIGATIONHEIGHT+TABBAR_HEIGHTG;
        }
    }
}

#pragma mark - 请求url
-(void)loadOfferHttpUrl
{
    [CommonUtil NavigationLoading:self.view];
    NSURL *url = [NSURL URLWithString:self.dealUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self.offerWebView loadRequest:request];
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
    __unsafe_unretained OfferDetailViewController *offerDetail = self;
    _header.beginRefreshingBlock =  ^(MJRefreshBaseView *refreshView) {
        [offerDetail loadOfferHttpUrl];
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
